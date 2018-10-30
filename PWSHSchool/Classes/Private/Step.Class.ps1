Class Step {
    [String]$Title
    [String]$Description
    [String]$Hint
    [string]$Template
    [string]$Test
    [String]$Path

    Step ($StepCFG){

        $JSON = (Get-Content $StepCFG -ErrorAction Stop) -join "`n" | ConvertFrom-Json -ErrorAction Stop

        $This.Title = $JSON.Title
        $This.Description = $JSON.Description
        $This.Hint = $JSON.Hint
        $This.Path = $StepCFG
        
        $StepPath = split-path $StepCFG
        $TemplatePath = Join-Path -Path $StepPath -ChildPath "Template.ps1"
        $TestPath = Join-Path -Path $StepPath -ChildPath "Tests/Step.Tests.ps1"

        $This.Template = $TemplatePath
        $This.Test = $TestPath
    }
}
