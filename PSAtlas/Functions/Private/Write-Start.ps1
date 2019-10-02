
Function Write-Start {

    param (
        $Guide
    )

    $ModulePath = Split-path (Get-Module -name PSAtlas).Path
    $StringPath = Join-Path -Path $ModulePath -ChildPath "Style"
    $GuideFolderPath = Join-Path -Path $ModulePath -ChildPath "Guides"
    Clear-Host
    $GuidePath = Join-Path -Path $GuideFolderPath -ChildPath $Guide
    $GuideJSON = Join-Path -Path $GuidePath -ChildPath "Guide.json"

    $GuideObj = [Guide]::new($GuideJSON)

    if($GuideObj.Artifacts){
        foreach($Artifact in $GuideObj.Artifacts){
            try{   
                Write-String (Join-Path -Path $StringPath -ChildPath "Prerequisites.txt" ) -type "Info"
                $ArtifactPath = join-path -Path $GuidePath -ChildPath "Artifacts"
                foreach($Folder in $ArtifactPath){
                    $ModuleFile = Join-Path $ArtifactPath -ChildPath "$($Artifact)\$($Artifact).psd1"
                    Import-Module $ModuleFile -Force -Verbose
                } 
            }catch{
                Write-String (Join-Path -Path $StringPath -ChildPath "PrereqFailed.txt" ) -type "Info"
            break
            }
        }
    }

    if($GuideObj.Prerequisites){
        Clear-Host
        foreach($Prereq in $GuideObj.Prerequisites){
            try{
                Write-String (Join-Path -Path $StringPath -ChildPath "PrereqOnline.txt" ) -type "Info"
                find-Module $Prereq | Install-Module -Verbose 
                Import-Module $Prereq -Force -Verbose
            }catch{
                Write-String (Join-Path -Path $StringPath -ChildPath "PrereqFailed.txt" ) -type "Info"
            break
            }
        }
    }
}