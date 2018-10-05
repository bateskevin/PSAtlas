Function Start-PWSHSchoolLesson {

    [CmdletBinding()]
    Param(
        # Any other parameters can go here
    )

    DynamicParam {

        # Set the dynamic parameters' name
        $ParameterName = 'Lesson'
            
        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Create the collection of attributes
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        
        # Create and set the parameters' attributes
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $true
        $ParameterAttribute.Position = 1

        # Add the attributes to the attributes collection
        $AttributeCollection.Add($ParameterAttribute)

        # Generate and set the ValidateSet 
        #$arrSet = Get-ChildItem -Path "$Env:PsModulePath\PWSHSchool\Lessons" -Directory | Select-Object -ExpandProperty Name
        $arrSet = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PWSHSchool).Path) -ChildPath "Lessons" ) -Directory | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)

        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }

    begin {
        # Bind the parameter to a friendly variable
        $Lesson = $PsBoundParameters[$ParameterName]
    }

    process {

        $ModulePath = Split-path (Get-Module -name PWSHSchool).Path
        $LessonFolderPath = Join-Path -Path $ModulePath -ChildPath "Lessons"
        Clear-Host
        $LessonPath = Join-Path -Path $LessonFolderPath -ChildPath $Lesson
        $LessonJSON = Join-Path -Path $LessonPath -ChildPath "Lesson.json"
        #$LessonFilePath = Join-Path -Path $LessonPath -ChildPath "$Lesson.ps1"

        $LessonObj = [Lesson]::new($LessonJSON)

        $Count = 0
        $Stepcount = $LessonObj.Step.count

        Foreach($Step in $LessonObj.Step){
        $count++
            $LessonFinished = $false
            $next = ""

            $StepPath = Split-Path $Step.Path
            $LessonFilePath = Join-Path -Path $StepPath -ChildPath "$($Step.Title).ps1"

            if(Test-Path $LessonFilePath){
                while($already -ne "Y" -and $already -ne "N"){
                    $already = Read-Host "You already started this lesson, do you whish to continue? (Y/N) - Carefull, by selecting no you will loose your progress!"
                    Clear-Host
                    if($already -eq "Y"){
                       ise -file $LessonFilePath 
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
            ise -file $LessonFilePath
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
                        Write-Host @"

 ____  __          __  _______  __    __  _______  _______  __    __  _______  _______  ___
|    |\  \        /  /|       ||  |  |  ||       ||       ||  |  |  ||       ||       ||   |
|    | \  \      /  / |   ____||  |__|  ||   ____||   ____||  |__|  ||   _   ||   _   ||   |
|   _|  \  \_/\_/  /   _____   |   __   | ____    |  |____ |   __   ||  |_|  ||  |_|  ||   |___ 
|  |     \        /   |       ||  |  |  ||       ||       ||  |  |  ||       ||       ||       |
|__|      \__/\__/    |_______||__|  |__||_______||_______||__|  |__||_______||_______||_______|

Here are the things you can Run:

Test : Test your solution by typing test.
Skip : Skip this lesson and move on to the next one
                    
if you want to quit the Lesson hit ctrl + C. 
Remember that you will have to save your code in ISE to have it avaiable later on.

You are currently on Step $Count of $StepCount

Not quite there yet!

$($Step.Title)

$($Step.Description)

Your code failed with the following message:


"@ -ForegroundColor Green -BackgroundColor Black
                    write-host $($TestResult.TestResult.FailureMessage) -ForegroundColor Red -BackgroundColor Black
                    write-host ""
                    }
                }else{
                   
            Write-Host @"

 ____  __          __  _______  __    __  _______  _______  __    __  _______  _______  ___
|    |\  \        /  /|       ||  |  |  ||       ||       ||  |  |  ||       ||       ||   |
|    | \  \      /  / |   ____||  |__|  ||   ____||   ____||  |__|  ||   _   ||   _   ||   |
|   _|  \  \_/\_/  /   _____   |   __   | ____    |  |____ |   __   ||  |_|  ||  |_|  ||   |___ 
|  |     \        /   |       ||  |  |  ||       ||       ||  |  |  ||       ||       ||       |
|__|      \__/\__/    |_______||__|  |__||_______||_______||__|  |__||_______||_______||_______|

Here are the things you can Run:

Test : Test your solution by typing test.
Skip : Skip this lesson and move on to the next one
                    
if you want to quit the Lesson hit ctrl + C. 
Remember that you will have to save your code in ISE to have it avaiable later on.

You are currently on Step $Count of $StepCount

$($Step.Title)

$($Step.Description)

"@ -ForegroundColor Green -BackgroundColor Black
            }                

                if($next -eq "Skip"){
                    $LessonFinished = $true
                }

            if(!($LessonFinished)){
                $next = Read-Host "[$($LessonObj.Name)][$($Step.Title)]"
            }

            }
        }

    #Clear-PWSHSchoolLesson -Lesson Variable_Datatypes

    Clear-Host
    Write-Host @"

 ____  __          __  _______  __    __  _______  _______  __    __  _______  _______  ___
|    |\  \        /  /|       ||  |  |  ||       ||       ||  |  |  ||       ||       ||   |
|    | \  \      /  / |   ____||  |__|  ||   ____||   ____||  |__|  ||   _   ||   _   ||   |
|   _|  \  \_/\_/  /   _____   |   __   | ____    |  |____ |   __   ||  |_|  ||  |_|  ||   |___ 
|  |     \        /   |       ||  |  |  ||       ||       ||  |  |  ||       ||       ||       |
|__|      \__/\__/    |_______||__|  |__||_______||_______||__|  |__||_______||_______||_______|

Congratulations! you finished Lesson $($LessonObj.Name)
                    
Thank you for using PWSHSchool. If you are interessted why not start the next lesson? ;)

Cheers!

"@ -ForegroundColor Green -BackgroundColor Black
              
    }
}