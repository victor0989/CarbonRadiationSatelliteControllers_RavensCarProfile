pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package Gas_Control.Core is
   type Valve_Id is (H2_Main, H2_Bypass, Xe_Main, Xe_Bypass);
   type Valve_State is (Closed, Opening, Open, Closing, Fault);
   type Safety_State is (Nominal, Warning, Critical);

   type Command is record
      Target        : Valve_Id;
      Open_Percent  : Natural range 0 .. 100;
      Auth_Token    : Natural range 0 .. 65535; -- static auth field
   end record;

   type Telemetry is record
      Position_Percent : Natural range 0 .. 100;
      Pressure         : Float;
      Temperature      : Float;
      State            : Valve_State;
      Safety           : Safety_State;
   end record;

   -- Safety thresholds (static, tuned per system)
   Max_Temperature_H2 : constant Float := 35.0;  -- K (cryogenic envelope)
   Max_Pressure_H2    : constant Float := 6.0;   -- bar
   Max_Temperature_Xe : constant Float := 330.0; -- K
   Max_Pressure_Xe    : constant Float := 15.0;  -- bar

   subtype Percent is Natural range 0 .. 100;

   protected type Command_Port is
      procedure Write (C : Command);
      procedure Read  (C : out Command);
   private
      Pending : Command := (Target => H2_Main, Open_Percent => 0, Auth_Token => 0);
   end Command_Port;

   protected type Valve is
      procedure Init (Id : Valve_Id; Authorized : Natural);
      procedure Apply_Command (C : Command);
      procedure Step;
      procedure Snapshot (T : out Telemetry);

      -- Sensor input set (write-only from a reader task or ISR proxy)
      procedure Set_Sensors (Pressure : Float; Temperature : Float);

      -- Safety and interlocks
      procedure Set_Interlock (Enabled : Boolean);
   private
      Id         : Valve_Id      := H2_Main;
      State      : Valve_State   := Closed;
      Safety     : Safety_State  := Nominal;
      Interlock  : Boolean       := True;  -- default safe interlock
      Authorized : Natural       := 0;

      TargetP    : Percent       := 0;
      ActualP    : Percent       := 0;

      P_Sense    : Float         := 0.0;
      T_Sense    : Float         := 0.0;
   end Valve;

end Gas_Control.Core;
