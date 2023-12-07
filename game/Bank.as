package grimoire.game
{
   import grimoire.*;
   
   public class Bank
   {
       
      
      public function Bank()
      {
         super();
      }
      
      public static function GetBankItems() : String
      {
         return JSON.stringify(Root.Game.world.bankinfo.items);
      }
      
      public static function BankSlots() : int
      {
         return Root.Game.world.myAvatar.objData.iBankSlots;
      }
      
      public static function UsedBankSlots() : int
      {
         return Root.Game.world.myAvatar.iBankCount;
      }
      
      public static function TransferToBank(param1:String) : void
      {
         var _loc2_:Object = Inventory.GetItemByName(param1);
         if(_loc2_ != null)
         {
            Root.Game.world.sendBankFromInvRequest(_loc2_);
         }
      }
      
      public static function TransferToInventory(param1:String) : void
      {
         var _loc2_:Object = GetItemByName(param1);
         if(_loc2_ != null)
         {
            Root.Game.world.sendBankToInvRequest(_loc2_);
         }
      }
      
      public static function BankSwap(param1:String, param2:String) : void
      {
         var _loc3_:Object = Inventory.GetItemByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Object;
         if((_loc4_ = GetItemByName(param2)) == null)
         {
            return;
         }
         Root.Game.world.sendBankSwapInvRequest(_loc4_,_loc3_);
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         if(Root.Game.world.bankinfo.items != null && Root.Game.world.bankinfo.items.length > 0)
         {
            for each(_loc2_ in Root.Game.world.bankinfo.items)
            {
               if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public static function GetItemByName2(param1:String) : String
      {
         return JSON.stringify(GetItemByName(param1));
      }
      
      public static function Show() : void
      {
         Root.Game.world.toggleBank();
      }
      
      public static function GetBank() : void
      {
         Root.Game.getBank();
      }
      
      public static function LoadBankItems() : void
      {
         Root.Game.sfc.sendXtMessage("zm","loadBank",["All"],"str",Root.Game.world.curRoom);
      }
   }
}
