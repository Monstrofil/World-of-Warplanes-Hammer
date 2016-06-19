package wowp.core.layers.context.events
{
   import flash.events.Event;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   import flash.display.Sprite;
   
   public class AddContextMenuEvent extends Event
   {
      
      public static const TYPE:String = "wowp.core.layers.context.events.AddContextMenu";
       
      public var data:IDataProvider;
      
      public var background:Class;
      
      public var padding:Padding;
      
      public var offset:Number;
      
      public var submenuGap:int = 4;
      
      public var x:Number;
      
      public var y:Number;
      
      public var dx:Number;
      
      public var dy:Number;
      
      public var id:String;
      
      public var owner:Sprite;
      
      public function AddContextMenuEvent(param1:IDataProvider, param2:Sprite = null, param3:String = null)
      {
         this.data = param1;
         this.owner = param2;
         this.id = param3;
         super(TYPE,true,true);
      }
   }
}
