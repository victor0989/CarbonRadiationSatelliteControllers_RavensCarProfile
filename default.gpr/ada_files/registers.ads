with System;

package Registers is

   type Bit    is mod 2 ** 1
     with Size => 1;
   type UInt5  is mod 2 ** 5
     with Size => 5;
   type UInt10 is mod 2 ** 10
     with Size => 10;

   subtype USB_Clock_Enable is Bit;

   --  System Clock Enable Register
   type PMC_SCER_Register is record
      --  Reserved bits
      Reserved_0_4   : UInt5            := 16#0#;
      --  Write-only. Enable USB FS Clock
      USBCLK         : USB_Clock_Enable := 16#0#;
      --  Reserved bits
      Reserved_6_15  : UInt10           := 16#0#;
   end record
     with
       Volatile,
       Size      => 16,
       Bit_Order => System.Low_Order_First;

   for PMC_SCER_Register use record
      Reserved_0_4   at 0 range 0 .. 4;
      USBCLK         at 0 range 5 .. 5;
      Reserved_6_15  at 0 range 6 .. 15;
   end record;

   --  Power Management Controller
   type PMC_Peripheral is record
      --  System Clock Enable Register
      PMC_SCER       : aliased PMC_SCER_Register;
      --  System Clock Disable Register
      PMC_SCDR       : aliased PMC_SCER_Register;
   end record
     with Volatile;

   for PMC_Peripheral use record
      --  16-bit register at byte 0
      PMC_SCER       at 16#0# range 0 .. 15;
      --  16-bit register at byte 2
      PMC_SCDR       at 16#2# range 0 .. 15;
   end record;

   --  Power Management Controller
   PMC_Periph : aliased PMC_Peripheral
     with Import, Address => System'To_Address (16#400E0600#);

end Registers;
