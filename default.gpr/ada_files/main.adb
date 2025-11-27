-- file raven.adb
pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Text_IO;       use Ada.Text_IO;
with Inventory_Pkg;     use Inventory_Pkg;

procedure Main is
   -- Array estático de floats (determinista)
   F : array (1 .. 10) of Float := (others => 42.42);

   type Test_Case_Index is (Inventory_Chk);

   procedure Display (Assets : Float) is
      package F_IO is new Ada.Text_IO.Float_IO (Float);
      use F_IO;
   begin
      Put ("Assets: $");
      Put (Assets, 1, 2, 0);
      New_Line;
   end Display;

   procedure Check (TC : Test_Case_Index) is
      I      : Item;
      Assets : Float := 0.0;
   begin
      case TC is
         when Inventory_Chk =>
            I := Init (Ballpoint_Pen, 185, 0.15);
            Add (Assets, I);
            Display (Assets);

            I := Init (Oil_Based_Pen_Marker, 100, 9.0);
            Add (Assets, I);
            Display (Assets);

            I := Init (Feather_Quill_Pen, 2, 40.0);
            Add (Assets, I);
            Display (Assets);
      end case;
   end Check;

begin
   if Argument_Count < 1 then
      Put_Line ("ERROR: missing arguments! Exiting...");
      return;
   elsif Argument_Count > 1 then
      Put_Line ("Ignoring additional arguments...");
   end if;

   Check (Test_Case_Index'Value (Argument (1)));
end Main;
