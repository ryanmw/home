﻿Write-Host "Deploying Application..."

Import-Module .\tools\powershell\psake

Invoke-psake .\default.ps1 deploy