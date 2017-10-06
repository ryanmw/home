using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DevLog.Web.Models
{
    public class ArticlePageModel
    {
        public List<ArticlePageItemModel> Items { get; set; } = new List<ArticlePageItemModel>();

        public int PageCount { get; set; }

        public int PageNumber { get; set; }
    }

    public class ArticlePageItemModel
    {
        public int ArticleId { get; set; }

        public string URLTo { get; set; }

        public string MetaDescription { get; set; }

        public string Title { get; set; }

        public DateTime PublishedOn { get; set; }

        public int CommentCount { get;  set; }
    }
     
}
