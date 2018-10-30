Function Clear-PWSHSchoolLesson {

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
        $LessonPath = Join-Path -Path $LessonFolderPath -ChildPath $Lesson

        $StepPaths = (Get-ChildItem $LessonPath -Recurse -File | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json" -and $_.name -ne "Lesson.json" -and $_.name -notlike "*.Tests.ps1"}).FullName

        foreach($step in $StepPaths){
            $File = (Get-item $step) 
            Remove-Item $File
        }
        
        
    }



}