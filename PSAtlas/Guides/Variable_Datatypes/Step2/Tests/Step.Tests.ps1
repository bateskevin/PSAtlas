$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

. $File.Fullname

Import-Module Pester

Describe "Testing Step2" {
    it "The variable should be of type [bool]" {
        $variable = Define-Datatype
        $variable | Should BeOfType bool
    }
}