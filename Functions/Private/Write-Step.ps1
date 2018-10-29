
Function Write-Step {

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

    $LessonFinished = $false
            $next = ""
            $StepPath = Split-Path $Step.Path
            $LessonFilePath = Join-Path -Path $StepPath -ChildPath "$($Step.Title).ps1"

            if(Test-Path $LessonFilePath){
                while($already -ne "Y" -and $already -ne "N"){
                    Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"
                    $already = Read-Host "You already started this lesson, do you whish to continue? (Y/N) - Carefull, by selecting no you will loose your progress!"
                    Clear-Host
                    if($already -eq "Y"){
                        if($StartWithISE){
                            ise -file $LessonFilePath
                        }else{
                            code $LessonFilePath
                        } 
                    }elseif($already -eq "N"){
                        Remove-Item $LessonFilePath
                        $null = New-Item -ItemType File -Path $LessonFilePath
                        if(Test-Path $Step.Template){
                            $Templatecontent = Get-Content $Step.Template
                            $Templatecontent | out-file -FilePath $LessonFilePath -Append
                        }
                    }else{
                        Clear-Host
                        write-warning "Please enter 'Y' for yes or 'N' for no"
                    }
                }
                $already = ""
            }else{
                
                $null = New-Item -ItemType File -Path $LessonFilePath
                if(Test-Path $Step.Template){
                    $Templatecontent = Get-Content $Step.Template
                    $Templatecontent | out-file -FilePath $LessonFilePath -Append
                }
            }
            if($StartWithISE){
                ise -file $LessonFilePath
            }else{
                code $LessonFilePath
            }
                $LessonFinished = $false 
            while(!($LessonFinished )){
            
            if($next -eq "Test"){
                    $TestResult = Invoke-Pester $Step.Test -PassThru
                    #$next = ""

                    if($TestResult.TestResult.Passed){
                        Clear-Host
                        $LessonFinished = $true
                    }else{

                        Clear-Host
                        Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"    
                        write-host @"
You are currently on Step $Count of $StepCount

Not quite there yet!

$($Step.Title)

$($Step.Description)

"@  -ForegroundColor Gray

                        Write-Host "Your code failed with the following message:" -ForegroundColor Yellow
                        write-Host ""
                        write-host $($TestResult.TestResult.FailureMessage) -ForegroundColor Red
                        write-Host ""
                    }
                }else{
                   
                    Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"
                    Write-Host @"
You are currently on Step $Count of $StepCount

$($Step.Title)

$($Step.Description)

"@ -ForegroundColor Gray
            }                

                if($next -eq "Skip"){
                    $LessonFinished = $true
                }

            if(!($LessonFinished)){
                $next = Read-Host "[$($LessonObj.Name)][$($Step.Title)]"
            }

            }
}