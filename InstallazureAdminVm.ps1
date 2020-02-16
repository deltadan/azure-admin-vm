#Enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Assign Chocolatey Packages to Install
$Packages = `
    'adobereader', `
    'winrar', `
    'git', `
    'putty.install', `
    'sysinternals', `
    'python3', `
    'microsoft-edge', `
    'visualstudiocode', `
    'microsoftazurestorageexplorer'

#Install Chocolatey Packages
ForEach ($PackageName in $Packages)
{ choco install $PackageName -y }

#Install Azure PowerShell
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Install-Module -Name Az -AllowClobber -Scope AllUsers -Force

#Install Azure CLI for Windows
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

#Run Updates on Ubuntu
RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash


#Reboot
Restart-Computer -Force
