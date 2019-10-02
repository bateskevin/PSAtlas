
Function Write-Step {

    param (
        $Guide,
        $Step
    ) 

    $ModulePath = Split-path (Get-Module -name PSAtlas).Path
    $StringPath = Join-Path -Path $ModulePath -ChildPath "Style"
    $GuideFolderPath = Join-Path -Path $ModulePath -ChildPath "Guides"
    Clear-Host
    $GuidePath = Join-Path -Path $GuideFolderPath -ChildPath $Guide
    $GuideJSON = Join-Path -Path $GuidePath -ChildPath "Guide.json"

    $GuideObj = [Guide]::new($GuideJSON)

    $GuideFinished = $false
            $next = ""
            $StepPath = Split-Path $Step.Path
            $GuideFilePath = Join-Path -Path $StepPath -ChildPath "$($Step.Title).ps1"

            if(Test-Path $GuideFilePath){
                while($already -ne "Y" -and $already -ne "N"){
                    Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"
                    $already = Read-Host "You already started this Guide, do you whish to continue? (Y/N) - Carefull, by selecting no you will loose your progress!"
                    Clear-Host
                    if($already -eq "Y"){
                        if($StartWithISE){
                            ise -file $GuideFilePath
                        }else{
                            code $GuideFilePath
                        } 
                    }elseif($already -eq "N"){
                        Remove-Item $GuideFilePath
                        $null = New-Item -ItemType File -Path $GuideFilePath
                        if(Test-Path $Step.Template){
                            $Templatecontent = Get-Content $Step.Template
                            $Templatecontent | out-file -FilePath $GuideFilePath -Append
                        }
                    }else{
                        Clear-Host
                        write-warning "Please enter 'Y' for yes or 'N' for no"
                    }
                }
                $already = ""
            }else{
                
                $null = New-Item -ItemType File -Path $GuideFilePath
                if(Test-Path $Step.Template){
                    $Templatecontent = Get-Content $Step.Template
                    $Templatecontent | out-file -FilePath $GuideFilePath -Append
                }
            }
            if($StartWithISE){
                ise -file $GuideFilePath
            }else{
                code $GuideFilePath
            }
                $GuideFinished = $false 
            while(!($GuideFinished )){
            
            if($next -eq "Test"){
                    $TestResult = Invoke-Pester $Step.Test -PassThru
                    #$next = ""

                    if($TestResult.TestResult.Passed){
                        Clear-Host
                        $GuideFinished = $true
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
                }elseif($next -eq "Hint"){
                    Clear-Host
                    Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"
                    write-host @"
You are currently on Step $Count of $StepCount

Not quite there yet!

$($Step.Title)

$($Step.Description)

"@  -ForegroundColor Gray
                    if($Step.Hint){
                        Write-Host "Hint: $($Step.Hint)" -ForegroundColor Yellow
                        write-host ""
                    }else{
                        Write-Host "Hint: For this step there is no Hint available." -ForegroundColor Yellow
                        write-host ""
                    }
                }else{
                    Clear-Host
                    Write-String (Join-Path -Path $StringPath -ChildPath "LandingPage.txt" ) -type "Info"
                    Write-Host @"
You are currently on Step $Count of $StepCount

$($Step.Title)

$($Step.Description)

"@ -ForegroundColor Gray
            }                

                if($next -eq "Skip"){
                    $GuideFinished = $true
                }

            if(!($GuideFinished)){
                $next = Read-Host "[$($GuideObj.Name)][$($Step.Title)]"
            }

            }
}