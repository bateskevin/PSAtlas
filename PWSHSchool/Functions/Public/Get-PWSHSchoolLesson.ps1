function Get-PWSHSchoolLesson {
    param(
        [String[]]$Name
    )

    $Arr = @()

    if($Name){

        foreach($Lesson in $Name){
            $LessonHybrid = Join-Path -Path "Lessons" -ChildPath $Lesson
            $ModulePath = Split-path (Get-Module -name PWSHSchool).Path
            $LessonPath = (Join-Path -Path $ModulePath -ChildPath $LessonHybrid)
            $JSONPath = Join-Path -Path $LessonPath -ChildPath "Lesson.json"
            $Arr += $JSONPath
        } 
    }else{
        $LessonPath = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PWSHSchool).Path) -ChildPath "Lessons" ) -Directory | Select-Object -ExpandProperty FullName
        foreach($Lesson in $LessonPath){
            $JSONPath = Join-Path -Path "$($Lesson)" -ChildPath "Lesson.json"
            $Arr += $JSONPath
        }
    }

    $ObjArr = @()

    Foreach($JSONFile in $Arr){
        try{
            $RetObj = [Lesson]::new($JSONFile)
            $ObjArr += $RetObj
        }catch{
            
        }
    }
    return $ObjArr
}