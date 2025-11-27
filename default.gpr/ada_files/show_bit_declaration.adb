with Ada.Text_IO; use Ada.Text_IO;

procedure Show_Bit_Declaration is

   type Bit    is mod 2 ** 1
     with Size => 1;

   B : constant Bit := 0;
   --  ^ Although Bit'Size is 1, B'Size is almost certainly 8
begin
   Put_Line ("Bit'Size = " & Positive'Image (Bit'Size));
   Put_Line ("B'Size   = " & Positive'Image (B'Size));
end Show_Bit_Declaration;
