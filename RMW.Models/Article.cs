using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;

namespace RMW.Models
{
    public class Article
    {
        public int Id { get; set; }

        [StringLength(75)]
        [Required]
        public string Key { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime? UpdatedOn { get; set; }

        [StringLength(75)]
        [Required]
        public string Title { get; set; }

        [StringLength(250)]
        [Required]
        public string MetaDescription { get; set; }

        [Required]
        public string Body { get; set; }

        public Article()
        {
            Comments = null;
        }

        public ICollection<Comment> Comments { get; set; }

        /// <summary>
        /// A link to the article
        /// </summary>
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public string URLTo
        {
            get
            {
                return
                    System.Web.VirtualPathUtility.ToAbsolute(string.Format(
                        CultureInfo.InvariantCulture,
                        "~/articles/{0}/{1}/{2}/{3}",
                        this.CreatedOn.Year.ToString("0000", CultureInfo.InvariantCulture),
                        this.CreatedOn.Month.ToString("00", CultureInfo.InvariantCulture),
                        this.CreatedOn.Day.ToString("00", CultureInfo.InvariantCulture),
                        this.Key));
            }
        }
    }

}
