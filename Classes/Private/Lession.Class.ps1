Enum Level {
    Beginner
    Intermediate
    Advanced
    Expert
}

Class Lession {
    [String]$Name
    [Level]$Level
    [Step[]]$Step

    Lession($LessionCFG){
        $JSON = (Get-Content $LessionCFG) -join "`n" | ConvertFrom-Json

        $This.Name = $JSON.Name
        $This.Level = $JSON.Level

        $StepPath = (split-path $LessionCFG)
        $Steps = (Get-ChildItem $StepPath -Directory).FullName

        foreach($Step in $Steps){
            $StepJSON = Join-Path -Path $Step -ChildPath "Step.json"
            $Instance = [Step]::new($StepJSON)
            $This.Step += $Instance
        }        
    }
}