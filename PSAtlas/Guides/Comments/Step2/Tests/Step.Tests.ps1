$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

$global:Content =  get-content $File.Fullname

Import-Module Pester

Describe "Testing Step1" {
    it "The File should contain a Multiline Comment'" {
        $Content -match ".*<#" | should be $true
        $Content -match ".*#>" | should be $true
    }
}