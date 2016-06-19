package wowp.utils.data.binding
{
   public class Signal
   {
       
      protected var _slots:Vector.<Function>;
      
      public function Signal()
      {
         super();
         this._slots = new Vector.<Function>();
      }
      
      public function add(param1:Function) : void
      {
         if(this._slots.indexOf(param1) == -1)
         {
            this._slots[this._slots.length] = param1;
         }
      }
      
      public function get amount() : uint
      {
         return this._slots.length;
      }
      
      public function remove(param1:Function) : void
      {
         var _loc2_:int = this._slots.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._slots.splice(_loc2_,1);
         }
      }
      
      public function fire(... rest) : void
      {
         var _loc3_:Function = null;
         var _loc2_:Vector.<Function> = this._slots.slice();
         for each(_loc3_ in _loc2_)
         {
            if(this._slots.indexOf(_loc3_) != -1)
            {
               _loc3_.apply(null,rest);
            }
         }
      }
      
      public function dispose() : void
      {
         this._slots.length = 0;
      }
   }
}
