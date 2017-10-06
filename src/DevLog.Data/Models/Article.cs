using DevLog.Data.Models.BaseModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DevLog.Data.Models
{
    public class Article : StateInfo
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ArticleId { get; set; }

        [StringLength(75)]
        [Required]
        public string Key { get; set; }

        public DateTime PublishedOn { get; set; }

        [StringLength(75)]
        [Required]
        public string Title { get; set; }

        [StringLength(250)]
        [Required]
        public string MetaDescription { get; set; }

        [Required]
        public string Body { get; set; }
 
        public ICollection<Comment> Comments { get; set; } = new List<Comment>();

    }
}
