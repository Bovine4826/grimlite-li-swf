package grimoire.game
{
   import grimoire.*;
   
   public class Inventory
   {
       
      
      public function Inventory()
      {
         super();
      }
      
      public static function GetInventoryItems() : String
      {
         return JSON.stringify(Root.Game.world.myAvatar.items);
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in Root.Game.world.myAvatar.items)
         {
            if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function GetItemByName2(param1:String) : String
      {
         return JSON.stringify(GetItemByName(param1));
      }
      
      public static function GetItemByID(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in Root.Game.world.myAvatar.items)
         {
            if(_loc2_.ItemID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function InventorySlots() : int
      {
         return Root.Game.world.myAvatar.objData.iBagSlots;
      }
      
      public static function UsedInventorySlots() : int
      {
         return Root.Game.world.myAvatar.items.length;
      }
   }
}
