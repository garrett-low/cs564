using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using CsvHelper.Configuration.Attributes;

namespace lab1
{
    public class Student
    {
        [Index(0), Key]
        public ulong snum { get; set; }
#nullable enable
        [Index(1)]
        public string? sname { get; set; }
        [Index(2)]
        public string? major { get; set; }
        [Index(3)]
        public string? level { get; set; }
        [Index(4)]
        public int? age { get; set; }
    }
}
