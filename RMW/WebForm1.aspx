<%&#64; Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="RMW.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <p style="margin-bottom: 0in">
            Pulling Myself Up By My Bootstraps</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            The goal here is to walk through all the steps required to make a website for myself with continuous integration and deployment. This article is focused on getting set up with version control, continuous integration, testing, packaging and deployment of an application to host this very article I&#39;m composing in Open Office Writer right now.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 1: Distributed Version Control Locally and Remotely</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            First of all I created an account on bitbucket.org to store remote files. Afterward I created a new repository on there to hold the code for the site called: rmw. I selected Mercurial for the repository type and C# for the language. From there I selected that I am starting from scratch. After this a URL is given which is used to clone a repository. The URL is actually wrong in my case, don&#39;t use the username&#64; part, just use bitbucket.org as the host.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Required for the next step is Mercurial downloaded and installed (<a href="http://mercurial.selenic.com/">http://mercurial.selenic.com/</a>) which is free and integrates into the Windows Shell. Although some people decide to use the GUI, TortoiseHG Workbench, for this, I decided to use Windows PowerShell, which comes with Windows 7. For aesthetic perception I made sure to edit the properties and layout colors and save those.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 2: Powering up PowerShell</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Windows PowerShell is a command line program that comes with Windows 7 and is integrated into .NET that I&#39;ll use to issue commands against executable files. I&#39;m going to first clone the repository.<br />
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS C<a href="file:///D:/">:\</a>Users\ME&gt; cd D:\</p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\</a>&gt; hg clone <a href="https://bitbucket.org/MYACCOUNT/MYREPOSITORY">https://bitbucket.org/MYACCOUNT/MYREPOSITORY</a></p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            After running this a folder is created with my repository name in the root directory.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; ls<br />
            <br />
            From here I see the .hg folder indicating the clone was initialized. I can also tell it&#39;s working if I see the green check mark in Windows Explorer indicating it&#39;s a repository that&#39;s ready. From here it&#39;s important to add a text file called .hgignore which contains paths to files that should not go into source control for reasons perhaps that they are temp files in the project. Here is an example of the contents in such a file:
            <br />
            <br />
            syntax: glob</p>
        <p style="margin-bottom: 0in">
            *.cache</p>
        <p style="margin-bottom: 0in">
            *.user</p>
        <p style="margin-bottom: 0in">
            *.suo</p>
        <p style="margin-bottom: 0in">
            *.orig</p>
        <p style="margin-bottom: 0in">
            ./src/*/bin</p>
        <p style="margin-bottom: 0in">
            ./src/*/obj</p>
        <p style="margin-bottom: 0in">
            ./src/buildartifacts/*<br />
            <br />
        </p>
        <p style="margin-bottom: 0in">
            After the file with these contents is added, put it in the repository directory root. This file must be added before any other files in the repository so that they can be excluded. It&#39;s possible to add more exclusions later however, it&#39;s best to do them before the files go in.<br />
            <br />
            Now when running the command to check the status of the files in the directory:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg st<br />
            <br />
            There is a ? next to the file .hgignore. This indicates that Mercurial needs to know what to do with this file. In this case, I want to add and remove all files that it has identified, I could just use hg add but this is easier for both cases:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg addremove
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            From here the ignore file has been added to Mercurial but it hasn&#39;t yet been committed as part of a changeset. A changeset is a set of files that have been added that I identify with a unique message that generates a unique key and id. That unique message summarizes what I did in that changeset, like added a new feature or removed a bug. To actually commit the added file, which I could do many times for different files, this command is required with quoted message:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg com -m “added ignore file”</p>
        <p style="margin-bottom: 0in">
            <br />
            This committed a changeset to my local computer which included all the files, in this case just the ignore file. From here I could add more files, which I will. I am going to create a new Visual Studio 2012 project for my new website and target a folder I&#39;ll make for convention called: src. So I fire up good old VS and file new an ASP.NET MVC 4 Web Application named RMW and click OK and OK again, this makes an RMW.sln file. At this point, I will check my status again and add a new changeset with these files and finally push them to the remote repository.
            <br />
            <br />
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg st</p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg addremove
            <br />
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg com -m “created solution”<br />
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; hg push<br />
            <br />
            I have to authenticate my account with Bit Bucket upon submission and unfortunately since I&#39;m using https and not SSH, which apparently isn&#39;t an option I can use, I have to put in my username and password for each push. Finally after that goes through 2 changesets are added to the remote repository.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 3: Continuous Integration Installation
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            From here I really think to myself that I want to set up some type of continuous integration and deployment and not just have my files more or less just backed up remotely in a distributed version control system. Why? Because I want to push the code and then fire off tests, transformation and release it to a test environment without another click or keystroke, or at least as few as possible afterward considering branches. Automation has become a requirement to save time when doing many releases. To deal with that I turn to TeamCity (<a href="http://www.jetbrains.com/teamcity/">http://www.jetbrains.com/teamcity/</a>) which is free to run with up to 3 build agents. I am just going to be installing this locally since I don&#39;t have the luxury of having my own dedicated server.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            After downloading a large executable, I installed it with all the default settings up until it asks for the port. If I leave it at the default port 80 on localhost it complains and is best to just uninstall everything and start over. I decide to use port 1700 because that&#39;s free on my machine. From there I save the Build Agent settings, run TeamCity under the SYSTEM account settings for the dialogs and then my web browser opens up a version of TeamCity which begins initializing.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            After it&#39;s installed I go the administrator area and create a project named RMW_CI then create a build configuration called RMW_Trunk and keep the defaults. Then I click Create and attached a new VCS root, select Mercurial as the Type of VCS. For HG Command Path I use: hg and for the Pull Changes From section I put: <a href="https://bitbucket.org/MYACCOUNT/MYREPOSITORY">https://bitbucket.org/MYACCOUNT/MYREPOSITORY</a>. I need to provide username and password in this case and then afterward I test the connection and it&#39;s: Connection successful! And I save it.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            The next step is to click Add Build Step, for Runner type: MSBuild, Build file path: D:\rmw\src\RMW.sln in my case since that&#39;s the solution file is. The MSBuild Version is: Microsoft Framework .NET 4.5, the MSBuild ToolsVersion is: 4.0, the Run platform: x64 and I save. From here I click Build Triggering from the menu on the right and Add new trigger. I add a new VCS Trigger and save that. From here I click the top menu and go to My Settings &amp; Tools and then Notification Rules and click Add new rule from the Windows Tray Notifier section. I select my project then check all the top level boxes and save.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            I now and going to make a trivial change to one of the files in the project and add it as well as commit it and then finally push it to the remote server. Within approximately 60 seconds after the push completes, watching the projects tab in TeamCity shows pending changes and then it builds. The remote repository server and my local TeamCity have communicated and the success message indicates that the build compiled.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 4: Building With Scripts</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now it&#39;s time to set up a way to have TeamCity build the project in a dedicated directory in release mode instead of debug mode and to have it also fire up a web server locally to see it. To do this I add an xml build file called: RMW.build in the same directory as the solution file. I put in different Target tags with Names that I can call from the command line. One thing that I noticed was that running a Release mode configuration command doesn&#39;t apply the same transformations that the Publish Web Deploy does. I want my Web.config file to have certain tags such as the CustomErrors and Compilation transformed from Web.Release.config. so I have to include a way to specify this with a custom TransformXml in my Compile step.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            I also am adding a DLL from Elution called: AsyncExec.dll (<a href="http://blog.eleutian.com/2007/03/01/AsyncExecMsBuildTask.aspx">http://blog.eleutian.com/2007/03/01/AsyncExecMsBuildTask.aspx</a>) which will exit the code that starts the web server up after it is started and place that DLL at the path: \thirdparty\tools\MSBuildAsyncExec which is relative to the solution file. This way the command line returns control back to me after I start up the website.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            This is the full build XML file:</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;StartWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now I&#39;m able top run a few different commands with PowerShell, including starting the web server and just compiling it.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            This will compile the website and then launch a web sever:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS C:\Windows\Microsoft.NET\Framework64\v4.0.30319&gt; .\msbuild D:\rmw\src\rmw.build /target:StartWebsite</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            This command will compile the website without launching the web server:</p>
        <p style="margin-bottom: 0in">
            ­</p>
        <p style="margin-bottom: 0in">
            PS C:\Windows\Microsoft.NET\Framework64\v4.0.30319&gt; .\msbuild D:\rmw\src\rmw.build /target:Compile /property:Configuration=Release</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            At this point I will select the build file in TeamCity instead of the .sln file for the Build file path. Now when I push the changesets from here forward, TeamCity will detect the changes and run my build script. After pushing the files and a minute of waiting, I see the build kicks off and creates my website compiled for release mode in the buildartifacts folder. Now when I access: <a href="http://localhost:9999/">http://localhost:9999/</a> I see my website running live.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 5: Testing Automation</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Right now I&#39;m tired of going to the exe for MSBuild so I am making a shortcut.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS C:\Users\ME&gt; new-item alias:msb -value C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now forward I can just type msb to run commands against MsBuild.exe. It will forget my alias after I close PoweShell but that&#39;s okay for now. To save the alias I&#39;d need to export it and then import it later.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            It&#39;s time to install tests in the application. The default project set up came with a test class library and I installed the NuGet Package for NUnit. After this I want to download the console version so that I can invoke it from the commandline, I downloaded it from their site (<a href="http://www.nunit.org/">http://www.nunit.org/</a>) and copied the project into the thirdparty folder I have. I can now run a command against MSBuild to run my test project after updating my build file.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Build with first test:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;Test;StartWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;NUnit Include=&quot;.\thirdparty\tools\NUnit-2.6.1\bin\nunit-console.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestAssembly Include=&quot;.\buildartifacts\RMW.Tests.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestResults Include=&quot;.\buildartifacts\TestResults.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Test&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(NUnit) &#64;(TestAssembly) /xml=&#64;(TestResults)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            From here I will add a test method in the test project to prove it&#39;s working (namespaces omitted):
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            [TestFixture]</p>
        <p style="margin-bottom: 0in">
            public class HomeControllerTest</p>
        <p style="margin-bottom: 0in">
            {</p>
        <p style="margin-bottom: 0in">
            [Test]</p>
        <p style="margin-bottom: 0in">
            public void Index()</p>
        <p style="margin-bottom: 0in">
            {</p>
        <p style="margin-bottom: 0in">
            // Arrange</p>
        <p style="margin-bottom: 0in">
            HomeController controller = new HomeController();</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            // Act</p>
        <p style="margin-bottom: 0in">
            ViewResult result = controller.Index() as ViewResult;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            // Assert</p>
        <p style="margin-bottom: 0in">
            Assert.IsNotNull(result);</p>
        <p style="margin-bottom: 0in">
            }</p>
        <p style="margin-bottom: 0in">
            }</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            I can now run a command in PowerShell to run the test.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS D:\rmw\src&gt; msb D:\rmw\src\rmw.build /target:Test</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            The command prompt returns to me after the test build runs and shows me the test passed. I will now commit this to the remote repository which will begin my TeamCity build runner. While it does build, it does not run the test. The reason for this is that I need to set up a New Build Step for NUnit. To do that I set the Platform to x64, the Version to v4.0, set the Run test from to: D:\rmw\src\buildartifacts\*Tests.dll and save.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now when I trigger the build again it runs my tests. I&#39;d like to now install FxCop to see some static code analysis. To install it requires downloading a large SDK that secretly contains the exe in a cab file, I had trouble installing the SDK but luckily I found this work around (<a href="http://codeblog.vurdalakov.net/2012/05/how-to-download-fxcop-100.html">http://codeblog.vurdalakov.net/2012/05/how-to-download-fxcop-100.html</a>). Unfortunately, even after installing FxCop and copying it to my thirdparty folder to invoke it, I ran into exceptions running it from PowerShell. I tried to load the RMW.dll assembly from the GUI of FxCop hoping for some hints. It asked for System.Net.Http.dll version 2.0 which I found at C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\System.Net.Http.dll and then I updated my build script after I saw that made the GUI run.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;Test;FxCop;StartWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;.artifacts\Debug\FxCopTask.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;FxCop&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;NUnit Include=&quot;.\thirdparty\tools\NUnit-2.6.1\bin\nunit-console.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestAssembly Include=&quot;.\buildartifacts\RMW.Tests.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestResults Include=&quot;.\buildartifacts\TestResults.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCop Include=&quot;.\thirdparty\tools\FxCop\FxCopCmd.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AssembliesToAnalyze Include=&quot;.\buildartifacts\RMW.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;ReferencedAssemblies Include=&#39;&quot;C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\System.Net.Http.dll&quot;&#39; /&gt;
        </p>
        <p style="margin-bottom: 0in">
            &lt;AnalysisReport Include=&quot;.\buildartifacts\FxCopAnalysis.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Test&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(NUnit) &#64;(TestAssembly) /xml=&#64;(TestResults)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;FxCop&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(FxCop) /file:&#64;(AssembliesToAnalyze) /reference:&#64;(ReferencedAssemblies) /out:&#64;(AnalysisReport)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now when I push my code, it will run my code tests and FxCop automatically. It&#39;s possible to fail the build with thresholds for warnings or errors and I&#39;d like to do that so that a build is significant. I downloaded MS Build Community Tasks (<a href="https://github.com/loresoft/msbuildtasks/downloads">https://github.com/loresoft/msbuildtasks/downloads</a>) so that I could parse the XML from FxCop and do just this. It requires me to put in some DLLs and XML files in the thirdparty directory and update my build script.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;Test;FxCop;StartWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;.artifacts\Debug\FxCopTask.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;FxCop&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildCommunityTasks\MSBuild.Community.Tasks.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;MSBuild.Community.Tasks.XmlRead&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;NUnit Include=&quot;.\thirdparty\tools\NUnit-2.6.1\bin\nunit-console.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestAssembly Include=&quot;.\buildartifacts\RMW.Tests.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestResults Include=&quot;.\buildartifacts\TestResults.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCop Include=&quot;.\thirdparty\tools\FxCop\FxCopCmd.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AssembliesToAnalyze Include=&quot;.\buildartifacts\RMW.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;ReferencedAssemblies Include=&#39;&quot;C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\System.Net.Http.dll&quot;&#39; /&gt;
        </p>
        <p style="margin-bottom: 0in">
            &lt;AnalysisReport Include=&quot;.\buildartifacts\FxCopAnalysis.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Test&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(NUnit) &#64;(TestAssembly) /xml=&#64;(TestResults)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;FxCop&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(FxCop) /file:&#64;(AssembliesToAnalyze) /reference:&#64;(ReferencedAssemblies) /out:&#64;(AnalysisReport)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalErrors&gt;0&lt;/FxCopCriticalErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopErrors&gt;0&lt;/FxCopErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalWarnings&gt;0&lt;/FxCopCriticalWarnings&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            XPath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalError&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalErrors&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;Error&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopErrors&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalWarning&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalWarnings&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Error Text=&quot;FxCop encountered $(Count) material rule violations&quot;</p>
        <p style="margin-bottom: 0in">
            Condition=&quot;$(FxCopCriticalErrors) &amp;gt; 0 or $(FxCopErrors) &amp;gt; 0 or $(FxCopCriticalWarnings) &amp;gt; 0&quot; /&gt;
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now when I run:
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; msb D:\rmw\src\rmw.build /target:FxCop</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            My build fails because of a material rule violation, I can see the results of this in the file at: .\buildartifacts\FxCopAnalysis.xml and can put in a full path to this file as a build artifact so that when the project compiles with errors I can easily click to see the XML file. From here I will need to either adjust the minimum threshold, ignore rules or remove all the warnings and errors. There is a file called: CustomDictionary.xml in the FxCop folder that allows me to customize naming conventions so I will. As for the other errors, I am going to explicitly ignore them for now given this is a project with almost no code in it. I can ignore rules with the /rule: and a “-” as a format for each rule to ignore.
            <br />
            <br />
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;Test;FxCop;StartWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;.artifacts\Debug\FxCopTask.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;FxCop&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildCommunityTasks\MSBuild.Community.Tasks.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;MSBuild.Community.Tasks.XmlRead&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MsDeploy Include=&#39;&quot;.\thirdparty\tools\Microsoft Web Deploy\msdeploy.exe&quot;&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PackageFile Include=&quot;.\buildartifacts\package\RMW.zip&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;NUnit Include=&quot;.\thirdparty\tools\NUnit-2.6.1\bin\nunit-console.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestAssembly Include=&quot;.\buildartifacts\RMW.Tests.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestResults Include=&quot;.\buildartifacts\TestResults.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCop Include=&quot;.\thirdparty\tools\FxCop\FxCopCmd.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AssembliesToAnalyze Include=&quot;.\buildartifacts\RMW.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;ReferencedAssemblies Include=&#39;&quot;C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\System.Net.Http.dll&quot;&#39; /&gt;
        </p>
        <p style="margin-bottom: 0in">
            &lt;AnalysisReport Include=&quot;.\buildartifacts\FxCopAnalysis.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RulesToIgnore Include=&quot;/ruleid:-Microsoft.Performance#CA1812 /ruleid:-Microsoft.Design#CA1034 /ruleid:-Microsoft.Design#CA1812 /ruleid:-Microsoft.Design#CA1031 /ruleid:-Microsoft.Design#CA1020 /ruleid:-Microsoft.Design#CA2210 /ruleid:-Microsoft.Design#CA1014 /ruleid:-Microsoft.Design#CA1053 /ruleid:-Microsoft.Design#CA1822 /ruleid:-Microsoft.Design#CA1054 /ruleid:-Microsoft.Naming#CA1726 /ruleid:-Microsoft.Performance#CA1822&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Test&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(NUnit) &#64;(TestAssembly) /xml=&#64;(TestResults)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;FxCop&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(FxCop) /file:&#64;(AssembliesToAnalyze) /reference:&#64;(ReferencedAssemblies) /out:&#64;(AnalysisReport) &#64;(RulesToIgnore)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalErrors&gt;0&lt;/FxCopCriticalErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopErrors&gt;0&lt;/FxCopErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalWarnings&gt;0&lt;/FxCopCriticalWarnings&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            XPath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalError&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalErrors&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;Error&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopErrors&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalWarning&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalWarnings&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Error Text=&quot;FxCop encountered $(Count) material rule violations&quot;</p>
        <p style="margin-bottom: 0in">
            Condition=&quot;$(FxCopCriticalErrors) &amp;gt; 0 or $(FxCopErrors) &amp;gt; 0 or $(FxCopCriticalWarnings) &amp;gt; 0&quot; /&gt;
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Package&quot; DependsOnTargets=&quot;Compile;Test;FxCop&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PackageDir&gt;%(PackageFile.RootDir)%(PackageFile.Directory)&lt;/PackageDir&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Source&gt;%(Website.FullPath)&lt;/Source&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Destination&gt;%(PackageFile.FullPath)&lt;/Destination&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;$(PackageDir)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&#39;&#64;(MSDeploy) -verb:Sync -source:iisApp=&quot;$(Source)&quot; -dest:package=&quot;$(Destination)&quot;&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Now when I run:<br />
            <br />
            PS <a href="file:///D:/rmw">D:\rmw</a>&gt; msb D:\rmw\src\rmw.build /target:FxCop<br />
            <br />
            I see that it passed FxCop by ignoring rules that I don&#39;t want to acknowledge right now. I would also like to run code coverage tests from NCover and having some tooling from ReSharper to prevent problems ahead of time too but I&#39;m not looking to spend much money on this right now so I&#39;ll pass for the time being.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Step 6: Automated Deployment</p>
        <p style="margin-bottom: 0in">
            <br />
            Now I have the ability to store my code remotely and do automated build tests on it which will assure me that any rules I want to follow prior to building the website will be run, failing my build when in violation. I can now set up a way to create a package of my built site that I can deploy into a real IIS application. When I push my code, I want the build server to download it, test it and if that works then package it up and deploy it to the live server. If this was a site that already had traffic I would first deploy it to a test or stage environment before deploying it straight production.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            To do what I want I&#39;ll first need to get a hosting account and set it up correctly. I first create an account on Discount ASP.NET (<a href="http://discountasp.net/">http://discountasp.net</a>) and then set up an IIS 8 ASP.NET 4.5 website with SQL Server 2012 (I&#39;ll use this later). I need to point my domain name to their name servers as well. I need to make sure that the permissions for my account allow me to publish otherwise I will see 401 unauthorized errors from the server, the user account needs to be set here: (<a href="https://my.discountasp.net/web-manager/iis8-manager.aspx">https://my.discountasp.net/web-manager/iis8-manager.aspx</a>) to have the ability to use Microsoft IIS Manager and Web Deploy. To deploy to this server I&#39;ll need to use Microsoft Web Deploy V3 instead of the not version 3 one. This requires copying the contents of C:\Program Files\IIS\Microsoft Web Deploy V3 and putting placing them at: D:\rmw\src\thirdparty\tools\Microsoft Web Deploy V3. The newer version 
            is required to publish on IIS 8, using the previous one will just hang there.
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            Up until this point I did not need to elevate the permission level of PowerShell however, to publish remotely it requires Administrator permission on the sending computer so I&#39;ll run PowerShell as an Administrator. If I run the Deploy method in the following build script then it will publish my site and I confirm that it is working. Note: change WEBSERVER, DOMANNAME, CPUSERNAME AND CPPASSWORD for your account if you&#39;re using discountasp.net.</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot; ?&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Project xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot; ToolsVersion=&quot;4.0&quot;</p>
        <p style="margin-bottom: 0in">
            DefaultTargets=&quot;Test;FxCop;Deploy&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildAsyncExec\AsyncExec.dll&quot; TaskName=&quot;AsyncExec.AsyncExec&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask TaskName=&quot;TransformXml&quot;</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;$(MSBuildExtensionsPath)\Microsoft\VisualStudio\v11.0\Web\Microsoft.Web.Publishing.Tasks.dll&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask</p>
        <p style="margin-bottom: 0in">
            AssemblyFile=&quot;.artifacts\Debug\FxCopTask.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;FxCop&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;UsingTask AssemblyFile=&quot;.\thirdparty\tools\MSBuildCommunityTasks\MSBuild.Community.Tasks.dll&quot;</p>
        <p style="margin-bottom: 0in">
            TaskName=&quot;MSBuild.Community.Tasks.XmlRead&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Configuration Condition=&quot; &#39;$(Configuration)&#39; == &#39;&#39; &quot;&gt;Debug&lt;/Configuration&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MsDeploy Include=&#39;&quot;.\thirdparty\tools\Microsoft Web Deploy V3\msdeploy.exe&quot;&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PackageFile Include=&quot;.\buildartifacts\package\RMW.zip&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;WebServerName&gt;&lt;/WebServerName&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;BuildArtifacts Include=&quot;.\buildartifacts\&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionFile Include=&quot;.\RMW.sln&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Cassini Include=&quot;C:\Program Files (x86)\Common Files\microsoft shared\DevServer\11.0\WebDev.WebServer40.EXE&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Website Include=&quot;.\buildartifacts\_PublishedWebsites\RMW&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;SolutionRoot Include=&quot;.\rmw&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;IgnoreConfigs Include=&quot;$(Website)\*&quot; Exclude=&quot;$(Website)\*\Web.Release.Config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;NUnit Include=&quot;.\thirdparty\tools\NUnit-2.6.1\bin\nunit-console.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestAssembly Include=&quot;.\buildartifacts\RMW.Tests.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;TestResults Include=&quot;.\buildartifacts\TestResults.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCop Include=&quot;.\thirdparty\tools\FxCop\FxCopCmd.exe&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AssembliesToAnalyze Include=&quot;.\buildartifacts\RMW.dll&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;ReferencedAssemblies Include=&#39;&quot;C:\Program Files (x86)\Microsoft ASP.NET\ASP.NET MVC 4\Assemblies\System.Net.Http.dll&quot;&#39; /&gt;
        </p>
        <p style="margin-bottom: 0in">
            &lt;AnalysisReport Include=&quot;.\buildartifacts\FxCopAnalysis.xml&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RulesToIgnore Include=&quot;/ruleid:-Microsoft.Performance#CA1812 /ruleid:-Microsoft.Design#CA1034 /ruleid:-Microsoft.Design#CA1812 /ruleid:-Microsoft.Design#CA1031 /ruleid:-Microsoft.Design#CA1020 /ruleid:-Microsoft.Design#CA2210 /ruleid:-Microsoft.Design#CA1014 /ruleid:-Microsoft.Design#CA1053 /ruleid:-Microsoft.Design#CA1822 /ruleid:-Microsoft.Design#CA1054 /ruleid:-Microsoft.Naming#CA1726 /ruleid:-Microsoft.Performance#CA1822&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/ItemGroup&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;RemoveDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Init&quot; DependsOnTargets=&quot;Clean&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;&#64;(BuildArtifacts)&quot;/&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Compile&quot; DependsOnTargets=&quot;Init&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;MSBuild Projects=&quot;&#64;(SolutionFile)&quot; Targets=&quot;Rebuild&quot;</p>
        <p style="margin-bottom: 0in">
            Properties=&quot;OutDir=%(BuildArtifacts.FullPath);Configuration=$(Configuration)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;TransformXml Source=&quot;&#64;(SolutionRoot)\web.config&quot; Transform=&quot;&#64;(SolutionRoot)\web.release.config&quot;</p>
        <p style="margin-bottom: 0in">
            Destination=&quot;&#64;(Website)\web.config&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Deploy&quot; DependsOnTargets=&quot;Package&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Source&gt;%(PackageFile.FullPath)&lt;/Source&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&#39;&#64;(MsDeploy) -verb:sync -source:package=&quot;$(Source)&quot; -dest:iisApp=DOMAINNAME.com,computerName=https://WEBSERVER.discountasp.net:8172/MsDeploy.axd?site=DOMAINNAME.com,username=CPUSERNAME,password=CPPASSWORD,authtype=Basic -allowUntrusted&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Test&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(NUnit) &#64;(TestAssembly) /xml=&#64;(TestResults)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;FxCop&quot; DependsOnTargets=&quot;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;&#64;(FxCop) /file:&#64;(AssembliesToAnalyze) /reference:&#64;(ReferencedAssemblies) /out:&#64;(AnalysisReport) &#64;(RulesToIgnore)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalErrors&gt;0&lt;/FxCopCriticalErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopErrors&gt;0&lt;/FxCopErrors&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;FxCopCriticalWarnings&gt;0&lt;/FxCopCriticalWarnings&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            XPath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalError&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalErrors&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;Error&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopErrors&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;XmlRead ContinueOnError=&quot;True&quot;</p>
        <p style="margin-bottom: 0in">
            XmlFileName=&quot;&#64;(AnalysisReport)&quot;</p>
        <p style="margin-bottom: 0in">
            Xpath=&quot;string(count(//Issue[&#64;Level=&#39;CriticalWarning&#39;]))&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Output TaskParameter=&quot;Value&quot; PropertyName=&quot;FxCopCriticalWarnings&quot; &gt;&lt;/Output&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/XmlRead&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Error Text=&quot;FxCop encountered $(Count) material rule violations&quot;</p>
        <p style="margin-bottom: 0in">
            Condition=&quot;$(FxCopCriticalErrors) &amp;gt; 0 or $(FxCopErrors) &amp;gt; 0 or $(FxCopCriticalWarnings) &amp;gt; 0&quot; /&gt;
        </p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StartWebsite&quot; DependsOnTargets=&quot;StopWebsite;Compile&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;AsyncExec Command=&#39;&quot;&#64;(Cassini)&quot; /port:9999 /path:&quot;%(Website.FullPath)&quot; /vpath:&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;StopWebsite&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&quot;taskkill /f /im WebDev.WebServer40.EXE&quot; IgnoreExitCode=&quot;true&quot;</p>
        <p style="margin-bottom: 0in">
            IgnoreStandardErrorWarningFormat=&quot;true&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;Target Name=&quot;Package&quot; DependsOnTargets=&quot;Compile;Test;FxCop&quot;&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;PackageDir&gt;%(PackageFile.RootDir)%(PackageFile.Directory)&lt;/PackageDir&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Source&gt;%(Website.FullPath)&lt;/Source&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;Destination&gt;%(PackageFile.FullPath)&lt;/Destination&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;/PropertyGroup&gt;</p>
        <p style="margin-bottom: 0in">
            &lt;MakeDir Directories=&quot;$(PackageDir)&quot; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;Exec Command=&#39;&#64;(MSDeploy) -verb:Sync -source:iisApp=&quot;$(Source)&quot; -dest:package=&quot;$(Destination)&quot;&#39; /&gt;</p>
        <p style="margin-bottom: 0in">
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Target&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            &lt;/Project&gt;</p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            <br />
        </p>
        <p style="margin-bottom: 0in">
            So there you have it! Now I can push the code, the build server picks up those changes, runs my tests, make a zip file package of my site and then that gets deployed to the remote server.</p>
    
    </div>
    </form>
</body>
</html>
