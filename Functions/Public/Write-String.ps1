Function Write-String {
    param(
        $Path,
        $Type
    )

    $Content = Get-Content $Path


    if($type -eq "Info"){
        foreach($line in $Content){
            write-host $line -BackgroundColor Black -ForegroundColor Green
        }
    }

    if($type -eq "Task"){
        foreach($line in $Content){
            write-host $line -BackgroundColor Black -ForegroundColor Cyan
        }
    }
}