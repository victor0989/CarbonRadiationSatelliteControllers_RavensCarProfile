-- other file, str_concat.ads
pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package Str_Concat is
   Max_Length : constant := 256;
   subtype Fixed_String is String (1 .. Max_Length);
   type Fixed_String_Array is array (Positive range <>) of Fixed_String;

   function Concat
     (USA         : Fixed_String_Array;
      Trim_Str    :
Boolean;
      Add_Whitespace :
Boolean) return String;
end Str_Concat;
