$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PWSHSchool/PWSHSchool" -force

InModuleScope PWSHSchool {
  Describe "Testing Class PWSHSchool Step" {
      Context "Base functionality" {
          it "[PWSHSchool][Class][Step] Creating an instance" {
              {[Step]::new("./PWSHSchool/Lessons/Variable_Datatypes/Step1/Step.json")} | should not throw
          }
      }

      Context "Properties" {

          $Step = [Step]::new("./PWSHSchool/Lessons/Variable_Datatypes/Step1/Step.json")

          it "[PWSHSchool][Class][Step] The Title Property should not be empty" {
              $Step.Title | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Step] The Title Property should be of type 'String'" {
              $Step.Title | should BeOfType String
          }

          it "[PWSHSchool][Class][Step] The Description Property should not be empty" {
              $Step.Description | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Step] The Hint Property should not be empty" {
              $Step.Hint | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Step] The Test Property should not be empty" {
              $Step.Test | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Step] The Path Property should not be empty" {
              $Step.Path | should not BeNullOrEmpty
          }

          it "[PWSHSchool][Class][Step] The Template Property should not be empty" {
              $Step.Template | should not BeNullOrEmpty
          }
      }
  }
}
