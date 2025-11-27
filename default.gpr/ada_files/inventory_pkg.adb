-- file: inventory_pkg.adb
pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package body Inventory_Pkg is
   function Init (Name : Item_Name; Qty : Natural; Price : Float) return Item is
      Result : Item;
   begin
      Result.Name     := Name;
      Result.Quantity := Qty;
      Result.Price    := Price;
      return Result;
   end Init;

   procedure Add (Assets : in out Float; I : Item) is
   begin
      Assets := Assets + Float (I.Quantity) * I.Price;
   end Add;
end Inventory_Pkg;
