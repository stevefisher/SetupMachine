# SetupMachine

Used as a quick way to get a new machine up and running with required packages and PowerShell modules.

The are 2 scripts to handle the packages and modules seperately to give some flexibility in case one or the other isn't required.

## Install-Modules.ps1

As the name implies this script is used to install PowerShell modules. The heavy lifting is done by PSDepend, however the script bootstraps that for you. It also upgrades PSReadLine if the installed version is lower than 2.2.6 as I found PowerShell 5 was getting upset without this step.

As I'm using OneDrive to redirect my documents folder I fall into the trap where modules are synced across devices meaning you can't upgrade them if they were originally installed on another machine first. To get around this I'm creating directory structures in the user profile directory to save the modules and then prepend the path to `$env:PSModulePath`. By doing this each machine can have a different set of user scoped modules.

There are 2 PSDepend requirements files to allow PowerShell 5 and Core to have different modules which can be customised as required:

- `module-requirements-core.ps1` - PowerShell 7
- `module-requirements-desktop.ps1` - PowerShell 5

## Install-Packages.ps1

Installs packages on the machine with Chocolatey doing the package management. The list of packages is defined in `choco-packages.config`.

I'm also using winget to install UpNote from the main script because I couldn't find it in the Chocolatey repository. It would probably make sense to include a config file for winget at some point.
