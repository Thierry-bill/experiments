## Script that gets the list of projects that need to be built.
## This script it used by the VSTS build agents.
## Author: Den Delimarsky (dendeli)
## Last Modified: 12/22/2016

new-module -name NetCoreProjectLister -scriptblock {
    function Perform-Listing {
        param (
          [string]$folder = 'none'
        )

        $homePath = (Get-Item -Path ".\" -Verbose).FullName
        Write-Host "Current home path: " $homePath

        $corePath = $homePath + "\" + $folder
        Write-Host "Current samples path: " $corePath

        [System.Collections.ArrayList]$globalProjects = Get-ChildItem $corePath -Recurse | where {$_.Name -eq "global.json"}
        [System.Collections.ArrayList]$singleProjects = Get-ChildItem $corePath -Recurse | where {$_.Name -eq "project.json" }

        $itemsToRemove = New-Object "System.Collections.Generic.List[System.Object]"

        foreach($item in $singleProjects){
            foreach ($blockedItem in $globalProjects){
                if ($item.Directory.ToString().StartsWith($blockedItem.Directory.ToString() + "\")){
                    $itemsToRemove.Add($item)
                    break
                }
            }
        }

        Write-Host "Single projects before cleanup: " $singleProjects.Count

        foreach($target in $itemsToRemove)
        {
            Write-Host "Removing " $target.Directory " from the list of single projects."
            $singleProjects.Remove($target)
        }

        Write-Host "Single projects after cleanup: " $singleProjects.Count

        ($singleProjects | select-object FullName | ConvertTo-Csv -NoTypeInformation | % { $_ -replace '"', ""} ) | Select-Object -Skip 1 | Set-Content -Path single.projects
        ($globalProjects | select-object FullName | ConvertTo-Csv -NoTypeInformation | % { $_ -replace '"', ""} ) | Select-Object -Skip 1 | Set-Content -Path global.projects
    }

    Set-Alias -Name listprojects -Value Perform-Listing

    Export-ModuleMember -Function * -Alias *
}
