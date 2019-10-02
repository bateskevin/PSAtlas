$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PSAtlas/PSAtlas" -force

InModuleScope PSAtlas {
  Describe "Testing Class PSAtlas Step" {
      Context "Base functionality" {
          it "[PSAtlas][Class][Step] Creating an instance" {
              {[Step]::new("./PSAtlas/Guides/Variable_Datatypes/Step1/Step.json")} | should not throw
          }
      }

      Context "Properties" {

          $Step = [Step]::new("./PSAtlas/Guides/Variable_Datatypes/Step1/Step.json")

          it "[PSAtlas][Class][Step] The Title Property should not be empty" {
              $Step.Title | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Step] The Title Property should be of type 'String'" {
              $Step.Title | should BeOfType String
          }

          it "[PSAtlas][Class][Step] The Description Property should not be empty" {
              $Step.Description | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Step] The Hint Property should not be empty" {
              $Step.Hint | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Step] The Test Property should not be empty" {
              $Step.Test | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Step] The Path Property should not be empty" {
              $Step.Path | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Step] The Template Property should not be empty" {
              $Step.Template | should not BeNullOrEmpty
          }
      }
  }
}
