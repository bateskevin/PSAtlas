$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

. $File.Fullname

Import-Module Pester

Describe "Testing Step2" {
    it "The variable should be of type [bool]" {
        foreach($line in (Get-Content $File.Fullname)){
            Invoke-Expression $line
        }
        $Test | Should BeOfType bool
    }
}