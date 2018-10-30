
Function Write-Start {

    param (
        $Lesson
    )

    $ModulePath = Split-path (Get-Module -name PWSHSchool).Path
    $StringPath = Join-Path -Path $ModulePath -ChildPath "Style"
    $LessonFolderPath = Join-Path -Path $ModulePath -ChildPath "Lessons"
    Clear-Host
    $LessonPath = Join-Path -Path $LessonFolderPath -ChildPath $Lesson
    $LessonJSON = Join-Path -Path $LessonPath -ChildPath "Lesson.json"

    $LessonObj = [Lesson]::new($LessonJSON)

    if($LessonObj.Artifacts){
        foreach($Artifact in $LessonObj.Artifacts){
            try{   
                Write-String (Join-Path -Path $StringPath -ChildPath "Prerequisites.txt" ) -type "Info"
                $ArtifactPath = join-path -Path $LessonPath -ChildPath "Artifacts"
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

    if($LessonObj.Prerequisites){
        Clear-Host
        foreach($Prereq in $LessonObj.Prerequisites){
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