#Enable Containers
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName Containers -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

#Download Windows Subsystem for Linux - set the URL for the distro
#Once VM restarts run bash.exe from the command
$wslDownload = "https://aka.ms/wsl-ubuntu-1804"
Invoke-WebRequest -Uri $wslDownload -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Assign Chocolatey Packages to Install
$Packages = 'adobereader', `
    'notepadplusplus.install', `
    'winrar', `
    'git', `
    'putty.install', `
    'sysinternals', `
    'python3', `
    'googlechrome', `
    #  'docker-for-windows',`
    'visualstudiocode', `
    'microsoftazurestorageexplorer', `
    'azure-data-studio'

#Install Chocolatey Packages
ForEach ($PackageName in $Packages)
{ choco install $PackageName -y }

#Assign Visual Studio Code Extensions to Install
$Extentions = 'ms-azuretools.vscode-azureterraform', `
    'ms-azuretools.vscode-docker', `
    'ms-vscode.azure-account', `
    'ms-vsts.team', `
    'msazurermtools.azurerm-vscode-tools', `
    'ms-vscode.azurecli', `
    'ms-azure-devops.azure-pipelines', `
    'ms-vscode.csharp', `
    'ms-vscode-remote.remote-wsl', `
    'ms-kubernetes-tools.vscode-kubernetes-tools', `
    'ms-vscode.powershell'

#Install Visual Studio Code Extensions
ForEach ($ExtentionName in $Extentions)
{ & 'C:\Program Files\Microsoft VS Code\bin\code.cmd' --install-extension $ExtentionName }

#Install Azure PowerShell
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name Az -AllowClobber -Scope AllUsers -Force

#Install Azure CLI for Windows
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

#Reboot
Restart-Computer -Force
