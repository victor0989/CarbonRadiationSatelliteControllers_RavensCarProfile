with System;

procedure Show_Shared_HW_Register is
   type Atomic_Integer is new Integer with Atomic;

   R : Atomic_Integer with Address => System'To_Address (16#FFFF00A0#);

   Arr : array (1 .. 2) of Integer with Atomic_Components;
begin
   null;
end Show_Shared_HW_Register;
