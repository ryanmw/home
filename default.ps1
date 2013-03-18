
if ( Test-Path ./configs.ps1 )
{
. ./configs.ps1

}

properties {
 
    #msbuild
    if ( $msBuildConfig -eq $null)
    {
        $msBuildConfig = 'debug'
    }
    if ( $msBuildVerbosity -eq $null)
    {
        $msBuildVerbosity = 'normal'
    }
    if ( $solutionLocation -eq $null)
    {
        $solutionLocation = ''
    }
     
    #DB migrations
    if ( $migrateConnectionString -eq $null)
    {
        $migrateConnectionString = ''
    }
    if ( $migrateDBParams -eq $null)
    {
        $migrateDBParams = '/verbose'
    }
    if ( $migrateApplicationDLL -eq $null)
    {
        $migrateApplicationDLL = ''
    }
    if ( $migrateExeLocation -eq $null)
    {
        $migrateExeLocation = ''
    }
    if ( $removeMigrateLoation -eq $null)
    {
        $removeMigrateLoation = ''
    }
    if ( $dbUpdate -eq $null)
    {
        $dbUpdate = ''
    }
    if ( $webprojectBinLocation -eq $null)
    {
        $webprojectBinLocation = ''
    }
  
    #Package
    if ( $packageName -eq $null)
    {
        $packageName = ''
    }
    if ( $packageOutputDir -eq $null)
    {
        $packageOutputDir =  '.\buildartifacts\'
    }
     
    #Deployment
    if ( $msDeployURL -eq $null)
    {
        $msDeployURL = ''
    }
    if ( $msDeployUserName -eq $null)
    {
        $msDeployUserName = ''
    }
    if ( $msDeployPassword -eq $null)
    {
        $msDeployPassword = ''
    }
    if ( $webProjectLocation -eq $null)
    {
        $webProjectLocation = ''
    }

    #unit tests
    if ( $MSTestLocation -eq $null)
    {
        $MSTestLocation = ''
    }
    if ( $testDLLLocation -eq $null)
    {
        $testDLLLocation = ''
    }   
}

task -name ValidateConfigs -description "Validates all of the config settings" -depends ValidateMSBuildmsBuildVerbosity, ValidateMSBuildConfig, ValidateConfigsHaveValues

task -name ValidateMSBuildConfig  -description "Validates msBuildVerbosity" -action {
    assert( 'debug', 'release' -contains $msBuildConfig) `
    "Invalid msBuildConfig: $msBuildConfig, must be: 'debug' or 'release'"
};

task -name ValidateConfigsHaveValues  -description "Validates that configs which require a value, have a value" -action {
    
    #ValidateConfigsHaveValues
};

task -name ValidateMSBuildmsBuildVerbosity  -description "Validates MS build config" -action {
    assert( 'q', 'quiet', 'm', 'minimal', 'n', 'normal', 'd', 'detailed', 'diag', 'diagnostic' -contains $msBuildVerbosity) `
    "Invalid msBuildVerbosity: $msBuildVerbosity, must be:  'q', 'quiet', 'm', 'minimal', 'n', 'normal', 'd', 'detailed', 'diag' or 'diagnostic'"
};

task -name ListConfigs -description "Lists configs" -depends ValidateConfigs -action {
 
     Write-Host "config:  $msBuildConfig " -ForegroundColor Magenta
     Write-Host "msBuildVerbosity:  $msBuildVerbosity " -ForegroundColor Magenta
     Write-Host "migrateConnectionString:  $migrateConnectionString " -ForegroundColor Magenta
     Write-Host "migrateDBParams:  $migrateDBParams " -ForegroundColor Magenta
     Write-Host "migrateApplicationDLL:  $migrateApplicationDLL " -ForegroundColor Magenta
     Write-Host "packageName:  $packageName " -ForegroundColor Magenta
     Write-Host "msWebDeployDestination:  $msWebDeployDestination " -ForegroundColor Magenta
}

task -name Build -description "Build the solution" -depends ListConfigs -action { 
    exec  {
        msbuild $solutionLocation /t:build /verbosity:$msBuildVerbosity /p:configuration=$msBuildConfig
    }
};

task -name Clean -description "Cleans the solution" -depends ValidateMSBuildmsBuildVerbosity -action { 
    exec  {
        msbuild $solutionLocation /t:clean /verbosity:$msBuildVerbosity /p:configuration=$msBuildConfig
    }
};

task -name Rebuild -depends Clean, Build -description "Cleans and builds the solution"  

task -name UnitTest -depends Rebuild -description "Runs unit tests" -action { 
    exec  {
      & $MSTestLocation  /testcontainer:$testDLLLocation
    }
};


task -name PackageZip -depends UnitTest -description "Deploys package to environment" -action { 
    exec  {
     msbuild $webProjectLocation /t:Package /verbosity:$msBuildVerbosity /p:Configuration=$msBuildConfig /p:OutDir=$packageOutputDir
  }
};

task -name MigrateDB -depends UnitTest -description "Runs migration of database" -action { 
    exec  {
        Copy-Item  $migrateExeLocation $webProjectBinLocation

        & $removeMigrateLoation $migrateApplicationDLL /connectionString="$migrateConnectionString" /connectionProviderName="System.Data.SqlClient" $migrateDBParams
      
        Remove-Item $removeMigrateLoation
    }
};


task -name Deploy -depends PackageZip, MigrateDB -description "Deploys package to environment" -action { 
    exec  {
  
        msbuild $webprojectLocation `
           /p:Configuration=$msBuildConfig `
           /P:DeployOnBuild=True `
           /P:DeployTarget=MSDeployPublish `
           /P:MsDeployServiceUrl=$msDeployURL `
           /P:AllowUntrustedCertificate=True `
           /P:MSDeployPublishMethod=WMSvc `
           /P:CreatePackageOnPublish=True `
           /P:UserName=$msDeployUserName `
           /P:Password=$msDeployPassword `
           /verbosity:$msBuildVerbosity 
    }
};

task -name default  -depends ListConfigs 