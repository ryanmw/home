using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;

namespace RMW.Models
{
    public class User
    {
        [Key]
        public virtual int Id { get; set; }

        [Required]
        public virtual String Username { get; set; }

        public virtual String Email { get; set; }

        [Required, DataType(DataType.Password)]
        public virtual String Password { get; set; }
 
        [DataType(DataType.MultilineText)]
        public virtual String Comment { get; set; }

        public virtual Boolean IsApproved { get; set; }
        public virtual int PasswordFailuresSinceLastSuccess { get; set; }
        public virtual DateTime? LastPasswordFailureDate { get; set; }
        public virtual DateTime? LastActivityDate { get; set; }
        public virtual DateTime? LastLockoutDate { get; set; }
        public virtual DateTime? LastLoginDate { get; set; }
        public virtual String ConfirmationToken { get; set; }
        public virtual DateTime? CreateDate { get; set; }
        public virtual Boolean IsLockedOut { get; set; }
        public virtual DateTime? LastPasswordChangedDate { get; set; }
        public virtual String PasswordVerificationToken { get; set; }
        public virtual DateTime? PasswordVerificationTokenExpirationDate { get; set; }

        public virtual ICollection<Role> Roles { get; set; }
    }


    public class Role
    {
        [Key]
        public virtual Guid RoleId { get; set; }

        [Required]
        public virtual string RoleName { get; set; }

        public virtual string Description { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }

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

        private ICollection<Comment> _comments = null;

        public virtual ICollection<Comment> Comments
        {
            get
            {
                return _comments;
            }
            set
            {
                _comments = value;
            }
        }


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

    public class Comment
    {
        public int Id { get; set; }

        public string AuthorPhoto { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime? UpdatedOn { get; set; }

        [StringLength(50)]
        [Required]
        public string Author {get;set;}

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

    public class Log4Net
    {
        public int ID {get;set;}

        public DateTime Date {get;set;}

        [StringLength(255)]
        [Required]
        public string Thread {get;set;}

        [StringLength(50)]
        [Required]
        public string Level {get;set;}

        [StringLength(255)]
        [Required]
        public string Logger {get;set;}

        [Required]
        public string Message {get;set;}

        public string Exception {get;set;}

        public string Location { get; set; }

    }
}