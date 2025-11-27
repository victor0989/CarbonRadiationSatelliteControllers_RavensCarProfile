with Registers;

procedure Enable_USB_Clock is
begin
   Registers.PMC_Periph.PMC_SCER.USBCLK := 1;
end Enable_USB_Clock;
