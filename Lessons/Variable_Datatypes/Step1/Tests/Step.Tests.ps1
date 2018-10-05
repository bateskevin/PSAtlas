
. "C:\Users\taabake4\git\PWSHSchool\Lessons\Variable_Datatypes\Step1\Create a Variable.ps1"

Import-Module Pester

Describe "Testing Step1" {
    it "The variable should contain 'PWSHSchool'" {
        $variable = Define-Datatype
        $variable | Should BeExactly "PWSHSchool" 
    }
}