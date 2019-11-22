#Enable Containers
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

#Download Windows Subsystem for Linux - set the URL for the distro
#Once VM restarts run bash.exe from the command
$wslDownload = "https://aka.ms/wsl-ubuntu-1804"
Invoke-WebRequest -Uri $wslDownload -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Assign Chocolatey Packages to Install
$Packages = 'adobereader',`
            'notepadplusplus.install',`
            'winrar',`
            'git',`
            'putty.install',`
            'sysinternals',`
            'python3',`
            'googlechrome',`
            'docker-for-windows',`
            'visualstudiocode',`
            'git'

#Install Chocolatey Packages
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

#Assign Visual Studio Code Extensions to Install
$Extentions = 'ms-azuretools.vscode-azureterraform',`
              'ms-azuretools.vscode-docker',`
              'ms-vscode.azure-account',`
              'ms-vsts.team',`
              'msazurermtools.azurerm-vscode-tools',`
              'ms-vscode.azurecli',`
              'ms-azure-devops.azure-pipelines',`
              'ms-vscode.csharp',`
              'ms-vscode-remote.remote-wsl',`
              'ms-kubernetes-tools.vscode-kubernetes-tools'

#Install Visual Studio Code Extensions
ForEach ($ExtentionName in $Extentions)
{& 'C:\Program Files\Microsoft VS Code\bin\code.cmd' --install-extension $ExtentionName}

#Add Demo User to docker group
#Add-LocalGroupMember -Member dan -Group docker-users
