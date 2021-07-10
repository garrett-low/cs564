using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using CsvHelper.Configuration.Attributes;

namespace lab1
{
    public class Class
    {
        [Index(0), Key]
        public string cname { get; set; }
#nullable enable
        [Index(1)]
        public string? meets_at { get; set; }
        [Index(2)]
        public string? room { get; set; }
        [Index(3)]
        public ulong? fid { get; set; }
    }
}
