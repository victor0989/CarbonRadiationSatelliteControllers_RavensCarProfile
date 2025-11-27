-- Raven decibels file
-- decibels.ads
pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package Decibels is
   subtype Decibel is Float;
   subtype Factor is Float;

   function To_Decibel (F : Factor) return Decibel;
   function To_Factor (D : Decibel) return Factor;
end Decibels;
