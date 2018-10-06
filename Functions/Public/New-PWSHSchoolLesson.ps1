function New-PWSHSchoolLesson {
    param(
        [String]$Path = (Get-Location),
        [string]$Name,
        [string]$Level,
        [string[]]$Prerequisites,
        [string[]]$Artifacts
    )

    $LessonHash = @{}
    $LessonHash.Name = $Name
    $LessonHash.Level = $Level
    $LessonHash.Prerequisites = $Prerequisites

    $ArtifactNames = @()
    foreach($Artifact in $Artifacts){
        $ArtifactName = (Get-Item $Artifact).Name
        $ArtifactNames += $ArtifactName
    }
    $LessonHash.Artifacts = $ArtifactNames

    $LessonObj = New-Object psobject -Property $LessonHash

    $JSON = $LessonObj | ConvertTo-Json

    $FolderPath = Join-Path -Path $Path -ChildPath $Name
    $TestsPath = Join-Path -Path $FolderPath -ChildPath "Tests"
    $ArtifactsPath = Join-Path -Path $FolderPath -ChildPath "Artifacts"
    $JSONPath = Join-Path -Path $FolderPath -ChildPath "Lesson.json"
    $null = New-Item -Path $FolderPath -ItemType Directory
    $null = New-Item -Path $TestsPath -ItemType Directory
    $null = New-Item -Path $ArtifactsPath -ItemType Directory
    foreach($Artifact in $Artifacts){
        Copy-Item -Path $Artifact -Destination $ArtifactsPath -Recurse
    }

    $null = $JSON | Out-File -FilePath $JSONPath

}