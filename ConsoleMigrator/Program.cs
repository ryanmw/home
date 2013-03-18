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
        static string dbCon = "";

        public static void Main(params string[] args)
        {
            var exitCode = RunMigrateExe(dbCon);
            Environment.Exit(exitCode);
        }

        private static int RunMigrateExe(string dbCon)
        {
            if (string.IsNullOrWhiteSpace(dbCon))
            {
                Console.Write("set the db con and recompile");
                return 1;
            }
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


