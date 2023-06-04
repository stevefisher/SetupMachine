# Install Chocolatey if it's not already installed
$TestChoco = choco -v
if(-not($TestChoco)){
    Write-Output "Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else{
    Write-Output "Chocolatey Version $($TestChoco.Version) is already installed"
}

# Use Chocolatey to install the packages in the Packages.config file
choco install "$PSScriptRoot\choco-packages.config" -y

# Use winget to install packages not available with Chocolatey
winget install upnote --source msstore