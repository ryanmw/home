using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DevLog.Web.Models
{
    public class EditArticleModel
    {
        public int ArticleId { get; set; }
 
        public DateTime PublishedOn { get; set; }

        [StringLength(75)]
        [Required]
        public string Title { get; set; }

        [StringLength(250)]
        [Required]
        public string MetaDescription { get; set; }

        [Required]
        public string Body { get; set; }

        public List<EditArticleCommentItemModel> Comments { get; set; } = new List<EditArticleCommentItemModel>();
    }

    public class EditArticleCommentItemModel
    {
        public int CommentId { get; set; }

        public string CommentDetails { get; set; }
    }
}
