$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PWSHSchool" -force

InModuleScope PWSHSchool {
  Describe "Testing Class PWSHSchool Lesson" {
      Context "Base functionality" {
          it "[PWSHSchool][Class][Lesson] Creating an instance" {
              {[Lesson]::new("./Lessons/Variable_Datatypes/Lesson.json")} | should not throw
          }
      }

      Context "Properties" {

          $Lesson = [Lesson]::new("./Lessons/Variable_Datatypes/Lesson.json")

          it "[PWSHSchool][Class][Lesson] The Name Property should not be empty" {
              $Lesson.Name | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Lesson] The Name Property should be of type 'String'" {
              $Lesson.Name | should BeOfType String
          }

          it "[PWSHSchool][Class][Lesson] The Level Property should not be empty" {
              $Lesson.Level | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Lesson] The Artifacts Property should not be empty" {
              $Lesson.Artifacts | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Lesson] The Prerequisites Property should not be empty" {
              $Lesson.Prerequisites | should not BeNullOrEmpty
          }
      }
  }
}
