@{
    PSDependOptions = @{
        Target = '$ENV:USERPROFILE\.powershell\Modules'
        AddToPath = $True
    }

    'PSScriptAnalyzer' = 'latest'
    'Microsoft.PowerShell.SecretManagement' = 'latest'
    'Microsoft.PowerShell.SecretStore' = 'latest'
    'Plaster' = 'latest'
    'Terminal-Icons' = 'latest'
    'z' = 'latest'
    'VSTeam' = 'latest'
}