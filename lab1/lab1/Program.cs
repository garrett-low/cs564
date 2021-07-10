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
            List<Class> classes;
            List<Enroll> enrolls;
            List<Faculty> faculties;
            List<Student> students;

            using (var reader = new StreamReader("W:\\source\\repos\\cs564\\testFiles\\Class.csv"))
            using (var csv = new CsvReader(reader, config))
            {
                classes = csv.GetRecords<Class>().ToList();
            }            
            using (var reader = new StreamReader("W:\\source\\repos\\cs564\\testFiles\\Enroll.csv"))
            using (var csv = new CsvReader(reader, config))
            {
                enrolls = csv.GetRecords<Enroll>().ToList();
            }            
            using (var reader = new StreamReader("W:\\source\\repos\\cs564\\testFiles\\Faculty.csv"))
            using (var csv = new CsvReader(reader, config))
            {
                faculties = csv.GetRecords<Faculty>().ToList();
            }            
            using (var reader = new StreamReader("W:\\source\\repos\\cs564\\testFiles\\Student.csv"))
            using (var csv = new CsvReader(reader, config))
            {
                students = csv.GetRecords<Student>().ToList();
            }

            var contextOptions = new DbContextOptionsBuilder<Lab1Context>()
.UseSqlite(connString)
.Options;

            using (var context = new Lab1Context(contextOptions))
            {
                context.Database.EnsureCreated();

                using (var transaction = context.Database.BeginTransaction())
                {
                    context.BulkInsertOrUpdate(classes);
                    transaction.Commit();
                }
                using (var transaction = context.Database.BeginTransaction())
                {
                    context.BulkInsertOrUpdate(enrolls);
                    transaction.Commit();
                }
                using (var transaction = context.Database.BeginTransaction())
                {
                    context.BulkInsertOrUpdate(faculties);
                    transaction.Commit();
                }
                using (var transaction = context.Database.BeginTransaction())
                {
                    context.BulkInsertOrUpdate(students);
                    transaction.Commit();
                }
            }
        }
    }
}
