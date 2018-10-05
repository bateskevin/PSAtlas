Enum Level {
    Beginner
    Intermediate
    Advanced
    Expert
}

Class Lesson {
    [String]$Name
    [Level]$Level
    [String[]]$Prerequisites
    [String[]]$Artifacts
    [Step[]]$Step

    Lesson($LessonCFG){
        $JSON = (Get-Content $LessonCFG) -join "`n" | ConvertFrom-Json

        $This.Name = $JSON.Name
        $This.Level = $JSON.Level
        $This.Prerequisites = $JSON.Prerequisites
        $This.Artifacts = $JSON.Artifacts

        $StepPath = (split-path $LessonCFG)
        $Steps = Get-ChildItem $StepPath -Directory | ?{$_.Name -ne "Artifacts"} 

        foreach($Step in $Steps.FullName){
            $StepJSON = Join-Path -Path $Step -ChildPath "Step.json"
            $Instance = [Step]::new($StepJSON)
            $This.Step += $Instance
        }        
    }
}