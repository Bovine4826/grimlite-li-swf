package grimoire.game
{
   import flash.events.*;
   import flash.utils.*;
   import grimoire.*;
   
   public class World
   {
       
      
      public function World()
      {
         super();
      }
      
      public static function MapLoadComplete() : String
      {
         if(Root.Game.world.mapLoadInProgress)
         {
            return Root.FalseString;
         }
         try
         {
            return Root.Game.getChildAt(Root.Game.numChildren - 1) != Root.Game.mcConnDetail ? String(Root.TrueString) : String(Root.FalseString);
         }
         catch(e:*)
         {
            return Root.FalseString;
         }
      }
      
      public static function PlayersInMap() : String
      {
         return JSON.stringify(Root.Game.world.areaUsers);
      }
      
      public static function IsActionAvailable(param1:String) : String
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = Root.Game.world.lock[param1];
         _loc3_ = new Date();
         return (_loc5_ = (_loc4_ = _loc3_.getTime()) - _loc2_.ts) < _loc2_.cd ? String(Root.FalseString) : String(Root.TrueString);
      }
      
      public static function GetMonstersInCell() : String
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = Root.Game.world.getMonstersByCell(Root.Game.world.strFrame);
         var _loc2_:Array = [];
         for(_loc3_ in _loc1_)
         {
            _loc4_ = _loc1_[_loc3_];
            (_loc5_ = new Object()).sRace = _loc4_.objData.sRace;
            _loc5_.strMonName = _loc4_.objData.strMonName;
            _loc5_.MonID = _loc4_.dataLeaf.MonID;
            _loc5_.iLvl = _loc4_.dataLeaf.iLvl;
            _loc5_.intState = _loc4_.dataLeaf.intState;
            _loc5_.intHP = _loc4_.dataLeaf.intHP;
            _loc5_.intHPMax = _loc4_.dataLeaf.intHPMax;
            _loc2_.push(_loc5_);
         }
         return JSON.stringify(_loc2_);
      }
      
      public static function GetVisibleMonstersInCell() : String
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = Root.Game.world.getMonstersByCell(Root.Game.world.strFrame);
         var _loc2_:Array = [];
         for(_loc3_ in _loc1_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]).pMC == null || !_loc4_.pMC.visible || _loc4_.dataLeaf.intState <= 0))
            {
               (_loc5_ = new Object()).sRace = _loc4_.objData.sRace;
               _loc5_.strMonName = _loc4_.objData.strMonName;
               _loc5_.MonID = _loc4_.dataLeaf.MonID;
               _loc5_.iLvl = _loc4_.dataLeaf.iLvl;
               _loc5_.intState = _loc4_.dataLeaf.intState;
               _loc5_.intHP = _loc4_.dataLeaf.intHP;
               _loc5_.intHPMax = _loc4_.dataLeaf.intHPMax;
               _loc2_.push(_loc5_);
            }
         }
         return JSON.stringify(_loc2_);
      }
      
      public static function GetMonsterHealth(param1:String) : String
      {
         var _loc2_:Object = World.GetMonsterByName(param1);
         return _loc2_.dataLeaf.intHP.toString();
      }
      
      public static function SetSpawnPoint() : void
      {
         Root.Game.world.setSpawnPoint(Root.Game.world.strFrame,Root.Game.world.strPad);
      }
      
      public static function IsMonsterAvailable(param1:String) : String
      {
         return GetMonsterByName(param1) != null ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function GetSkillName(param1:String) : String
      {
         var _loc2_:int = int(parseInt(param1));
         return "\"" + Root.Game.world.actions.active[_loc2_].nam + "\"";
      }
      
      public static function GetMonsterByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         for each(_loc2_ in Root.Game.world.getMonstersByCell(Root.Game.world.strFrame))
         {
            if(_loc2_.pMC)
            {
               _loc3_ = String(_loc2_.pMC.pname.ti.text.toLowerCase());
               if((_loc3_.indexOf(param1.toLowerCase()) > -1 || param1 == "*") && _loc2_.dataLeaf.intState > 0)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public static function GetCells() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in Root.Game.world.map.currentScene.labels)
         {
            _loc1_.push(_loc2_.name);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function GetPads(param1:Boolean = true) : *
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < Root.Game.world.map.numChildren)
         {
            if(Root.Game.world.map.getChildAt(_loc3_).toString().split(" ")[1].toLowerCase().indexOf("pad") > -1)
            {
               _loc2_.push(Root.Game.world.map.getChildAt(_loc3_).name);
            }
            _loc3_++;
         }
         if(!param1)
         {
            return _loc2_;
         }
         return JSON.stringify(_loc2_);
      }
      
      public static function GetItemTree() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = [];
         for(_loc2_ in Root.Game.world.invTree)
         {
            _loc1_.push(Root.Game.world.invTree[_loc2_]);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function RoomId() : String
      {
         return Root.Game.world.curRoom.toString();
      }
      
      public static function RoomNumber() : String
      {
         return Root.Game.world.strAreaName.split("-")[1];
      }
      
      public static function Players() : String
      {
         return JSON.stringify(Root.Game.world.uoTree);
      }
      
      public static function PlayerByName(param1:String) : String
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:String = "";
         for(_loc3_ in Root.Game.world.uoTree)
         {
            if((_loc4_ = Root.Game.world.uoTree[_loc3_]).strUsername.toLowerCase() == param1.toLowerCase())
            {
               _loc2_ = JSON.stringify(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public static function GetCellPlayers(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for(_loc2_ in Root.Game.world.uoTree)
         {
            _loc3_ = Root.Game.world.uoTree[_loc2_];
            if(_loc3_.strUsername.toLowerCase() == param1.toLowerCase())
            {
               if(_loc3_.strFrame.toLowerCase() == Root.Game.world.strFrame.toLowerCase())
               {
                  return Root.TrueString;
               }
            }
         }
         return Root.FalseString;
      }
      
      public static function CheckCellPlayer(param1:*, param2:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for(_loc3_ in Root.Game.world.uoTree)
         {
            if((_loc4_ = Root.Game.world.uoTree[_loc3_]).strUsername.toLowerCase() == param1.toLowerCase())
            {
               if(_loc4_.strFrame.toLowerCase() == param2.toLowerCase())
               {
                  return Root.TrueString;
               }
            }
         }
         return Root.FalseString;
      }
      
      public static function GetPlayerHealth(param1:String) : String
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:int = 100;
         for(_loc3_ in Root.Game.world.uoTree)
         {
            if((_loc4_ = Root.Game.world.uoTree[_loc3_]).strUsername.toLowerCase() == param1.toLowerCase())
            {
               _loc2_ = int(_loc4_.intHP);
               break;
            }
         }
         return _loc2_;
      }
      
      public static function GetPlayerHealthPercentage(param1:String) : String
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 100;
         for(_loc3_ in Root.Game.world.uoTree)
         {
            if((_loc4_ = Root.Game.world.uoTree[_loc3_]).strUsername.toLowerCase() == param1.toLowerCase())
            {
               _loc5_ = int(_loc4_.intHP);
               _loc6_ = int(_loc4_.intHPMax);
               _loc2_ = _loc5_ / _loc6_ * 100;
               break;
            }
         }
         return _loc2_;
      }
      
      public static function RejectDropR(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(Root.Game.litePreference.data.bCustomDrops)
         {
            _loc2_ = !!Root.Game.cDropsUI.mcDraggable ? Root.Game.cDropsUI.mcDraggable.menu : Root.Game.cDropsUI;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               if((_loc4_ = _loc2_.getChildAt(_loc3_)).itemObj)
               {
                  if(param1 == _loc4_.itemObj.sName.toLowerCase())
                  {
                     _loc4_.btNo.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  }
               }
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = int(Root.Game.ui.dropStack.numChildren);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = Root.Game.ui.dropStack.getChildAt(_loc6_);
               if((_loc7_ = String(getQualifiedClassName(_loc4_))).indexOf("DFrame2MC") != -1)
               {
                  if(_loc4_.cnt.strName.text.toLowerCase().indexOf(param1) == 0)
                  {
                     _loc4_.cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  }
               }
               _loc6_++;
            }
         }
      }
      
      public static function RejectDrop(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         if(Root.Game.litePreference.data.bCustomDrops)
         {
            Root.Game.cDropsUI.onBtNo(Root.Game.world.invTree[param2]);
         }
         else
         {
            _loc3_ = int(Root.Game.ui.dropStack.numChildren);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if((_loc5_ = Root.Game.ui.dropStack.getChildAt(_loc4_)).cnt.strName.text.toLowerCase().indexOf(param1.toLowerCase()) == 0)
               {
                  Root.Game.ui.dropStack.removeChild(_loc5_);
               }
               _loc4_++;
            }
         }
      }
      
      public static function ReloadMap() : void
      {
         Root.Game.world.reloadCurrentMap();
      }
      
      public static function SetMapQuestVal() : void
      {
         Root.Game.world.map.questVal = 30;
      }
   }
}
