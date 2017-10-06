using DevLog.Data.Models.BaseModels;
using System.ComponentModel.DataAnnotations;

namespace DevLog.Data.Models
{
    public class ApplicationUser : ApplicationUserStateInfo
    {
        public ApplicationUser()
        {

        }

        [StringLength(36)]
        public override string Id
        {
            get
            {
                return base.Id;
            }

            set
            {
                base.Id = value;
            }
        }


    }
}
