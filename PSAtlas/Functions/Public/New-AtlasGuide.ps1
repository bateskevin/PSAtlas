function New-AtlasGuide {
    param(
        [String]$Path = (Get-Location),
        [string]$on,
        [string]$Level,
        [string[]]$Prerequisites,
        [string[]]$Artifacts
    )

    $GuideHash = @{}
    $GuideHash.Name = $on
    $GuideHash.Level = $Level
    $GuideHash.Prerequisites = $Prerequisites

    $ArtifactNames = @()
    foreach($Artifact in $Artifacts){
        $ArtifactName = (Get-Item $Artifact).Name
        $ArtifactNames += $ArtifactName
    }
    $GuideHash.Artifacts = $ArtifactNames

    $GuideObj = New-Object psobject -Property $GuideHash

    $JSON = $GuideObj | ConvertTo-Json

    $FolderPath = Join-Path -Path $Path -ChildPath $on
    $ArtifactsPath = Join-Path -Path $FolderPath -ChildPath "Artifacts"
    $JSONPath = Join-Path -Path $FolderPath -ChildPath "Guide.json"
    $null = New-Item -Path $FolderPath -ItemType Directory
    $null = New-Item -Path $ArtifactsPath -ItemType Directory
    foreach($Artifact in $Artifacts){
        Copy-Item -Path $Artifact -Destination $ArtifactsPath -Recurse
    }

    $null = $JSON | Out-File -FilePath $JSONPath

}