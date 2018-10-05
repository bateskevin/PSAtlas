Enum Level {
    Beginner
    Intermediate
    Advanced
    Expert
}

Class Lesson {
    [String]$Name
    [Level]$Level
    [Step[]]$Step

    Lesson($LessonCFG){
        $JSON = (Get-Content $LessonCFG) -join "`n" | ConvertFrom-Json

        $This.Name = $JSON.Name
        $This.Level = $JSON.Level

        $StepPath = (split-path $LessonCFG)
        $Steps = (Get-ChildItem $StepPath -Directory).FullName

        foreach($Step in $Steps){
            $StepJSON = Join-Path -Path $Step -ChildPath "Step.json"
            $Instance = [Step]::new($StepJSON)
            $This.Step += $Instance
        }        
    }
}