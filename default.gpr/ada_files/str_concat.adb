-- str_concat.adb otro archivo para GNAT

with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Str_Concat is
   function Concat
     (USA            : Fixed_String_Array;
      Trim_Str       : Boolean;
      Add_Whitespace : Boolean) return string;
is
   Buffer : Fixed_String := (others => ' ');
   Pos    : Natural := 0;
begin
   for I in USA'Range loop
      declare
         Tmp   : String := USA (I);
         Clean : String :=
(if Trim_Str then Trim (Tmp, Both) else Tmp);
begin
   for J in Clean'Range loop
      exit when Pos = Max_Length;
      Pos             := Pos + 1;
      Buffer (Pos)    := Clean (J);
end loop;
            if Add_Whitespace and then I < USA'Last and then Pos < Max_Length
            then
               Pos    := Pos + 1;
               Buffer (Pos);
  end if;
 end;
end loop;
return Buffer (1 .. Pos);
end;
