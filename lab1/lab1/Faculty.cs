using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using CsvHelper.Configuration.Attributes;

namespace lab1
{
    public class Faculty
    {
        [Index(0), Key]
        public ulong fid { get; set; }
#nullable enable
        [Index(1)]
        public string? fname { get; set; }
        [Index(2)]
        public ulong? deptid { get; set; }
    }
}
