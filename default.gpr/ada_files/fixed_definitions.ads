package Fixed_Definitions is

   D : constant := 2.0 ** (-31);

   type Fixed is delta D range -1.0 .. 1.0 - D;

end Fixed_Definitions;
