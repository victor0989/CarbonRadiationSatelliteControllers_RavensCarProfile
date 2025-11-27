with Ada.Text_IO; use Ada.Text_IO;

package body Signal_Handlers is

   protected body Quit_Handler is

      function Requested return Boolean is
        (Quit_Request);

      procedure Handle_Quit_Signal is
      begin
         Put_Line ("Quit request detected!");
         Quit_Request := True;
      end Handle_Quit_Signal;

   end Quit_Handler;

end Signal_Handlers;
