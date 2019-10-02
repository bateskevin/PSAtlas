function New-AtlasStep {
    param(
        [String]$Guide,
        [string]$Title,
        [string]$Description,
        [string]$Hint,
        [string[]]$Template,
        [String[]]$Test
    )

    $StepHash = @{}
    $StepHash.Title = $Title
    $StepHash.Description = $Description
    $StepHash.Hint = $Hint

    $StepObj = New-Object psobject -Property $StepHash
    
    $JSON = $StepObj | ConvertTo-Json

    $CheckPath = Join-Path -Path $Guide -ChildPath "Step1"
    if(!(Test-Path $CheckPath)){
        $FolderPath = Join-Path -Path $Guide -ChildPath "Step1"
    }else{
        $Steps = Get-ChildItem $Guide -Directory | ?{$_.Name -ne "Artifacts"}
        $Numbers = @()
        foreach($Step in $Steps.name){
            $Number = $Step.Substring($Step.Length - 1)
            [int]$IntNumber = $number
            $Numbers += $IntNumber
        }

        [String]$Number = (($Numbers | sort -Descending | select -First 1) + 1)
        $FolderPath = Join-Path -Path $Guide -ChildPath "Step$($Number)"
    }

    $TestsPath = Join-Path -Path $FolderPath -ChildPath "Tests"
    $TestPath = Join-Path -Path $Testspath -ChildPath "Step.Tests.ps1"
    $TemplatePath = Join-Path -Path $FolderPath -ChildPath "Template.ps1"
    $JSONPath = Join-Path -Path $FolderPath -ChildPath "Step.json"
    $null = New-Item -Path $FolderPath -ItemType Directory
    $null = New-Item -Path $TestsPath -ItemType Directory
    $null = $JSON | Out-File -FilePath $JSONPath
    Copy-Item -Path $Template -Destination $TemplatePath
    Copy-Item -Path $Test -Destination $TestPath

}