Function Write-End {

    param (
        $Lesson
    )

    $ModulePath = Split-path (Get-Module -name PWSHSchool).Path
    $StringPath = Join-Path -Path $ModulePath -ChildPath "Style"
    $LessonFolderPath = Join-Path -Path $ModulePath -ChildPath "Lessons"
    Clear-Host
    $LessonPath = Join-Path -Path $LessonFolderPath -ChildPath $Lesson
    $LessonJSON = Join-Path -Path $LessonPath -ChildPath "Lesson.json"

    $LessonObj = [Lesson]::new($LessonJSON)

    Clear-Host
    Write-String (Join-Path -Path $StringPath -ChildPath "LessonFinished.txt" ) -type "Info"
}