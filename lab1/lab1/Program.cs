using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Globalization;
using Microsoft.Data.Sqlite;
using CsvHelper;
using CsvHelper.Configuration;
using Microsoft.EntityFrameworkCore;
using EFCore.BulkExtensions;

namespace lab1
{
    class Program
    {
        static void Main(string[] args)
        {
            string connString = "Data Source=W:\\source\\repos\\cs564\\testFiles\\lab1-" + DateTime.Now.ToString("o").Replace(":", ".") + ".db";

            Console.WriteLine("Hello World!");
            var config = new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = false,
                Delimiter = ","
            };
            using (var reader = new StreamReader("W:\\source\\repos\\cs564\\testFiles\\Class.csv"))
            using (var csv = new CsvReader(reader, config))
            {
                var classes = csv.GetRecords<Class>().ToList();
                var enrolls = csv.GetRecords<Enroll>().ToList();
                var faculties = csv.GetRecords<Faculty>().ToList();
                var students = csv.GetRecords<Student>().ToList();

                var contextOptions = new DbContextOptionsBuilder<Lab1Context>()
    .UseSqlite(connString)
    .Options;

                using (var context = new Lab1Context(contextOptions))
                {
                    context.Database.EnsureCreated();

                    using (var transaction = context.Database.BeginTransaction())
                    {
                        context.BulkInsertOrUpdate(classes);
                        context.BulkInsertOrUpdate(enrolls);
                        context.BulkInsertOrUpdate(faculties);
                        context.BulkInsertOrUpdate(students);
                        transaction.Commit();
                    }
                }
            }
        }
    }
}
