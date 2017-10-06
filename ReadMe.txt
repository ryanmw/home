Dev Log
-----
Dev Log is a blogging site for developers. It was written in C# and runs on .NET Core.


Deployment
-----
You will need to add a SQL Server and Azure Storage connection string to the appsettings.json file for the web and data projects. Both should have the same values.

The website and database can be deployed using the CI.bat file which needs parameters for the IIS server it should be deployed to. 


How to add a database migration
-----
entity framework commands

Add-Migration -Name NAMEOFMIGRATION -Project DevLog.Data -StartUpProject DevLog.Data 

Update-Database -Project DevLog.Data -StartUpProject DevLog.Data -Verbose