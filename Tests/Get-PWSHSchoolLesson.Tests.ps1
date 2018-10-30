$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PWSHSchool/PWSHSchool" -force

InModuleScope PWSHSchool {
    Describe "Testing Function Get-PWSHSchoolLesson" {
        Context "Base functionality" {
            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Calling the function should not throw an error." {
                {Get-PWSHSchoolLesson} | should not throw
            }

            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Calling the function with a parameter should not throw an error." {
                {Get-PWSHSchoolLesson -Name "comments"} | should not throw
            }
          
            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Calling the function with a false parameter should not throw an error." {
                {$null = Get-PWSHSchoolLesson -Name "asdf"} | should not throw
            }
        }

        Context "Base functionality" {
            
            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Name should be 'Comments'." {
                $Obj = Get-PWSHSchoolLesson -Name "Comments"
                $Obj.Name | Should BeLike "Comments"
            }

            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Level should be 'Beginner'." {
                $Obj = Get-PWSHSchoolLesson -Name "Comments"
                $Obj.Level | Should BeLike "Beginner"
            }

            it "[PWSHSchool][Function][Get-PWSHSchoolLesson] Step should not be empty." {
                $Obj = Get-PWSHSchoolLesson -Name "Comments"
                $Obj.Step | Should not BeNullOrEmpty
            }
        }
    }
}
