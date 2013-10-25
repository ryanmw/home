using System;
using System.ComponentModel.DataAnnotations;

namespace RMW.Models
{
    public class Comment
    {
        public int Id { get; set; }

        public string AuthorPhoto { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime? UpdatedOn { get; set; }

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
    }

}
