Function Write-String {
	<#
		.SYNOPSIS
			Write the content of a file to the screen
			
		.DESCRIPTION
			Write in color the content of a file to the screen
			
		.PARAMETER Path
			The path to the file
			
		.PARAMETER Type
			Type of data to process, will determine the different colors to write in.
			
		.EXAMPLE
			Write-String -Path C:\temp\myData.txt -Type Info
			Write the content of myData.txt to the screen in green
			
		.EXAMPLE
			Write-String -Path C:\temp\StuffToDo.txt -Type Task
			Write the content of StuffToDo.txt to the screen in cyan
			
		.NOTES
		   AUTHOR: Kevin BATES
		   LASTEDIT: 09/10/2018(Ichigo49)
	#>
    param(
        $Path,
        $Type
    )

    $Content = Get-Content $Path


    if($type -eq "Info"){
        foreach($line in $Content){
            write-host $line -ForegroundColor Cyan
        }
    }

    if($type -eq "Task"){
        foreach($line in $Content){
            write-host $line -ForegroundColor Gray
        }
    }
}
