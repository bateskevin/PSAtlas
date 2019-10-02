$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PSAtlas/PSAtlas" -force

InModuleScope PSAtlas {
    Describe "Testing Function Get-AtlasGuide" {
        Context "Base functionality" {
            it "[PSAtlas][Function][Get-AtlasGuide] Calling the function should not throw an error." {
                {Get-AtlasGuide} | should not throw
            }

            it "[PSAtlas][Function][Get-AtlasGuide] Calling the function with a parameter should not throw an error." {
                {Get-AtlasGuide -on "comments"} | should not throw
            }
          
            it "[PSAtlas][Function][Get-AtlasGuide] Calling the function with a false parameter should not throw an error." {
                {$null = Get-AtlasGuide -on "asdf"} | should not throw
            }
        }

        Context "Base functionality" {
            
            it "[PSAtlas][Function][Get-AtlasGuide] on should be 'Comments'." {
                $Obj = Get-AtlasGuide -on "Comments"
                $Obj.Name | Should BeLike "Comments"
            }

            it "[PSAtlas][Function][Get-AtlasGuide] Level should be 'Beginner'." {
                $Obj = Get-AtlasGuide -on "Comments"
                $Obj.Level | Should BeLike "Beginner"
            }

            it "[PSAtlas][Function][Get-AtlasGuide] Step should not be empty." {
                $Obj = Get-AtlasGuide -on "Comments"
                $Obj.Step | Should not BeNullOrEmpty
            }
        }
    }
}
