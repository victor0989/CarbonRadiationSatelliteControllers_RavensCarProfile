pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package body Gas_Control.Core is

   protected body Command_Port is
      procedure Write (C : Command) is
      begin
         Pending := C;
      end Write;
      procedure Read (C : out Command) is
      begin
         C := Pending;
      end Read;
   end Command_Port;

   protected body Valve is
      procedure Init (Id : Valve_Id; Authorized : Natural) is
      begin
         Valve.Id      := Id;
         Valve.Authorized := Authorized;
         State         := Closed;
         Safety        := Nominal;
         Interlock     := True;
         TargetP       := 0;
         ActualP       := 0;
         P_Sense       := 0.0;
         T_Sense       := 0.0;
      end Init;

      procedure Apply_Command (C : Command) is
         -- Strict authorization and interlock gating
         Auth_OK : constant Boolean := (C.Auth_Token = Authorized);
      begin
         if not Auth_OK or else Interlock then
            -- Reject command; keep safe state and target
            null;
         else
            TargetP := Percent (C.Open_Percent);
            if TargetP > ActualP then
               State := Opening;
            elsif TargetP < ActualP then
               State := Closing;
            else
               State := (if ActualP = 0 then Closed else Open);
            end if;
         end if;
      end Apply_Command;

      procedure Step is
         -- Rate limiting and hard safety stops
         Max_Step : constant Percent := 1; -- bounded per cycle
         Max_T    : Float;
         Max_P    : Float;
      begin
         -- Safety thresholds per fluid
         case Id is
            when H2_Main | H2_Bypass =>
               Max_T := Max_Temperature_H2;
               Max_P := Max_Pressure_H2;
            when Xe_Main | Xe_Bypass =>
               Max_T := Max_Temperature_Xe;
               Max_P := Max_Pressure_Xe;
         end case;

         -- Evaluate safety
         if T_Sense > Max_T or else P_Sense > Max_P then
            Safety := Critical;
            State  := Fault;
            TargetP := 0; -- force close target
         elsif T_Sense > 0.9 * Max_T or else P_Sense > 0.9 * Max_P then
            Safety := Warning;
         else
             Safety := Nominal;
         end if;

         -- Deterministic actuation
         case State is
            when Opening =>
               if ActualP < TargetP then
                  ActualP := Percent (Natural'Min (ActualP + Max_Step, TargetP));
               else
                  State := Open;
               end if;

            when Closing =>
               if ActualP > TargetP then
                  ActualP := Percent (Natural'Max (ActualP - Max_Step, TargetP));
               else
                  State := (if ActualP = 0 then Closed else Open);
               end if;

            when Open | Closed =>
               null;

            when Fault =>
               -- Fail-safe: close deterministically
               if ActualP > 0 then
                  ActualP := Percent (Natural'Max (ActualP - Max_Step, 0));
               else
                  State := Closed;
               end if;
         end case;
      end Step;

      procedure Snapshot (T : out Telemetry) is
      begin
         T.Position_Percent := ActualP;
         T.Pressure         := P_Sense;
         T.Temperature      := T_Sense;
         T.State            := State;
         T.Safety           := Safety;
      end Snapshot;

      procedure Set_Sensors (Pressure : Float; Temperature : Float) is
      begin
         -- Assume prevalidated inputs; clamp to non-negative
         if Pressure < 0.0 then
            P_Sense := 0.0;
         else
            P_Sense := Pressure;
         end if;

         if Temperature < 0.0 then
            T_Sense := 0.0;
         else
            T_Sense := Temperature;
         end if;
      end Set_Sensors;

      procedure Set_Interlock (Enabled : Boolean) is
      begin
         Interlock := Enabled;
         if Interlock then
            -- Immediately move toward closed safely
            TargetP := 0;
            if State = Open then
               State := Closing;
            end if;
         end if;
      end Set_Interlock;
   end Valve;

end Gas_Control.Core;
