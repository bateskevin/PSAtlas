
. "C:\Users\taabake4\git\PWSHSchool\Lessons\Variable_Datatypes\Step2\Create a variable with a specific Datatype.ps1"

Import-Module Pester

Describe "Testing Step2" {
    it "The variable should be of type [bool]" {
        $variable = Define-Datatype
        $variable | Should BeOfType bool
    }
}