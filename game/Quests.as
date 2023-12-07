package grimoire.game
{
   import flash.utils.*;
   import grimoire.*;
   
   public class Quests
   {
       
      
      public function Quests()
      {
         super();
      }
      
      public static function IsInProgress(param1:String) : String
      {
         return !!Root.Game.world.isQuestInProgress(parseInt(param1)) ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function Complete(param1:String, param2:String = "-1", param3:String = "False") : void
      {
         Root.Game.world.tryQuestComplete(parseInt(param1),parseInt(param2),param3 == "True");
      }
      
      public static function Accept(param1:String) : void
      {
         Root.Game.world.acceptQuest(parseInt(param1));
      }
      
      public static function Load(param1:String) : void
      {
         Root.Game.world.showQuests([param1],"q");
      }
      
      public static function LoadMultiple(param1:String) : void
      {
         Root.Game.world.showQuests(param1.split(","),"q");
      }
      
      public static function GetQuests(param1:String) : void
      {
         Root.Game.world.getQuests(param1.split(","));
      }
      
      public static function IsAvailable(param1:String) : String
      {
         return GetQuestValidationString(parseInt(param1)) == "" ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function CanComplete(param1:String) : String
      {
         var _loc2_:String = GetQuestValidationString(parseInt(param1));
         return Boolean(Root.Game.world.canTurnInQuest(parseInt(param1))) && _loc2_ == "" ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      private static function CloneObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function GetQuestTree() : String
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:* = undefined;
         var _loc9_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in Root.Game.world.questTree)
         {
            _loc3_ = CloneObject(_loc2_);
            trace("quest: " + _loc3_);
            _loc4_ = [];
            _loc5_ = [];
            if(_loc2_.turnin != null && _loc2_.oItems != null)
            {
               for each(_loc6_ in _loc2_.turnin)
               {
                  _loc7_ = new Object();
                  _loc8_ = _loc2_.oItems[_loc6_.ItemID];
                  _loc7_.sName = _loc8_.sName;
                  _loc7_.ItemID = _loc8_.ItemID;
                  _loc7_.iQty = _loc6_.iQty;
                  _loc4_.push(_loc7_);
               }
            }
            _loc3_.RequiredItems = _loc4_;
            if(_loc2_.reward != null && _loc2_.oRewards != null)
            {
               for each(_loc9_ in _loc2_.reward)
               {
                  for each(_loc10_ in _loc2_.oRewards)
                  {
                     for each(_loc11_ in _loc10_)
                     {
                        if(_loc11_.ItemID != null && _loc11_.ItemID == _loc9_.ItemID)
                        {
                           (_loc12_ = new Object()).sName = _loc11_.sName;
                           _loc12_.ItemID = _loc9_.ItemID;
                           _loc12_.iQty = _loc9_.iQty;
                           _loc12_.DropChance = String(_loc9_.iRate) + "%";
                           _loc5_.push(_loc12_);
                        }
                     }
                  }
               }
            }
            _loc3_.Rewards = _loc5_;
            _loc1_.push(_loc3_);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function HasRequiredItemsForQuest(param1:Object) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         if(param1.reqd != null && param1.reqd.length > 0)
         {
            for each(_loc2_ in param1.reqd)
            {
               _loc3_ = _loc2_.ItemID;
               _loc4_ = int(_loc2_.iQty);
               if((_loc5_ = Root.Game.world.invTree[_loc3_]) == null || _loc5_.iQty < _loc4_)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function GetQuestValidationString(param1:int) : String
      {
         var _loc10_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:* = null;
         if((_loc10_ = Root.Game.world.questTree[param1]).sField != null && Root.Game.world.getAchievement(_loc10_.sField,_loc10_.iIndex) != 0)
         {
            if(_loc10_.sField == "im0")
            {
               return "Monthly Quests are only available once per month.";
            }
            return "Daily Quests are only available once per day.";
         }
         if(_loc10_.bUpg == 1 && !Root.Game.world.myAvatar.isUpgraded())
         {
            return "Upgrade is required for this quest!";
         }
         if(_loc10_.iSlot >= 0 && Root.Game.world.getQuestValue(_loc10_.iSlot) < _loc10_.iValue - 1)
         {
            return "Quest has not been unlocked!";
         }
         if(_loc10_.iLvl > Root.Game.world.myAvatar.objData.intLevel)
         {
            return "Unlocks at Level " + _loc10_.iLvl + ".";
         }
         if(_loc10_.iClass > 0 && Root.Game.world.myAvatar.getCPByID(_loc10_.iClass) < _loc10_.iReqCP)
         {
            _loc2_ = int(Root.Game.getRankFromPoints(_loc10_.iReqCP));
            _loc3_ = _loc10_.iReqCP - Root.Game.arrRanks[_loc2_ - 1];
            if(_loc3_ > 0)
            {
               return "Requires " + _loc3_ + " Class Points on " + _loc10_.sClass + ", Rank " + _loc2_ + ".";
            }
            return "Requires " + _loc10_.sClass + ", Rank " + _loc2_ + ".";
         }
         if(_loc10_.FactionID > 1 && Root.Game.world.myAvatar.getRep(_loc10_.FactionID) < _loc10_.iReqRep)
         {
            _loc2_ = int(Root.Game.getRankFromPoints(_loc10_.iReqRep));
            if((_loc4_ = _loc10_.iReqRep - Root.Game.arrRanks[_loc2_ - 1]) > 0)
            {
               return "Requires " + _loc4_ + " Reputation for " + _loc10_.sFaction + ", Rank " + _loc2_ + ".";
            }
            return "Requires " + _loc10_.sFaction + ", Rank " + _loc2_ + ".";
         }
         if(_loc10_.reqd != null && !HasRequiredItemsForQuest(_loc10_))
         {
            _loc9_ = "Required Item(s): ";
            for each(_loc5_ in _loc10_.reqd)
            {
               _loc6_ = int(_loc5_.ItemID);
               _loc7_ = int(_loc5_.iQty);
               if((_loc8_ = Root.Game.world.invTree[_loc6_]).sES == "ar")
               {
                  _loc2_ = int(Root.Game.getRankFromPoints(_loc7_));
                  _loc3_ = _loc7_ - Root.Game.arrRanks[_loc2_ - 1];
                  if(_loc3_ > 0)
                  {
                     _loc9_ = _loc9_ + _loc3_ + " Class Points on ";
                  }
                  _loc9_ = _loc9_ + _loc8_.sName + ", Rank " + _loc2_;
               }
               else
               {
                  _loc9_ += _loc8_.sName;
                  if(_loc7_ > 1)
                  {
                     _loc9_ = _loc9_ + "x" + _loc7_;
                  }
               }
               _loc9_ += ", ";
            }
            return _loc9_.substr(0,_loc9_.length - 2) + ".";
         }
         return "";
      }
   }
}
