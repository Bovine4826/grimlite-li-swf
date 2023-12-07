package grimoire.game
{
   import grimoire.*;
   
   public class House
   {
       
      
      public function House()
      {
         super();
      }
      
      public static function GetHouseItems() : String
      {
         return JSON.stringify(Root.Game.world.myAvatar.houseitems);
      }
      
      public static function HouseSlots() : int
      {
         return Root.Game.world.myAvatar.objData.iHouseSlots;
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:* = undefined;
         if(Root.Game.world.myAvatar.houseitems != null && Root.Game.world.myAvatar.houseitems.length > 0)
         {
            for each(_loc2_ in Root.Game.world.myAvatar.houseitems)
            {
               if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
   }
}
