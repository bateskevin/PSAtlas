function Get-AtlasGuide {
    param(
        [String[]]$on
    )

    $Arr = @()

    if($on){

        foreach($Guide in $on){
            $GuideHybrid = Join-Path -Path "Guides" -ChildPath $Guide
            $ModulePath = Split-path (Get-Module -name PSAtlas).Path
            $GuidePath = (Join-Path -Path $ModulePath -ChildPath $GuideHybrid)
            $JSONPath = Join-Path -Path $GuidePath -ChildPath "Guide.json"
            $Arr += $JSONPath
        } 
    }else{
        $GuidePath = Get-ChildItem -Path (Join-Path -Path (Split-path (Get-Module -name PSAtlas).Path) -ChildPath "Guides" ) -Directory | Select-Object -ExpandProperty FullName
        foreach($Guide in $GuidePath){
            $JSONPath = Join-Path -Path "$($Guide)" -ChildPath "Guide.json"
            $Arr += $JSONPath
        }
    }

    $ObjArr = @()

    Foreach($JSONFile in $Arr){
        try{
            $RetObj = [Guide]::new($JSONFile)
            $ObjArr += $RetObj
        }catch{
            
        }
    }
    return $ObjArr
}