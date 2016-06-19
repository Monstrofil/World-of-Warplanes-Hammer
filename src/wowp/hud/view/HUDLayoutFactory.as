package wowp.hud.view
{
   import wowp.hud.core.layout.IHUDLayoutFactory;
   import flash.utils.Dictionary;
   import wowp.hud.core.layout.HUDLayout;
   
   public class HUDLayoutFactory implements IHUDLayoutFactory
   {
       
      private var _id:String;
      
      private var _map:Dictionary;
      
      private var _instances:Dictionary;
      
      public function HUDLayoutFactory(param1:String)
      {
         super();
         this._id = param1;
         this._map = new Dictionary();
         this._instances = new Dictionary();
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function getLayout(param1:Class) : HUDLayout
      {
         var _loc3_:HUDLayout = null;
         var _loc2_:Class = this._map[param1] as Class;
         if(_loc2_)
         {
            if(this._instances[_loc2_] == null)
            {
               _loc3_ = new _loc2_() as HUDLayout;
               if(_loc3_)
               {
                  this._instances[_loc2_] = _loc3_;
                  return _loc3_;
               }
            }
            else
            {
               return this._instances[_loc2_] as HUDLayout;
            }
         }
         return new HUDLayout();
      }
      
      public function mapLayout(param1:Class, param2:Class) : void
      {
         this._map[param2] = param1;
      }
      
      public function toString() : String
      {
         return "[HUDLayoutFactory id=\'" + this._id + "\']";
      }
   }
}
