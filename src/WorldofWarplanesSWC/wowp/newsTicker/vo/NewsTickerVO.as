package wowp.newsTicker.vo
{
   public class NewsTickerVO
   {
       
      public var id:String;
      
      public var title:String;
      
      public var description:String;
      
      public function NewsTickerVO(param1:Object)
      {
         super();
         this.id = param1.id;
         this.title = param1.title;
         this.description = param1.description;
      }
      
      public function toString() : String
      {
         return "[NewsTickerVO: id:" + this.id + ", title:" + this.title + ", description:" + this.description + "]";
      }
   }
}
