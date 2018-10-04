Class Step {
    [String]$Title
    [String]$Description
    [String]$Hint
    [String]$Path

    Step ($StepCFG){

        $JSON = (Get-Content $StepCFG) -join "`n" | ConvertFrom-Json

        $This.Title = $JSON.Title
        $This.Description = $JSON.Description
        $This.Hint = $JSON.Hint
        $This.Path = $StepCFG
    }
}