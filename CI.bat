@echo off

powershell -Command "if (!(Get-Module psake -ListAvailable)) { if (!(Get-Module PsGet -ListAvailable)) { (New-Object Net.WebClient).DownloadString('http://psget.net/GetPsGet.ps1') | iex }; Install-Module psake }"

echo RMW CI Tool - Version 1.0.0.1
echo A Continuous Integration (CI) tool to help WCP developers compile, deploy, and run Unit and Integration Tests.
echo Copyright (c) 2017 Boot Baron, LLC - All Rights Reserved.

if "%1" == "" (
	"%UserProfile%"\Documents\WindowsPowerShell\Modules\psake\psake.cmd .\deployment\default.ps1 -framework 4.5.1 -docs -nologo
	"%UserProfile%"\Documents\WindowsPowerShell\Modules\psake\psake.cmd .\deployment\default.ps1 -framework 4.5.1  -nologo
) else (
	"%UserProfile%"\Documents\WindowsPowerShell\Modules\psake\psake.cmd .\deployment\default.ps1 -framework 4.5.1 %* -nologo
)