with Ada.Text_IO;       use Ada.Text_IO;

with Fixed_Definitions; use Fixed_Definitions;

procedure Show_Float_And_Fixed_Point is
   Float_Value : Float := 0.25;
   Fixed_Value : Fixed := 0.25;
begin

   Float_Value := Float_Value + 0.25;
   Fixed_Value := Fixed_Value + 0.25;

   Put_Line ("Float_Value = " & Float'Image (Float_Value));
   Put_Line ("Fixed_Value = " & Fixed'Image (Fixed_Value));
end Show_Float_And_Fixed_Point;
