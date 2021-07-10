using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using CsvHelper.Configuration.Attributes;

namespace lab1
{
    public class Enroll
    {
        [Index(0)]
        public ulong snum { get; set; }
        [Index(1)]
        public string cname { get; set; }
    }
}
