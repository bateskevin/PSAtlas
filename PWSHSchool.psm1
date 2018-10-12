$ScriptPath = Split-Path $MyInvocation.MyCommand.Path





write-verbose "Loading Private Classes"

$PrivateClasses = gci "$ScriptPath/Classes/private" -Filter "*.Class.ps1" | Select -Expand FullName | sort -Descending



$PrivateClasses

foreach ($privateCL in $PrivateClasses){

    write-verbose "importing Class $($privateCL)"

    try{

        . $privateCL

    }catch{

        write-warning $_

    }

}





<#

write-verbose "Loading Private Functions"

$PrivateFunctions = gci "$ScriptPath\Functions\Private" -Filter *.ps1 | Select -Expand FullName







foreach ($Private in $PrivateFunctions){

    write-verbose "importing function $($function)"

    try{

        . $Private

    }catch{

        write-warning $_

    }

}

#>

write-verbose "Loading Public Functions"

$PublicFunctions = gci "$ScriptPath/Functions/public" -Filter *.ps1 | Select -Expand FullName





foreach ($public in $PublicFunctions){

    write-verbose "importing function $($public)"

    try{

        . $public

    }catch{

        write-warning $_

    }

}
