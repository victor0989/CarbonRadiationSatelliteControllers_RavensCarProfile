with System.OS_Interface;

package Signal_Handlers is

   protected type Quit_Handler is
      function Requested return Boolean;
   private
      Quit_Request : Boolean := False;

      --
      --  Declaration of an interrupt handler for the "quit" interrupt:
      --
      procedure Handle_Quit_Signal
        with Attach_Handler => System.OS_Interface.SIGQUIT;
   end Quit_Handler;

end Signal_Handlers;
