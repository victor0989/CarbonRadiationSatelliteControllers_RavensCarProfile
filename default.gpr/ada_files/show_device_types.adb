with Ada.Text_IO;     use Ada.Text_IO;

with My_Device_Types; use My_Device_Types;

procedure Show_Device_Types is
   UInt10_Obj : constant UInt10 := 0;
begin
   Put_Line ("Size of UInt10 type:   " & Positive'Image (UInt10'Size));
   Put_Line ("Size of UInt10 object: " & Positive'Image (UInt10_Obj'Size));
end Show_Device_Types;
