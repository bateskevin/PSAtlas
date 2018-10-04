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
        $arrSet = Get-ChildItem -Path "C:\git\PWSHSchool\Lessions" -Directory | Select-Object -ExpandProperty Name
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
        $LessionPath = Join-Path -Path "C:\git\PWSHSchool\Lessions" -ChildPath $Lession
        $LessionJSON = Join-Path -Path $LessionPath -ChildPath "Lession.json"
        $LessionFilePath = Join-Path -Path $LessionPath -ChildPath "current.ps1"

        $LessionObj = [Lession]::new($LessionJSON)

        $null = New-Item -ItemType File -Path $LessionFilePath

        Foreach($Step in $Lession.Step){
            "<#" | out-file -FilePath $LessionFilePath -Append
            $Step.Title | out-file -FilePath $LessionFilePath -Append
            $Step.Description | out-file -FilePath $LessionFilePath -Append
            "#>" | out-file -FilePath $LessionFilePath -Append
        }


    }

}