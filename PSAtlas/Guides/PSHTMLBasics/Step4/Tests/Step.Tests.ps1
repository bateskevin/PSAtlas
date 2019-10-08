$File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

Import-Module Pester

#$Content = Get-Content $File.Fullname

describe "PSHTML tests" {
    #foreach($Line in $content){if($line -ne "" -and $line -notlike "#*"){Invoke-Expression $line}}
    $HTML = Invoke-Expression $File.Fullname


    it "The HTML Variable should contain a opening and a closing html tag with a header body and a footer." {
        $HTML | should -BeLike "<html ><head ><title >Learn PSHTML with PSAtlas</title></head><Body ><h1 >Table of capitals</h1><div ><Table ><thead ><tr ><th >Capital</th><th >Country</th><th >Population</th></tr></thead><tbody ><tr ><td >Paris</td><td >France</td><td >2141000</td></tr><tr ><td >london</td><td >England</td><td >8136000</td></tr></tbody></Table></div></Body><footer ><p >Copyright 2019</p></footer></html>"
    } 
}