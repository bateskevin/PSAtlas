function Get-PWSHSchoolLesson {
    param(
        [String[]]$Name
    )

    $Arr = @()

    if($Name){

        foreach($Lesson in $Name){
            $LessonPath = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PWSHSchool).Path) -ChildPath "Lessons\$Lesson" ) -Directory | Select-Object -ExpandProperty FullName
            $JSONPath = Join-Path -Path $LessonPath.FullName -ChildPath "Lesson.json"
            $Arr += $JSONPath
        } 
    }else{
        $LessonPath = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PWSHSchool).Path) -ChildPath "Lessons" ) -Directory | Select-Object -ExpandProperty FullName
        foreach($Lesson in $LessonPath){
            $JSONPath = Join-Path -Path "$($Lesson)" -ChildPath "Lesson.json"
            $Arr += $JSONPath
        }
    }

    $RetObj = [Lesson]::new($arr)
    return $RetObj
}