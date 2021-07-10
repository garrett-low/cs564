using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace lab1
{
    class Lab1Context : DbContext
    {
        public Lab1Context(DbContextOptions<Lab1Context> options)
            : base(options)
        {
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Enroll>()
                .HasKey(c => new { c.snum, c.cname });
        }
        public DbSet<Class> Class { get; set; }
        public DbSet<Enroll> Enroll { get; set; }
        public DbSet<Faculty> Faculty { get; set; }
        public DbSet<Student> Student { get; set; }
    }
}
