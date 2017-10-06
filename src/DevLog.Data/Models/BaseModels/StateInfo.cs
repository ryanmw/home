using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace DevLog.Data.Models.BaseModels
{
    public class StateInfo : CreatedStateInfo
    {
        [Column(TypeName = "datetime2")]
        public DateTime? UpdateDate { get; set; }
    }
}
