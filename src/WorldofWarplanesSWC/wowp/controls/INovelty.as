package wowp.controls
{
   import flash.display.DisplayObject;
   
   public interface INovelty
   {
       
      function updateView() : void;
      
      function update(param1:DisplayObject = null, param2:Boolean = false) : void;
      
      function get scaleX() : Number;
      
      function set scaleX(param1:Number) : void;
      
      function get scaleY() : Number;
      
      function set scaleY(param1:Number) : void;
      
      function get state() : String;
      
      function get offset() : int;
      
      function set offset(param1:int) : void;
      
      function get direction() : String;
      
      function set direction(param1:String) : void;
      
      function get title() : String;
      
      function set title(param1:String) : void;
      
      function get id() : String;
      
      function set id(param1:String) : void;
   }
}
