# Function to test is the current user is an admin
function Test-Administrator  {  
    $User = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $User).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

# To avoid user modules being synced to OneDrive a directory is created in the user profile and appended to the module paths
switch ($PSVersionTable.PSEdition) {
    "Desktop" { $ModuleLocation = "$env:USERPROFILE\.powershell\Modules" }
    Default { $ModuleLocation = "$env:USERPROFILE\.pwsh\Modules" }
}
if(-not(Test-Path $ModuleLocation)) {
    Write-Host "Creating $ModuleLocation"
    New-Item $ModuleLocation -ItemType Directory | Out-Null
}
if(-not($env:PSModulePath -like "*$ModuleLocation*")) {
    Write-Host "Adding $ModuleLocation to PSModulePath"
    $env:PSModulePath+=";$ModuleLocation"
}

Push-Location

# First we save PSDepend as that will be used to bootstrap the remaining required modules
if (-not(Get-Module PSDepend)) {
    Write-Host "Saving PSDepend"
    Save-Module -Name PSDepend -Path $ModuleLocation
}
# Next we upgrade PSReadLine is the AllUsers version is less than 2.2.6
if ((Get-Module PSReadLine).Version -lt [version]'2.2.6') {
    If (Test-Administrator) {
        Write-Host "Upgrading PSReadLine"
        Install-Module PSReadLine -Force -AllowClobber
    }
    else {
        Write-Warning "PSReadLine needs upgrading so re-run this script as admin"
        Exit
    }
}
# Finally we use PSDepend to install our required modiles
Write-Host "Calling PSDepend to install required modules"
switch ($PSVersionTable.PSEdition) {
    "Desktop" { Invoke-PSDepend -Path "$PSScriptRoot\module-requirements-desktop.psd1" -Force }
    Default { Invoke-PSDepend -Path "$PSScriptRoot\module-requirements-core.psd1" -Force }
}

Pop-Location