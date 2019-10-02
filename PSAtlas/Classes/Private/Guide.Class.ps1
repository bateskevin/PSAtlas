Enum Level {
    Beginner
    Intermediate
    Advanced
    Expert
}

Class Guide {
    [String]$Name
    [Level]$Level
    [String[]]$Prerequisites
    [String[]]$Artifacts
    [Step[]]$Step

    Guide($GuideCFG){
        $JSON = (Get-Content $GuideCFG -ErrorAction Stop) -join "`n" | ConvertFrom-Json -ErrorAction Stop

        $This.Name = $JSON.Name
        $This.Level = $JSON.Level
        $This.Prerequisites = $JSON.Prerequisites
        $This.Artifacts = $JSON.Artifacts

        $StepPath = (split-path $GuideCFG)
        $Steps = Get-ChildItem $StepPath -Directory | ?{$_.Name -ne "Artifacts"} 

        foreach($Step in $Steps.FullName){
            $StepJSON = Join-Path -Path $Step -ChildPath "Step.json"
            $Instance = [Step]::new($StepJSON)
            $This.Step += $Instance
        }        
    }
}