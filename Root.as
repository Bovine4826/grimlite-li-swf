package grimoire
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.ui.*;
   import flash.utils.*;
   import grimoire.game.*;
   import grimoire.tools.*;
   
   public class Root extends MovieClip
   {
      
      public static var GameDomain:ApplicationDomain;
      
      public static var Game:*;
      
      public static const TrueString:String = "\"True\"";
      
      public static const FalseString:String = "\"False\"";
      
      public static var Username:String;
      
      public static var Password:String;
       
      
      private const sTitle:String = "Grimlite Li";
      
      private const sURL:String = "https://game.aq.com/game/";
      
      private const versionURL:String = this.sURL + "api/data/gameversion";
      
      private const LoginURL:* = this.sURL + "api/login/now";
      
      private var urlLoader:URLLoader;
      
      private var loader:Loader;
      
      private var loaderVars:Object;
      
      private var external:Externalizer;
      
      private var sFile:String;
      
      private var sBG:String;
      
      private var isEU:Boolean;
      
      private var isWeb:Boolean;
      
      private var doSignup:Boolean;
      
      private var stg:Object;
      
      private var vars:URLVariables;
      
      private var serversLoader:URLLoader;
      
      public var mcLoading:MovieClip;
      
      private var myTimer:Timer;
      
      public function Root()
      {
         this.serversLoader = new URLLoader();
         this.myTimer = new Timer(200);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.OnAddedToStage);
      }
      
      private function OnAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.OnAddedToStage);
         Security.allowDomain("*");
         this.urlLoader = new URLLoader();
         this.urlLoader.addEventListener(Event.COMPLETE,this.OnDataComplete);
         this.urlLoader.load(new URLRequest(this.versionURL));
      }
      
      private function OnDataComplete(param1:Event) : void
      {
         this.urlLoader.removeEventListener(Event.COMPLETE,this.OnDataComplete);
         var _loc2_:Object = JSON.parse(param1.target.data);
         this.sFile = _loc2_.sFile + "?ver=" + _loc2_.sVersion;
         this.isEU = _loc2_.isEU == "true";
         this.isWeb = false;
         this.doSignup = false;
         this.sBG = _loc2_.sBG;
         this.loaderVars = _loc2_;
         this.LoadGame();
      }
      
      private function LoadGame() : void
      {
         this.external = new Externalizer();
         this.external.init(this);
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.OnProgress);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.OnComplete);
         this.loader.load(new URLRequest(this.sURL + "gamefiles/" + this.sFile));
         this.mcLoading.strLoad.text = "Loading 0%";
      }
      
      private function OnProgress(param1:ProgressEvent) : void
      {
         this.external.call("progress",Math.round(Number(param1.currentTarget.bytesLoaded / param1.currentTarget.bytesTotal) * 100));
         var _loc2_:int = param1.currentTarget.bytesLoaded / param1.currentTarget.bytesTotal * 100;
         this.mcLoading.strLoad.text = "Loading " + _loc2_ + "%";
      }
      
      private function OnComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.OnProgress);
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.OnComplete);
         this.stg = stage;
         this.stg.removeChildAt(0);
         Game = this.stg.addChildAt(param1.currentTarget.content,0);
         for(_loc2_ in root.loaderInfo.parameters)
         {
            Game.params[_loc2_] = root.loaderInfo.parameters[_loc2_];
         }
         Game.params.vars = this.loaderVars;
         Game.params.sURL = this.sURL;
         Game.params.sBG = this.sBG;
         Game.params.sTitle = this.sTitle;
         Game.params.loginURL = this.LoginURL;
         Game.params.isEU = this.isEU;
         Game.params.isWeb = this.isWeb;
         Game.params.doSignup = this.doSignup;
         Game.params.test = false;
         Game.sfc.addEventListener(SFSEvent.onExtensionResponse,this.OnExtensionResponse);
         GameDomain = LoaderInfo(param1.target).applicationDomain;
         Game.sfc.addEventListener(SFSEvent.onConnectionLost,this.OnConnectionLost);
         Game.sfc.addEventListener(SFSEvent.onConnection,this.OnConnection);
         Game.sfc.addEventListener(SFSEvent.onJoinRoomError,this.OnJoinRoomError);
         Game.sfc.addEventListener(SFSEvent.onDebugMessage,this.PacketReceived);
         Game.loginLoader.addEventListener(Event.COMPLETE,this.OnLoginComplete);
         addEventListener(Event.ENTER_FRAME,this.EnterFrame);
         trace("OnComplete Stage");
      }
      
      private function getServers() : *
      {
         var urlServers:String = "https://game.aq.com/game/api/data/servers";
         var request:URLRequest = new URLRequest(urlServers);
         request.method = URLRequestMethod.GET;
         this.serversLoader.addEventListener(Event.COMPLETE,this.OnServersLoaded);
         try
         {
            this.serversLoader.load(request);
         }
         catch(e:*)
         {
            trace("Failed to getting servers info.");
         }
      }
      
      private function OnServersLoaded(param1:Event) : *
      {
         var _loc2_:Object = JSON.parse(param1.target.data);
         this.external.call("getServers2",JSON.stringify(_loc2_));
         this.serversLoader.removeEventListener(Event.COMPLETE,this.OnServersLoaded);
      }
      
      private function OnConnectionLost(param1:*) : void
      {
         this.external.call("connection","OnConnectionLost");
         Game.gotoAndPlay(!!Game.litePreference.data.bCharSelect ? "Select" : "Login");
      }
      
      private function OnConnection(param1:*) : void
      {
         this.external.call("connection","OnConnection");
         this.RemoveCharSelectUI();
      }
      
      private function OnJoinRoomError(param1:*) : void
      {
         this.external.debug("OnJoinRoomError");
      }
      
      private function OnLoginComplete(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = JSON.parse(param1.target.data);
         this.external.call("getServers",JSON.stringify(_loc2_));
         _loc2_.login.iUpg = 10;
         _loc2_.login.iUpgDays = 999;
         for(_loc3_ in _loc2_.servers)
         {
            _loc2_.servers[_loc3_].sName = _loc2_.servers[_loc3_].sName;
         }
         param1.target.data = JSON.stringify(_loc2_);
         if(Game.mcCharSelect)
         {
            Game.mcCharSelect.Game.objLogin = _loc2_;
         }
      }
      
      private function EnterFrame(param1:Event) : void
      {
         if(Game.mcLogin != null && Game.mcLogin.ni != null && Game.mcLogin.pi != null && Game.mcLogin.btnLogin != null)
         {
            Game.mcLogin.btnLogin.removeEventListener(MouseEvent.CLICK,this.onLoginClick);
            Game.mcLogin.btnLogin.addEventListener(MouseEvent.CLICK,this.onLoginClick);
            Game.mcLogin.removeEventListener(KeyboardEvent.KEY_DOWN,this.onLoginKeyEnter);
            Game.mcLogin.addEventListener(KeyboardEvent.KEY_DOWN,this.onLoginKeyEnter);
         }
         if(Game.mcCharSelect != null)
         {
            Game.mcCharSelect.btnLogin.removeEventListener(MouseEvent.CLICK,Game.mcCharSelect.onBtnLogin);
            Game.mcCharSelect.btnLogin.addEventListener(MouseEvent.CLICK,this.onBtnLogin);
            Game.mcCharSelect.btnServer.removeEventListener(MouseEvent.CLICK,Game.mcCharSelect.onBtnServer);
            Game.mcCharSelect.btnServer.addEventListener(MouseEvent.CLICK,this.onBtnServer);
            Game.mcCharSelect.passwordui.txtPassword.removeEventListener(KeyboardEvent.KEY_DOWN,Game.mcCharSelect.passwordui.onPasswordEnter);
            Game.mcCharSelect.passwordui.txtPassword.addEventListener(KeyboardEvent.KEY_DOWN,this.onPasswordEnter);
         }
         if(Game.mcConnDetail != null)
         {
            Game.mcConnDetail.addEventListener(Event.ADDED_TO_STAGE,this.AddedStageConnDetail);
            if(Game.mcConnDetail.txtDetail.text.indexOf("Error loading bank") >= 0 || Game.mcConnDetail.txtDetail.text.indexOf("Communication with server has been lost") >= 0)
            {
               Game.mcConnDetail.hideConn();
            }
         }
      }
      
      private function AddedStageConnDetail(param1:Event) : void
      {
         Game.mcConnDetail.removeEventListener(Event.ADDED_TO_STAGE,this.AddedStageConnDetail);
         var _loc2_:Object = {
            "text":Game.mcConnDetail.txtDetail.text,
            "btnBack":Game.mcConnDetail.btnBack.visible
         };
         this.external.call("currentConnDetail",JSON.stringify(_loc2_));
         trace("Added Conn Detail : " + JSON.stringify(_loc2_));
         if(Game.mcConnDetail.btnBack.visible)
         {
            this.HideConnMC();
         }
      }
      
      private function onLoginClick(param1:MouseEvent) : void
      {
         Username = Game.mcLogin.ni.text;
         Password = Game.mcLogin.pi.text;
      }
      
      private function onLoginKeyEnter(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            Username = Game.mcLogin.ni.text;
            Password = Game.mcLogin.pi.text;
         }
      }
      
      public function onBtnServer(param1:MouseEvent) : void
      {
         Game.mcCharSelect.skipServers = false;
         var _loc2_:* = Game.mcCharSelect.mngr.displayAvts[Game.mcCharSelect.pos].loginInfo;
         if(_loc2_.bAsk)
         {
            Game.mcCharSelect.utl.close(1);
            Game.mcCharSelect.passwordui.pos = Game.mcCharSelect.pos;
            Game.mcCharSelect.passwordui.bCharOpts = false;
            Game.mcCharSelect.passwordui.visible = true;
         }
         else
         {
            this.Login();
            this.RemoveCharSelectUI();
         }
      }
      
      private function onBtnLogin(param1:MouseEvent) : void
      {
         Game.mcCharSelect.skipServers = true;
         this.Login();
         this.myTimer.addEventListener(TimerEvent.TIMER,this.WaitServersLoad);
         this.myTimer.start();
         this.RemoveCharSelectUI();
      }
      
      private function onPasswordEnter(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         if(param1.keyCode == Keyboard.ENTER)
         {
            _loc2_ = Game.mcCharSelect.mngr.displayAvts[Game.mcCharSelect.pos].loginInfo;
            if(_loc2_.strPassword != Game.mcCharSelect.passwordui.txtPassword.text)
            {
               Game.mcCharSelect.passwordui.txtWarning.visible = true;
            }
            else if(Game.mcCharSelect.passwordui.bCharOpts)
            {
               Game.mcCharSelect.charoptionsui.setOff();
            }
            else
            {
               this.Login();
               this.RemoveCharSelectUI();
            }
         }
      }
      
      private function WaitServersLoad(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(AutoRelogin.AreServersLoaded() == Root.TrueString)
         {
            this.myTimer.removeEventListener(TimerEvent.TIMER,this.WaitServersLoad);
            this.myTimer.stop();
            _loc2_ = String(Game.mcCharSelect.mngr.displayAvts[Game.mcCharSelect.pos].server);
            AutoRelogin.Connect(_loc2_);
         }
      }
      
      private function RemoveCharSelectUI() : void
      {
         if(Game.mcCharSelect != null)
         {
            if(Game.mcCharSelect.parent != null)
            {
               MovieClip(Game.mcCharSelect.parent).removeChild(Game.mcCharSelect);
               this.external.debug("mcCharSelect cleared");
            }
         }
      }
      
      private function Login() : void
      {
         Username = Game.mcCharSelect.mngr.displayAvts[Game.mcCharSelect.pos].loginInfo.strUsername;
         Password = Game.mcCharSelect.mngr.displayAvts[Game.mcCharSelect.pos].loginInfo.strPassword;
         AutoRelogin.Login();
      }
      
      private function OnExtensionResponse(param1:*) : void
      {
         this.external.call("pext",JSON.stringify(param1));
      }
      
      private function PacketReceived(param1:*) : void
      {
         if(param1.params.message.indexOf("%xt%zm%") > -1)
         {
            this.external.call("packetFromClient",param1.params.message.replace(/^\s+|\s+$/g,""));
         }
         else
         {
            this.external.call("packetFromServer",this.ProcessPacket(param1.params.message));
         }
      }
      
      private function ProcessPacket(param1:String) : String
      {
         var _loc2_:int = 0;
         if(param1.indexOf("[Sending - STR]: ") > -1)
         {
            param1 = param1.replace("[Sending - STR]: ","");
         }
         if(param1.indexOf("[ RECEIVED ]: ") > -1)
         {
            param1 = param1.replace("[ RECEIVED ]: ","");
         }
         if(param1.indexOf("[Sending]: ") > -1)
         {
            param1 = param1.replace("[Sending]: ","");
         }
         if(param1.indexOf(", (len: ") > -1)
         {
            _loc2_ = param1.indexOf(", (len: ");
            param1 = param1.slice(0,_loc2_);
         }
         return param1;
      }
      
      public function ServerName() : String
      {
         return "\"" + Game.objServerInfo.sName + "\"";
      }
      
      public function RealAddress() : String
      {
         return "\"" + Game.objServerInfo.RealAddress + "\"";
      }
      
      public function RealPort() : String
      {
         return "\"" + Game.objServerInfo.RealPort + "\"";
      }
      
      public function GetUsername() : String
      {
         return "\"" + Username + "\"";
      }
      
      public function GetPassword() : String
      {
         return "\"" + Password + "\"";
      }
      
      public function SetFPS(param1:String) : void
      {
         this.stg.frameRate = parseInt(param1);
      }
      
      public function SetTitle(param1:String) : void
      {
         Game.mcLogin.mcLogo.txtTitle.htmlText = "<font color=\"#FFB231\">New Release:</font> " + param1;
         Game.params.sTitle.htmlText = "<font color=\"#FFB231\">New Release:</font> " + param1;
      }
      
      public function SendMessage(param1:String) : void
      {
         Game.chatF.pushMsg("server",param1,"SERVER","",0);
      }
      
      public function IsConnMCBackButtonVisible() : String
      {
         return Boolean(Game.mcConnDetail.btnBack.visible) && Game.mcConnDetail.stage != null ? TrueString : FalseString;
      }
      
      public function GetConnMC() : String
      {
         return Game.mcConnDetail.stage == null ? "" : String(Game.mcConnDetail.txtDetail.text);
      }
      
      public function HideConnMC() : void
      {
         Game.mcConnDetail.hideConn();
      }
   }
}
