using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DevLog.Data.Models
{
    public class Log4Net
    {
        public int ID { get; set; }

        public DateTime Date { get; set; }

        [StringLength(255)]
        [Required]
        public string Thread { get; set; }

        [StringLength(50)]
        [Required]
        public string Level { get; set; }

        [StringLength(255)]
        [Required]
        public string Logger { get; set; }

        [Required]
        public string Message { get; set; }

        public string Exception { get; set; }

        public string Location { get; set; }

    }
}
