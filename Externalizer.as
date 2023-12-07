package grimoire
{
   import flash.external.ExternalInterface;
   import grimoire.game.AutoRelogin;
   import grimoire.game.Bank;
   import grimoire.game.House;
   import grimoire.game.Inventory;
   import grimoire.game.Player;
   import grimoire.game.Quests;
   import grimoire.game.Settings;
   import grimoire.game.Shops;
   import grimoire.game.TempInventory;
   import grimoire.game.World;
   
   public class Externalizer
   {
       
      
      public function Externalizer()
      {
         super();
      }
      
      public static function debugS(param1:String) : void
      {
         ExternalInterface.call("debug",param1);
      }
      
      public function init(param1:Root) : void
      {
         this.addCallback("IsLoggedIn",Player.IsLoggedIn);
         this.addCallback("Cell",Player.Cell);
         this.addCallback("Pad",Player.Pad);
         this.addCallback("Class",Player.PlayerClass);
         this.addCallback("State",Player.State);
         this.addCallback("Health",Player.Health);
         this.addCallback("HealthMax",Player.HealthMax);
         this.addCallback("Mana",Player.Mana);
         this.addCallback("ManaMax",Player.ManaMax);
         this.addCallback("Map",Player.Map);
         this.addCallback("Level",Player.Level);
         this.addCallback("Gold",Player.Gold);
         this.addCallback("HasTarget",Player.HasTarget);
         this.addCallback("IsAfk",Player.IsAfk);
         this.addCallback("AllSkillsAvailable",Player.AllSkillsAvailable);
         this.addCallback("SkillAvailable",Player.SkillAvailable);
         this.addCallback("Position",Player.Position);
         this.addCallback("WalkToPoint",Player.WalkToPoint);
         this.addCallback("CancelAutoAttack",Player.CancelAutoAttack);
         this.addCallback("CancelTarget",Player.CancelTarget);
         this.addCallback("CancelTargetSelf",Player.CancelTargetSelf);
         this.addCallback("MuteToggle",Player.MuteToggle);
         this.addCallback("AttackMonster",Player.AttackMonster);
         this.addCallback("Jump",Player.Jump);
         this.addCallback("Rest",Player.Rest);
         this.addCallback("Join",Player.Join);
         this.addCallback("Equip",Player.Equip);
         this.addCallback("EquipPotion",Player.EquipPotion);
         this.addCallback("GoTo",Player.GoTo);
         this.addCallback("UseBoost",Player.UseBoost);
         this.addCallback("UseSkill",Player.UseSkill);
         this.addCallback("ForceUseSkill",Player.ForceUseSkill);
         this.addCallback("GetMapItem",Player.GetMapItem);
         this.addCallback("Logout",Player.Logout);
         this.addCallback("HasActiveBoost",Player.HasActiveBoost);
         this.addCallback("UserID",Player.UserID);
         this.addCallback("CharID",Player.CharID);
         this.addCallback("Gender",Player.Gender);
         this.addCallback("SetEquip",Player.SetEquip);
         this.addCallback("GetEquip",Player.GetEquip);
         this.addCallback("Buff",Player.Buff);
         this.addCallback("PlayerData",Player.PlayerData);
         this.addCallback("GetFactions",Player.GetFactions);
         this.addCallback("ChangeName",Player.ChangeName);
         this.addCallback("ChangeGuild",Player.ChangeGuild);
         this.addCallback("SetTargetPlayer",Player.SetTargetPlayer);
         this.addCallback("ChangeAccessLevel",Player.ChangeAccessLevel);
         this.addCallback("GetTargetHealth",Player.GetTargetHealth);
         this.addCallback("CheckPlayerInMyCell",Player.CheckPlayerInMyCell);
         this.addCallback("GetSkillCooldown",Player.GetSkillCooldown);
         this.addCallback("SetSkillCooldown",Player.SetSkillCooldown);
         this.addCallback("SetSkillRange",Player.SetSkillRange);
         this.addCallback("SetSkillMana",Player.SetSkillMana);
         this.addCallback("SetTargetPvP",Player.SetTargetPvP);
         this.addCallback("GetAvatars",Player.GetAvatars);
         this.addCallback("IsMember",Player.IsMember);
         this.addCallback("IsAvatarLoadComplete",Player.IsAvatarLoadComplete);
         this.addCallback("MapLoadComplete",World.MapLoadComplete);
         this.addCallback("ReloadMap",World.ReloadMap);
         this.addCallback("PlayersInMap",World.PlayersInMap);
         this.addCallback("IsActionAvailable",World.IsActionAvailable);
         this.addCallback("GetMonstersInCell",World.GetMonstersInCell);
         this.addCallback("GetVisibleMonstersInCell",World.GetVisibleMonstersInCell);
         this.addCallback("GetMonsterHealth",World.GetMonsterHealth);
         this.addCallback("SetSpawnPoint",World.SetSpawnPoint);
         this.addCallback("IsMonsterAvailable",World.IsMonsterAvailable);
         this.addCallback("GetSkillName",World.GetSkillName);
         this.addCallback("GetCells",World.GetCells);
         this.addCallback("GetPads",World.GetPads);
         this.addCallback("GetItemTree",World.GetItemTree);
         this.addCallback("RoomId",World.RoomId);
         this.addCallback("RoomNumber",World.RoomNumber);
         this.addCallback("Players",World.Players);
         this.addCallback("PlayerByName",World.PlayerByName);
         this.addCallback("SetWalkSpeed",Player.SetWalkSpeed);
         this.addCallback("GetCellPlayers",World.GetCellPlayers);
         this.addCallback("CheckCellPlayer",World.CheckCellPlayer);
         this.addCallback("GetPlayerHealth",World.GetPlayerHealth);
         this.addCallback("GetPlayerHealthPercentage",World.GetPlayerHealthPercentage);
         this.addCallback("RejectDrop",World.RejectDrop);
         this.addCallback("SetMapQuestVal",World.SetMapQuestVal);
         this.addCallback("IsInProgress",Quests.IsInProgress);
         this.addCallback("Complete",Quests.Complete);
         this.addCallback("Accept",Quests.Accept);
         this.addCallback("LoadQuest",Quests.Load);
         this.addCallback("LoadQuests",Quests.LoadMultiple);
         this.addCallback("GetQuests",Quests.GetQuests);
         this.addCallback("GetQuestTree",Quests.GetQuestTree);
         this.addCallback("CanComplete",Quests.CanComplete);
         this.addCallback("IsAvailable",Quests.IsAvailable);
         this.addCallback("GetShops",Shops.GetShops);
         this.addCallback("LoadShop",Shops.Load);
         this.addCallback("LoadHairShop",Shops.LoadHairShop);
         this.addCallback("LoadArmorCustomizer",Shops.LoadArmorCustomizer);
         this.addCallback("SellItem",Shops.SellItem);
         this.addCallback("ResetShopInfo",Shops.ResetShopInfo);
         this.addCallback("IsShopLoaded",Shops.IsShopLoaded);
         this.addCallback("BuyItem",Shops.BuyItem);
         this.addCallback("GetBank",Bank.GetBank);
         this.addCallback("GetBankItems",Bank.GetBankItems);
         this.addCallback("GetBankItemByName",Bank.GetItemByName2);
         this.addCallback("BankSlots",Bank.BankSlots);
         this.addCallback("UsedBankSlots",Bank.UsedBankSlots);
         this.addCallback("TransferToBank",Bank.TransferToBank);
         this.addCallback("TransferToInventory",Bank.TransferToInventory);
         this.addCallback("BankSwap",Bank.BankSwap);
         this.addCallback("ShowBank",Bank.Show);
         this.addCallback("LoadBankItems",Bank.LoadBankItems);
         this.addCallback("GetInventoryItems",Inventory.GetInventoryItems);
         this.addCallback("GetInventoryItemByName",Inventory.GetItemByName2);
         this.addCallback("InventorySlots",Inventory.InventorySlots);
         this.addCallback("UsedInventorySlots",Inventory.UsedInventorySlots);
         this.addCallback("GetTempItems",TempInventory.GetTempItems);
         this.addCallback("ItemIsInTemp",TempInventory.ItemIsInTemp);
         this.addCallback("GetHouseItems",House.GetHouseItems);
         this.addCallback("HouseSlots",House.HouseSlots);
         this.addCallback("IsTemporarilyKicked",AutoRelogin.IsTemporarilyKicked);
         this.addCallback("Login",AutoRelogin.Login);
         this.addCallback("FixLogin",AutoRelogin.FixLogin);
         this.addCallback("ResetServers",AutoRelogin.ResetServers);
         this.addCallback("AreServersLoaded",AutoRelogin.AreServersLoaded);
         this.addCallback("Connect",AutoRelogin.Connect);
         this.addCallback("SetInfiniteRange",Settings.SetInfiniteRange);
         this.addCallback("SetProvokeMonsters",Settings.SetProvokeMonsters);
         this.addCallback("SetEnemyMagnet",Settings.SetEnemyMagnet);
         this.addCallback("SetLagKiller",Settings.SetLagKiller);
         this.addCallback("HidePlayers",Settings.HidePlayers);
         this.addCallback("SetSkipCutscenes",Settings.SetSkipCutscenes);
         this.addCallback("SetFPS",param1.SetFPS);
         this.addCallback("RealAddress",param1.RealAddress);
         this.addCallback("RealPort",param1.RealPort);
         this.addCallback("ServerName",param1.ServerName);
         this.addCallback("GetUsername",param1.GetUsername);
         this.addCallback("GetPassword",param1.GetPassword);
         this.addCallback("SetTitle",param1.SetTitle);
         this.addCallback("SendMessage",param1.SendMessage);
         this.addCallback("IsConnMCBackButtonVisible",param1.IsConnMCBackButtonVisible);
         this.addCallback("GetConnMC",param1.GetConnMC);
         this.addCallback("HideConnMC",param1.HideConnMC);
         this.addCallback("getGameObject",Caller.getGameObject);
         this.addCallback("getGameObjectS",Caller.getGameObjectS);
         this.addCallback("setGameObject",Caller.setGameObject);
         this.addCallback("getArrayObject",Caller.getArrayObject);
         this.addCallback("setArrayObject",Caller.setArrayObject);
         this.addCallback("callGameFunction",Caller.callGameFunction);
         this.addCallback("callGameFunction0",Caller.callGameFunction0);
         this.addCallback("selectArrayObjects",Caller.selectArrayObjects);
         this.addCallback("isNull",Caller.isNull);
         this.addCallback("sendClientPacket",Caller.sendClientPacket);
         this.debug("Externalizer::init done.");
      }
      
      public function addCallback(param1:String, param2:Function) : void
      {
         ExternalInterface.addCallback(param1,param2);
      }
      
      public function call(param1:String, ... rest) : *
      {
         return ExternalInterface.call(param1,rest);
      }
      
      public function debug(param1:String) : void
      {
         this.call("debug",param1);
      }
   }
}
