Function Start-PWSHSchoolLession {

    [CmdletBinding()]
    Param(
        # Any other parameters can go here
    )

    DynamicParam {

        # Set the dynamic parameters' name
        $ParameterName = 'Lession'
            
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
        $arrSet = Get-ChildItem -Path "C:\Users\taabake4\git\PWSHSchool\Lessions" -Directory | Select-Object -ExpandProperty Name
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
        $Lession = $PsBoundParameters[$ParameterName]
    }

    process {
        $LessionPath = Join-Path -Path "C:\Users\taabake4\git\PWSHSchool\Lessions" -ChildPath $Lession
        $LessionJSON = Join-Path -Path $LessionPath -ChildPath "Lession.json"
        #$LessionFilePath = Join-Path -Path $LessionPath -ChildPath "$Lession.ps1"

        $LessionObj = [Lession]::new($LessionJSON)

        $Count = 0
        $Stepcount = $LessionObj.Step.count

        Foreach($Step in $LessionObj.Step){
        $count++
            $LessionFinished = $false
            $next = ""
            $already = ""

            $StepPath = Split-Path $Step.Path
            $LessionFilePath = Join-Path -Path $StepPath -ChildPath "$($Step.Title).ps1"

            if(Test-Path $LessionFilePath){
                while($already -ne "Y" -and $already -ne "N"){
                    $already = Read-Host "You already started this lesson, do you whish to continue? (Y/N) - Carefull, by selecting no you will loose your progress!"
                    if($already -eq "Y"){
                       ise -file $LessionFilePath 
                    }elseif($already -eq "N"){
                        Remove-Item $LessionFilePath
                        $null = New-Item -ItemType File -Path $LessionFilePath
                        "<#" | out-file -FilePath $LessionFilePath -Append
                        $Step.Title | out-file -FilePath $LessionFilePath -Append
                        $Step.Description | out-file -FilePath $LessionFilePath -Append
                        "#>" | out-file -FilePath $LessionFilePath -Append
                        if(Test-Path $Step.Template){
                            $Templatecontent = Get-Content $Step.Template
                            $Templatecontent | out-file -FilePath $LessionFilePath -Append
                        }
                    }else{
                        Clear-Host
                        write-warning "Please enter 'Y' for yes or 'N' for no"
                    }
                }
            }else{
                
                $null = New-Item -ItemType File -Path $LessionFilePath
                "<#" | out-file -FilePath $LessionFilePath -Append
                $Step.Title | out-file -FilePath $LessionFilePath -Append
                $Step.Description | out-file -FilePath $LessionFilePath -Append
                "#>" | out-file -FilePath $LessionFilePath -Append
                if(Test-Path $Step.Template){
                    $Templatecontent = Get-Content $Step.Template
                    $Templatecontent | out-file -FilePath $LessionFilePath -Append
                }
            }
            ise -file $LessionFilePath
            $LessionFinished = $false 
            do{        
                Clear-Host
                if($next -ne "Test" -and $next -ne "Skip"){
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

"@ -ForegroundColor Green -BackgroundColor Black
                $next = Read-Host "[$($LessionObj.Name)][$($Step.Title)]"

                }

                if($next -eq "Test"){
                    $TestResult = Invoke-Pester $Step.Test -PassThru

                    if($TestResult.TestResult.Passed){
                        Clear-Host
                        $LessionFinished = $true
                    }else{
                        Clear-Host
                        Write-Host "Not quite there yet!"
                        Write-Host ""
                        Write-Host "Your code failed with the following message:"
                        Write-Host "$($TestResult.TestResult.FailureMessage)" -foregroundcolor Red -backgroundcolor Black
                        Write-Host ""
                    }
                }

                

                if($next -eq "Skip"){
                    $LessionFinished = $true
                }

                

            }while($LessionFinished -eq $false)
        }      
    }
}