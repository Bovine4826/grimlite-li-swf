package grimoire.game
{
   import grimoire.*;
   
   public class AutoRelogin
   {
       
      
      public function AutoRelogin()
      {
         super();
      }
      
      public static function IsTemporarilyKicked() : String
      {
         return Root.Game.mcLogin != null && Root.Game.mcLogin.btnLogin != null && Root.Game.mcLogin.btnLogin.visible == false ? String(Root.TrueString) : String(Root.FalseString);
      }
      
      public static function Login() : void
      {
         if(Root.Game.charCount() > 0)
         {
            Root.Game.removeAllChildren();
            Root.Game.gotoAndPlay("Login");
         }
         Root.Game.login(Root.Game.mcLogin.ni.text,Root.Game.mcLogin.pi.text);
      }
      
      public static function FixLogin(param1:String, param2:String) : void
      {
         if(Root.Game.charCount() > 0)
         {
            Root.Game.removeAllChildren();
            Root.Game.gotoAndPlay("Login");
         }
         Root.Username = param1;
         Root.Password = param2;
         Root.Game.login(param1,param2);
      }
      
      public static function ResetServers() : String
      {
         try
         {
            Root.Game.serialCmd.servers = [];
            Root.Game.world.strMapName = "";
            return Root.TrueString;
         }
         catch(e:*)
         {
            return Root.FalseString;
         }
      }
      
      public static function AreServersLoaded() : String
      {
         if(Root.Game.serialCmd != null)
         {
            if(Root.Game.serialCmd.servers != null)
            {
               return Root.Game.serialCmd.servers.length > 0 ? String(Root.TrueString) : String(Root.FalseString);
            }
         }
         return Root.FalseString;
      }
      
      public static function Connect(param1:String) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in Root.Game.serialCmd.servers)
         {
            if(_loc2_.sName == param1)
            {
               _loc2_.iMax = 5000;
               Root.Game.objServerInfo = _loc2_;
               Root.Game.chatF.iChat = _loc2_.iChat;
               break;
            }
         }
         Root.Game.connectTo(Root.Game.objServerInfo.sIP,Root.Game.objServerInfo.iPort);
      }
   }
}
