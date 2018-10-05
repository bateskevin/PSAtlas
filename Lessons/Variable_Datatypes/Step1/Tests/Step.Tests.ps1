$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

. $File.Fullname

Import-Module Pester

Describe "Testing Step1" {
    it "The variable should contain 'PWSHSchool'" {
        $variable = Define-Datatype
        $variable | Should BeExactly "PWSHSchool" 
    }
}