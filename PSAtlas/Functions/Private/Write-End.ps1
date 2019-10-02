Function Write-End {

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

    Clear-Host
    Write-String (Join-Path -Path $StringPath -ChildPath "GuideFinished.txt" ) -type "Info"
}