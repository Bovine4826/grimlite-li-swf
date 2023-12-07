package grimoire.game
{
   import flash.filters.*;
   import grimoire.*;
   
   public class Player
   {
       
      
      public function Player()
      {
         super();
      }
      
      public static function IsLoggedIn() : String
      {
         return Root.Game != null && Root.Game.sfc != null && Root.Game.sfc.isConnected == true ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function Cell() : String
      {
         return "\"" + Root.Game.world.strFrame + "\"";
      }
      
      public static function CheckPlayerInMyCell(param1:String) : String
      {
         var _loc2_:* = Root.Game.world.uoTree;
         var _loc3_:* = Root.Game.world.strFrame;
         return JSON.stringify(_loc2_) + "  " + JSON.stringify(_loc3_);
      }
      
      public static function GetFactions() : String
      {
         return JSON.stringify(Root.Game.world.myAvatar.factions);
      }
      
      public static function Pad() : String
      {
         return "\"" + Root.Game.world.strPad + "\"";
      }
      
      public static function State() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intState;
      }
      
      public static function Health() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intHP;
      }
      
      public static function HealthMax() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intHPMax;
      }
      
      public static function Mana() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intMP;
      }
      
      public static function ManaMax() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intMPMax;
      }
      
      public static function Map() : String
      {
         return "\"" + Root.Game.world.strMapName + "\"";
      }
      
      public static function Level() : int
      {
         return Root.Game.world.myAvatar.dataLeaf.intLevel;
      }
      
      public static function IsMember() : String
      {
         return Root.Game.world.myAvatar.objData.iUpgDays >= 0 ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function Gold() : int
      {
         return Root.Game.world.myAvatar.objData.intGold;
      }
      
      public static function HasTarget() : String
      {
         return Root.Game.world.myAvatar.target != null && Root.Game.world.myAvatar.target.dataLeaf.intHP > 0 ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function IsAfk() : String
      {
         return !!Root.Game.world.myAvatar.dataLeaf.afk ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function AllSkillsAvailable() : int
      {
         return Math.max(Math.max(IsSkillReady(Root.Game.world.actions.active[1]),IsSkillReady(Root.Game.world.actions.active[2])),Math.max(IsSkillReady(Root.Game.world.actions.active[3]),IsSkillReady(Root.Game.world.actions.active[4])));
      }
      
      public static function SkillAvailable(param1:String) : int
      {
         return IsSkillReady(Root.Game.world.actions.active[parseInt(param1)]);
      }
      
      private static function IsSkillReady(param1:*) : int
      {
         var _loc2_:* = NaN;
         var _loc3_:* = new Date().getTime();
         var _loc4_:* = 1 - Math.min(Math.max(Root.Game.world.myAvatar.dataLeaf.sta.$tha,-1),0.5);
         if(param1.OldCD != null)
         {
            _loc2_ = Math.round(param1.OldCD * _loc4_);
            delete param1.OldCD;
         }
         else
         {
            _loc2_ = Math.round(param1.cd * _loc4_);
         }
         var _loc5_:*;
         if((_loc5_ = Root.Game.world.GCD - (_loc3_ - Root.Game.world.GCDTS)) < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:*;
         if((_loc6_ = _loc2_ - (_loc3_ - param1.ts)) < 0)
         {
            _loc6_ = 0;
         }
         return Math.max(_loc5_,_loc6_);
      }
      
      public static function Position() : String
      {
         return JSON.stringify([Root.Game.world.myAvatar.pMC.x,Root.Game.world.myAvatar.pMC.y]);
      }
      
      public static function WalkToPoint(param1:String, param2:String) : void
      {
         var _loc3_:int = int(parseInt(param1));
         var _loc4_:int = int(parseInt(param2));
         Root.Game.world.myAvatar.pMC.walkTo(_loc3_,_loc4_,Root.Game.world.WALKSPEED);
         Root.Game.world.moveRequest({
            "mc":Root.Game.world.myAvatar.pMC,
            "tx":_loc3_,
            "ty":_loc4_,
            "sp":Root.Game.world.WALKSPEED
         });
      }
      
      public static function CancelAutoAttack() : void
      {
         Root.Game.world.cancelAutoAttack();
      }
      
      public static function CancelTarget() : void
      {
         Root.Game.world.cancelTarget();
         Root.Game.world.cancelTarget();
      }
      
      public static function CancelTargetSelf() : void
      {
         var _loc1_:* = Root.Game.world.myAvatar.target;
         if(!_loc1_)
         {
         }
         if(_loc1_ == Root.Game.world.myAvatar)
         {
            Root.Game.world.cancelTarget();
         }
      }
      
      public static function SetTargetPlayer(param1:String) : void
      {
         var _loc2_:* = Root.Game.world.getAvatarByUserName(param1);
         Root.Game.world.setTarget(_loc2_);
      }
      
      public static function GetAvatars() : String
      {
         return JSON.stringify(Root.Game.world.avatars);
      }
      
      public static function SetTargetPvP(param1:String) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:* = Root.Game.world.avatars;
         for(_loc3_ in _loc2_)
         {
            if((_loc4_ = _loc2_[_loc3_]).dataLeaf.strFrame == Root.Game.world.strFrame && _loc4_.dataLeaf.pvpTeam != Root.Game.world.myAvatar.dataLeaf.pvpTeam && !_loc4_.isMyAvatar && _loc4_.dataLeaf.intState > 0)
            {
               if(!Root.Game.world.myAvatar.target)
               {
                  Root.Game.world.setTarget(_loc4_);
               }
               if(param1 != null)
               {
                  if(_loc4_.dataLeaf.strUsername.toLowerCase() == param1.toLowerCase() && Root.Game.world.myAvatar.target.dataLeaf.strUsername.toLowerCase() != param1.toLowerCase())
                  {
                     Root.Game.world.setTarget(_loc4_);
                  }
               }
            }
         }
      }
      
      public static function GetSkillCooldown(param1:String) : String
      {
         return Root.Game.world.actions.active[parseInt(param1)].cd;
      }
      
      public static function SetSkillCooldown(param1:String, param2:String) : void
      {
         Root.Game.world.actions.active[parseInt(param1)].cd = param2;
      }
      
      public static function SetSkillRange(param1:String, param2:String) : void
      {
         Root.Game.world.actions.active[parseInt(param1)].range = param2;
      }
      
      public static function SetSkillMana(param1:String, param2:String) : void
      {
         Root.Game.world.actions.active[parseInt(param1)].mp = param2;
      }
      
      public static function MuteToggle(param1:Boolean) : void
      {
         if(param1)
         {
            Root.Game.chatF.unmuteMe();
         }
         else
         {
            Root.Game.chatF.muteMe(300000);
         }
      }
      
      public static function AttackMonster(param1:String) : void
      {
         var monsterName:String = param1;
         var monster:* = World.GetMonsterByName(monsterName);
         if(monster != null)
         {
            try
            {
               Root.Game.world.setTarget(monster);
               Root.Game.world.approachTarget();
            }
            catch(e:*)
            {
               return;
            }
         }
      }
      
      public static function Jump(param1:String, param2:String = "Spawn") : void
      {
         Root.Game.world.moveToCell(param1,param2);
      }
      
      public static function Rest() : void
      {
         Root.Game.world.rest();
      }
      
      public static function Join(param1:String, param2:String = "Enter", param3:String = "Spawn") : void
      {
         Root.Game.world.gotoTown(param1,param2,param3);
      }
      
      public static function Equip(param1:String) : void
      {
         Root.Game.world.sendEquipItemRequest({"ItemID":parseInt(param1)});
      }
      
      public static function EquipPotion(param1:String, param2:String, param3:String, param4:String) : void
      {
         Root.Game.world.equipUseableItem({
            "ItemID":parseInt(param1),
            "sDesc":param2,
            "sFile":param3,
            "sName":param4
         });
      }
      
      public static function Buff() : void
      {
         Root.Game.world.myAvatar.dataLeaf.sta.$tha = 0.5;
         Root.Game.world.myAvatar.objData.intMP = 100;
         Root.Game.world.myAvatar.dataLeaf.intMP = 100;
         Root.Game.world.myAvatar.objData.intLevel = 100;
         Root.Game.world.actions.active[0].mp = 0;
         Root.Game.world.actions.active[1].mp = 0;
         Root.Game.world.actions.active[2].mp = 0;
         Root.Game.world.actions.active[3].mp = 0;
         Root.Game.world.actions.active[4].mp = 0;
         Root.Game.world.actions.active[5].mp = 0;
      }
      
      public static function GoTo(param1:String) : void
      {
         Root.Game.world.goto(param1);
      }
      
      public static function UseBoost(param1:String) : void
      {
         var _loc2_:Object = Inventory.GetItemByID(parseInt(param1));
         if(_loc2_ != null)
         {
            Root.Game.world.sendUseItemRequest(_loc2_);
         }
      }
      
      public static function ForceUseSkill(param1:String) : void
      {
         var _loc2_:Object = Root.Game.world.actions.active[parseInt(param1)];
         if(IsSkillReady(_loc2_) == 0)
         {
            if(Root.Game.world.myAvatar.dataLeaf.intMP >= _loc2_.mp)
            {
               if(Boolean(_loc2_.isOK) && !_loc2_.skillLock)
               {
                  Root.Game.world.testAction(_loc2_);
               }
            }
         }
      }
      
      public static function UseSkill(param1:String) : void
      {
         var _loc2_:Object = Root.Game.world.actions.active[parseInt(param1)];
         if(_loc2_.tgt == "s" || _loc2_.tgt == "f")
         {
            ForceUseSkill(param1);
            return;
         }
         if(Root.Game.world.myAvatar.target == Root.Game.world.myAvatar)
         {
            Root.Game.world.myAvatar.target = null;
            return;
         }
         if(Root.Game.world.myAvatar.target != null && Root.Game.world.myAvatar.target.dataLeaf.intHP > 0)
         {
            Root.Game.world.approachTarget();
            ForceUseSkill(param1);
         }
      }
      
      public static function GetMapItem(param1:String) : void
      {
         Root.Game.world.getMapItem(parseInt(param1));
      }
      
      public static function Logout() : void
      {
         Root.Game.logout();
      }
      
      public static function HasActiveBoost(param1:String) : String
      {
         param1 = param1.toLowerCase();
         if(param1.indexOf("gold") > -1)
         {
            return Root.Game.world.myAvatar.objData.iBoostG > 0 ? String(Root.TrueString) : String(Root.FalseString);
         }
         if(param1.indexOf("xp") > -1)
         {
            return Root.Game.world.myAvatar.objData.iBoostXP > 0 ? String(Root.TrueString) : String(Root.FalseString);
         }
         if(param1.indexOf("rep") > -1)
         {
            return Root.Game.world.myAvatar.objData.iBoostRep > 0 ? String(Root.TrueString) : String(Root.FalseString);
         }
         if(param1.indexOf("class") > -1)
         {
            return Root.Game.world.myAvatar.objData.iBoostCP > 0 ? String(Root.TrueString) : String(Root.FalseString);
         }
         return Root.FalseString;
      }
      
      public static function PlayerClass() : String
      {
         return "\"" + Root.Game.world.myAvatar.objData.strClassName.toUpperCase() + "\"";
      }
      
      public static function UserID() : int
      {
         return Root.Game.world.myAvatar.uid;
      }
      
      public static function CharID() : int
      {
         return Root.Game.world.myAvatar.objData.CharID;
      }
      
      public static function Gender() : String
      {
         return "\"" + Root.Game.world.myAvatar.objData.strGender.toUpperCase() + "\"";
      }
      
      public static function PlayerData() : Object
      {
         return Root.Game.world.myAvatar.objData;
      }
      
      public static function SetEquip(param1:String, param2:Object) : void
      {
         if(Root.Game.world.myAvatar.pMC.pAV.objData.eqp.Weapon == null)
         {
            return;
         }
         var _loc3_:* = param1;
         var _loc4_:* = param2;
         if(param1 == "Off")
         {
            Root.Game.world.myAvatar.pMC.pAV.objData.eqp.Weapon.sLink = _loc4_.sLink;
            Root.Game.world.myAvatar.pMC.loadWeaponOff(_loc4_.sFile,_loc4_.sLink);
            Root.Game.world.myAvatar.pMC.pAV.getItemByEquipSlot("Weapon").sType = "Dagger";
         }
         else
         {
            Root.Game.world.myAvatar.objData.eqp[_loc3_] = _loc4_;
            Root.Game.world.myAvatar.loadMovieAtES(_loc3_,_loc4_.sFile,_loc4_.sLink);
         }
      }
      
      public static function GetEquip(param1:int) : String
      {
         return JSON.stringify(Root.Game.world.avatars[param1].objData.eqp);
      }
      
      public static function ChangeName(param1:String) : void
      {
         Root.Game.world.myAvatar.pMC.pname.ti.text = param1.toUpperCase();
         Root.Game.ui.mcPortrait.strName.text = param1.toUpperCase();
         Root.Game.world.myAvatar.objData.strUsername = param1.toUpperCase();
         Root.Game.world.myAvatar.pMC.pAV.objData.strUsername = param1.toUpperCase();
      }
      
      public static function ChangeGuild(param1:String) : void
      {
         if(Root.Game.world.myAvatar.objData.guild != null)
         {
            Root.Game.world.myAvatar.pMC.pname.tg.text = param1.toUpperCase();
            Root.Game.world.myAvatar.objData.guild.Name = param1.toUpperCase();
            Root.Game.world.myAvatar.pMC.pAV.objData.guild.Name = param1.toUpperCase();
         }
      }
      
      public static function SetWalkSpeed(param1:String) : void
      {
         Root.Game.world.WALKSPEED = parseInt(param1);
      }
      
      public static function ChangeAccessLevel(param1:String) : void
      {
         if(param1 == "Non Member")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 16777215;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.iUpgDays = -1;
            Root.Game.world.myAvatar.objData.iUpg = 0;
            Root.Game.chatF.pushMsg("server","Access : Non Member","SERVER","",0);
         }
         else if(param1 == "Member")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 9229823;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.iUpgDays = 30;
            Root.Game.world.myAvatar.objData.iUpg = 1;
            Root.Game.chatF.pushMsg("server","Access : Member","SERVER","",0);
         }
         else if(param1 == "Moderator" || param1 == "60")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 16698168;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.intAccessLevel = 60;
            Root.Game.chatF.pushMsg("server","Access : Moderator","SERVER","",0);
         }
         else if(param1 == "30")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 52881;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.intAccessLevel = 30;
            Root.Game.chatF.pushMsg("server","Access : Moderator","SERVER","",0);
         }
         else if(param1 == "40")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 5308200;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.intAccessLevel = 40;
            Root.Game.chatF.pushMsg("server","Access : Moderator","SERVER","",0);
         }
         else if(param1 == "50")
         {
            Root.Game.world.myAvatar.pMC.pname.ti.textColor = 12283391;
            Root.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            Root.Game.world.myAvatar.objData.intAccessLevel = 50;
            Root.Game.chatF.pushMsg("server","Access : Moderator","SERVER","",0);
         }
      }
      
      public static function GetTargetHealth() : int
      {
         return Root.Game.world.myAvatar.target.dataLeaf.intHP;
      }
      
      public static function IsAvatarLoadComplete() : String
      {
         return Game.world.myAvatar.objData == null ? String(Root.False) : String(Root.TrueString);
      }
   }
}
