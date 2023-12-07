package grimoire.game
{
   import grimoire.*;
   
   public class Settings
   {
       
      
      public function Settings()
      {
         super();
      }
      
      public static function SetInfiniteRange() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ <= 5)
         {
            Root.Game.world.actions.active[_loc1_].range = 20000;
            _loc1_++;
         }
      }
      
      public static function SetProvokeMonsters() : void
      {
         Root.Game.world.aggroAllMon();
      }
      
      public static function SetEnemyMagnet() : void
      {
         if(Root.Game.world.myAvatar.target != null)
         {
            Root.Game.world.myAvatar.target.pMC.x = Root.Game.world.myAvatar.pMC.x;
            Root.Game.world.myAvatar.target.pMC.y = Root.Game.world.myAvatar.pMC.y;
         }
      }
      
      public static function SetLagKiller(param1:String) : void
      {
         Root.Game.world.visible = param1 == "False";
      }
      
      public static function HidePlayers(enabled:Boolean) : void
      {
         for(var param1 in Root.Game.world.avatars)
         {
            var avatar:* = Root.Game.world.avatars[Number(param1)];
            if(!avatar.isMyAvatar && avatar.pMC)
            {
               avatar.pMC.mcChar.visible = !enabled;
               avatar.pMC.pname.visible = !enabled;
               avatar.pMC.shadow.visible = !enabled;
               if(avatar.petMC)
               {
                  avatar.petMC.visible = !enabled;
               }
            }
         }
      }
      
      public static function SetSkipCutscenes() : void
      {
         while(Root.Game.mcExtSWF.numChildren > 0)
         {
            Root.Game.mcExtSWF.removeChildAt(0);
         }
         Root.Game.world.visible = true;
         Root.Game.showInterface();
      }
      
      public static function SetWalkSpeed(param1:String) : void
      {
         Root.Game.world.WALKSPEED = parseInt(param1);
      }
   }
}
