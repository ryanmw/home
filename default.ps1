task -name Build -description "Build the solution" -action { 


    Write-Host "-----Running build-----" -ForegroundColor Blue -BackgroundColor White

    exec  {

        msbuild D:\repos\ryanmichaelwilliams\home\RMW.sln /t:build
    }

};


task -name default  -depends build