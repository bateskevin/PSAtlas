$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Import-module "./PSAtlas/PSAtlas" -force

InModuleScope PSAtlas {
  Describe "Testing Class PSAtlas Guide" {
      Context "Base functionality" {
          it "[PSAtlas][Class][Guide] Creating an instance" {
              {[Guide]::new("./PSAtlas/Guides/Variable_Datatypes/Guide.json")} | should not throw
          }
      }

      Context "Properties" {

          $Guide = [Guide]::new("./PSAtlas/Guides/Variable_Datatypes/Guide.json")

          it "[PSAtlas][Class][Guide] The Name Property should not be empty" {
              $Guide.Name | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Guide] The Name Property should be of type 'String'" {
              $Guide.Name | should BeOfType String
          }

          it "[PSAtlas][Class][Guide] The Level Property should not be empty" {
              $Guide.Level | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Guide] The Artifacts Property should not be empty" {
              $Guide.Artifacts | should not BeNullOrEmpty
          }

          it "[PSAtlas][Class][Guide] The Prerequisites Property should not be empty" {
              $Guide.Prerequisites | should not BeNullOrEmpty
          }
      }
  }
}
