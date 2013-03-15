using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;

namespace RMW.ConsoleMigrator
{
    class Program
    {
        static string argmument = @"RMW.dll /connectionString=""{0}"" /connectionProviderName=""System.Data.SqlClient"" /verbose";
        static string dbCon = @"Data Source=W_LAPTOP-PC;Initial Catalog=RMW.Models.RMWContext;Integrated Security=True"; //"Data Source=sql2k1201.discountasp.net;Initial Catalog=SQL2012_869791_storeklub;User ID=SQL2012_869791_storeklub_user;Password=11f7143b46;";

        public static void Main(params string[] args)
        {
            var exitCode = RunMigrateExe(dbCon);
            Environment.Exit(exitCode);
        }

        private static int RunMigrateExe(string dbCon)
        {
            var startInfo = new ProcessStartInfo(@"Migrate.exe")
            {
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                RedirectStandardInput = true,
                UseShellExecute = false,
                Arguments = string.Format(argmument, dbCon)
            };

            int exitCode = -1;

            try
            {
                var p = Process.Start(startInfo);
                Console.Write(p.StandardOutput.ReadToEnd());
                p.WaitForExit();
                
                exitCode = p.ExitCode;
            }
            catch (Exception ex)
            {
                Console.Write(ex.ToString());
            }
 
            return exitCode;
        }
    }
}


