using DevLog.Data.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DevLog.Web.Models
{
    public class SiteMapItemModel
    {
        public string Url { get; set; }

        public DateTime LastMode { get; set; }

        public ChangeFrequency ChangeFrequency { get; set; }

        public double Priority { get; set; }
    }
}
