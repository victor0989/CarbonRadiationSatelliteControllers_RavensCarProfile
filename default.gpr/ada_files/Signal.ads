pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package Signal is
   -- Tipo base para las muestras
   subtype Sig_Value is Float;

   -- Definimos una señal como un array estático de valores
   type Signal is array (Positive range <>) of Sig_Value;

   -- Calcula el valor RMS de la señal
   function Rms (S : Signal) return Sig_Value;
end Signal;
