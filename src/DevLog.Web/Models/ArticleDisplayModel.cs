using System;
using System.Collections.Generic;

namespace DevLog.Web.Models
{
    public class ArticleDisplayModel
    {
       
        public int ArticleId { get; set; }

     
        public string Key { get; set; }

        public DateTime PublishedOn { get; set; }

  
        public string Title { get; set; }

   
        public string MetaDescription { get; set; }

       
        public string Body { get; set; }

       public ICollection<ArticleDisplayCommentItemModel> Comments { get; set; } = new List<ArticleDisplayCommentItemModel>();
    }
    
    public class ArticleDisplayCommentItemModel
    {

        public string Author { get; set; }

        public string Body { get; set; }

        public string Email { get; set; }

        public string Url { get; set; }

        public DateTime CreateDate { get; set; }
    }

}
