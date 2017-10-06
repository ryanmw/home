using DevLog.Data.Models.BaseModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DevLog.Data.Models
{
    public class Comment : StateInfo
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CommentId { get; set; }

        public string AuthorPhoto { get; set; }
 
        [StringLength(50)]
        [Required]
        public string Author { get; set; }

        [Required]
        public string Body { get; set; }

        [EmailAddress]
        [Required]
        [StringLength(75)]
        public string Email { get; set; }

        [Required]
        [StringLength(50)]
        public string IPAddress { get; set; }

        [Url]
        [StringLength(150)]
        public string Url { get; set; }

        public int ArticleId { get; set; }

        public bool IsEmailSubscribed { get; set; }

        public virtual Article Article  { get;  set; }
    }
}
