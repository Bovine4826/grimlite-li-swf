package grimoire
{
   import flash.utils.*;
   
   public class Caller
   {
      
      private static var _gameClass:Class;
      
      private static var _handler:*;
       
      
      public function Caller()
      {
         super();
      }
      
      public static function getGameObject(param1:String) : String
      {
         return JSON.stringify(_getObjectS(Root.Game,param1));
      }
      
      public static function getGameObjectS(param1:String) : String
      {
         if(_gameClass == null)
         {
            _gameClass = Root.GameDomain.getDefinition(getQualifiedClassName(Root.Game)) as Class;
         }
         var _loc2_:* = _getObjectS(_gameClass,param1);
         return JSON.stringify(_loc2_);
      }
      
      public static function setGameObject(param1:String, param2:*) : void
      {
         var _loc3_:Array = param1.split(".");
         var _loc4_:String = _loc3_.pop();
         var _loc5_:*;
         (_loc5_ = _getObjectA(Root.Game,_loc3_))[_loc4_] = param2;
      }
      
      public static function getArrayObject(param1:String, param2:int) : String
      {
         var _loc3_:* = _getObjectS(Root.Game,param1);
         return JSON.stringify(_loc3_[param2]);
      }
      
      public static function setArrayObject(param1:String, param2:int, param3:*) : void
      {
         var _loc4_:*;
         (_loc4_ = _getObjectS(Root.Game,param1))[param2] = param3;
      }
      
      public static function callGameFunction(param1:String, ... rest) : String
      {
         var _loc3_:Array = param1.split(".");
         var _loc4_:String = _loc3_.pop();
         var _loc5_:*;
         var _loc6_:Function = (_loc5_ = _getObjectA(Root.Game,_loc3_))[_loc4_] as Function;
         return JSON.stringify(_loc6_.apply(null,rest));
      }
      
      public static function callGameFunction0(param1:String) : String
      {
         var _loc2_:Array = param1.split(".");
         var _loc3_:String = _loc2_.pop();
         var _loc4_:*;
         var _loc5_:Function = (_loc4_ = _getObjectA(Root.Game,_loc2_))[_loc3_] as Function;
         return JSON.stringify(_loc5_.apply());
      }
      
      public static function selectArrayObjects(param1:String, param2:String) : String
      {
         var _loc3_:* = _getObjectS(Root.Game,param1);
         if(!(_loc3_ is Array))
         {
            Externalizer.debugS("selectArrayObjects target is not an array");
            return "";
         }
         var _loc4_:Array = _loc3_ as Array;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_.push(_getObjectS(_loc4_[_loc6_],param2));
            _loc6_++;
         }
         return JSON.stringify(_loc5_);
      }
      
      public static function _getObjectS(param1:Object, param2:String) : Object
      {
         return _getObjectA(param1,param2.split("."));
      }
      
      public static function _getObjectA(param1:Object, param2:Array) : Object
      {
         var _loc3_:Object = param1;
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = _loc3_[param2[_loc4_]];
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function isNull(param1:String) : String
      {
         try
         {
            return (_getObjectS(Root.Game,param1) == null).toString();
         }
         catch(ex:Error)
         {
         }
         return "true";
      }
      
      public static function sendClientPacket(param1:String, param2:String) : void
      {
         var _loc3_:Class = null;
         Externalizer.debugS("type: " + param2);
         if(_handler == null)
         {
            _loc3_ = Class(Root.GameDomain.getDefinition("it.gotoandplay.smartfoxserver.handlers.ExtHandler"));
            _handler = new _loc3_(Root.Game.sfc);
         }
         if(param2 == "xml")
         {
            xmlReceived(param1);
         }
         else if(param2 == "json")
         {
            jsonReceived(param1);
         }
         else if(param2 == "str")
         {
            strReceived(param1);
         }
         else
         {
            Externalizer.debugS("Invalid packet type.");
         }
      }
      
      public static function xmlReceived(param1:String) : void
      {
         _handler.handleMessage(new XML(param1),"xml");
      }
      
      public static function jsonReceived(param1:String) : void
      {
         _handler.handleMessage(JSON.parse(param1)["b"],"json");
      }
      
      public static function strReceived(param1:String) : void
      {
         var _loc2_:Array = param1.substr(1,param1.length - 2).split("%");
         _handler.handleMessage(_loc2_.splice(1,_loc2_.length - 1),"str");
      }
   }
}
