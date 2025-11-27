-- file: inventory_pkg.ads
pragma Profile (Ravenscar);
pragma Restrictions (No_Implicit_Heap_Allocations);

package Inventory_Pkg is
   type Item is record
      Name     : String (1 .. 32); -- fixed-length, static
      Quantity : Natural;
      Price    : Float;
   end record;

   -- Some enumerated identifiers for items
   subtype Item_Name is String (1 .. 32);

   Ballpoint_Pen       : constant Item_Name := "Ballpoint Pen"       & (1 .. 18 => ' ');
   Oil_Based_Pen_Marker: constant Item_Name := "Oil-Based Marker"    & (1 .. 17 => ' ');
   Feather_Quill_Pen   : constant Item_Name := "Feather Quill Pen"   & (1 .. 16 => ' ');

   function Init (Name : Item_Name; Qty : Natural; Price : Float) return Item;

   procedure Add (Assets : in out Float; I : Item);
end Inventory_Pkg;
