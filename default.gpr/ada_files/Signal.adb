with Ada.Numerics.Generic_Elementary_Functions;

package body Signal is
   -- Instanciamos funciones matemáticas para Float
   package Math is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Math;

   function Rms (S : Signal) return Sig_Value is
      Sum : Float := 0.0;
   begin
      for I in S'Range loop
         Sum := Sum + S (I) ** 2;
      end loop;
      return Sqrt (Sum / Float (S'Length));
   end Rms;
end Signal;
