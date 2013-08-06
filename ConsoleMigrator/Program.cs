using System;
using System.Diagnostics;

namespace ConsoleMigrator
{
    class Program
    {
        private const string Argmument = @"RMW.dll /connectionString=""{0}"" /connectionProviderName=""System.Data.SqlClient"" /verbose";
        private const string DbCon = "";

        public static void Main(params string[] args)
        {
            var exitCode = RunMigrateExe(DbCon);
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
                Arguments = string.Format(Argmument, dbCon)
            };

            var exitCode = -1;

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


