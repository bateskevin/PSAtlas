#Function to update the codecoverage badge on Github
function Update-CodeCoveragePercent {  
    [cmdletbinding(supportsshouldprocess)]
    param(
        [int]
        $CodeCoverage = 0,
        [string]
        $TextFilePath = ".\Readme.md"
    )

    $BadgeColor = switch ($CodeCoverage) {
        {$_ -in 90..100} { 'brightgreen' }   
        {$_ -in 75..89}  { 'yellow' }
        {$_ -in 60..74}  { 'orange' }
        default          { 'red' }
    }

    if ($PSCmdlet.ShouldProcess($TextFilePath)) {
        $ReadmeContent = (Get-Content $TextFilePath)
        $ReadmeContent = $ReadmeContent -replace "!\[Test Coverage\].+\)", "![Test Coverage](https://img.shields.io/badge/coverage-$CodeCoverage%25-$BadgeColor.svg?maxAge=60)" 
        $ReadmeContent | Set-Content -Path $TextFilePath
    }
}

#Importing Modules
import-module pester
start-sleep -seconds 2


#Pester Tests
write-verbose "invoking pester"
$TestFiles = (Get-ChildItem -Path .\ -Recurse  | ?{$_.name.EndsWith(".ps1") -and $_.name -notmatch ".tests." -and $_.name -notmatch "build" -and $_.name -notmatch "Example"}).Fullname
$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru -CodeCoverage $TestFiles

#Uploading Testresults to Appveyor
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))

#Updating Codecoverage
$CoveragePercent = [math]::floor(100 - (($res.CodeCoverage.NumberOfCommandsMissed / $res.CodeCoverage.NumberOfCommandsAnalyzed) * 100))
Update-CodeCoveragePercent -CodeCoverage $CoveragePercent

#Checking Pester Results
if ($res.FailedCount -gt 0) { 
    throw "$($res.FailedCount) tests failed."
}
if($res.FailedCount -eq 0 -and $APPVEYOR_REPO_COMMIT_MESSAGE -match '^.*dep-psgallery$'){
    write-host "Module would now be deployed to the psgallery" -forgroundcolor green
}else{
    write-host "Module would not be deployed to the psgallery" -forgroundcolor Yellow
}

#Updating Manifest (Module Version)
$manifestpath = ".\"+"PWSHSchool"+".psd1"
$manifest = Test-ModuleManifest -Path $manifestPath
[System.Version]$version = $manifest.Version
if($env:APPVEYOR_REPO_COMMIT_MESSAGE -match '\[(Major)\]'){
    [String]$newVersion = New-Object -TypeName System.Version -ArgumentList (($version.Major + 1), 0, 0)
}elseif($env:APPVEYOR_REPO_COMMIT_MESSAGE -match '\[(Minor)\]'){
    [String]$newVersion = New-Object -TypeName System.Version -ArgumentList ($version.Major, ($version.minor + 1), 0)
}else{
    [String]$newVersion = New-Object -TypeName System.Version -ArgumentList ($version.Major, $version.Minor, ($version.build + 1))
}
write-host "Going to increment Version number from $Version to $NewVersion"-forgroundcolor green
Update-ModuleManifest -Path $manifestPath -ModuleVersion $newVersion -CmdletsToExport '*' -FunctionsToExport '*' -VariablesToExport '*'
