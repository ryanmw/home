using Microsoft.AspNetCore.Identity;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace DevLog.Data.Models.BaseModels
{
    public class ApplicationUserStateInfo : IdentityUser
    {
        [Column(TypeName = "datetime2")]
        public DateTime CreateDate { get; set; }

        [Column(TypeName = "datetime2")]
        public DateTime? UpdateDate { get; set; }
    }
}
