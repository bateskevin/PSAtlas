$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

Import-Module Pester

#$Content = Get-Content $File.Fullname

describe "PSHTML tests" {
    #foreach($Line in $content){if($line -ne "" -and $line -notlike "#*"){Invoke-Expression $line}}
    $HTML = Invoke-Expression $File.Fullname


    it "The HTML Variable should contain a opening and a closing html tag with a header body and a footer." {
        $HTML | should -BeLike "<html ><head ><title >*</title></head><Body ><h1 >*</h1><div ><p >*</p></div></Body><footer ><p >*</p></footer></html>"
    } 
}