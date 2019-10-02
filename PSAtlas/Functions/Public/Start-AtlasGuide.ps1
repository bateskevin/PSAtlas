Function Start-AtlasGuide {

    [CmdletBinding()]
    Param(
        [switch]$StartWithISE
    )

    DynamicParam {

        # Set the dynamic parameters' name
        $ParameterName = 'on'
            
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
        #$arrSet = Get-ChildItem -Path "$Env:PsModulePath\PWSHSchool\Guides" -Directory | Select-Object -ExpandProperty Name
        $arrSet = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PSAtlas).Path) -ChildPath "Guides" ) -Directory | Select-Object -ExpandProperty Name
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
        $Guide = $PsBoundParameters[$ParameterName]
    }

    process {

        $ModulePath = Split-path (Get-Module -name PSAtlas).Path
        $StringPath = Join-Path -Path $ModulePath -ChildPath "Style"
        $GuideFolderPath = Join-Path -Path $ModulePath -ChildPath "Guides"
        Clear-Host
        $GuidePath = Join-Path -Path $GuideFolderPath -ChildPath $Guide
        $GuideJSON = Join-Path -Path $GuidePath -ChildPath "Guide.json"
        #$GuideFilePath = Join-Path -Path $GuidePath -ChildPath "$Guide.ps1"

        $GuideObj = [Guide]::new($GuideJSON)

        Write-Start -Guide $Guide

        $Count = 0
        $Stepcount = $GuideObj.Step.count

        Foreach($Step in $GuideObj.Step){
            $count++
            Write-Step -Guide $Guide -Step $Step
        }

        Write-End -Guide $Guide
              
    }
}