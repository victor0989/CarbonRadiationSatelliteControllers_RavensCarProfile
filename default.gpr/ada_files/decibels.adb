with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics;

package body Decibels is

   function To_Decibel (F : Factor) return Decibel is
   begin
      if F <= 0.0 then
         return Float'First;  -- el menor valor representable
         -- valor inválido
      else
         return 20.0 * Log (F, 10.0);
      end if;
   end To_Decibel;

   function To_Factor (D : Decibel) return Factor is
   begin
      return 10.0 ** (D / 20.0);
   end To_Factor;

end Decibels;
