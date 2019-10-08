
# This is the Template for your second task in the PSHTML Guide. Edit the code below in order to finish it.

Import-Module PSHTML

# Start your code below from here. Add a 'Title' tag in the 'Head', add a 'div', containing a 'p' (p is paragraph) in your body and finally add a 'p' in your footer. 
  

$HTMl = html {
    Head {

    }

    Body {
        
    }

    footer {
        
    }
}

# Once you've finished. before you continue. take a look at what is in your variable.
# Under here just output your variable, in order for PSAtlas to test it. Do as follows: $<yourvariablename>
$HTMl

<#
If you want to see what your website looks like, fill in the $FilePath variable with a Path where you want to export your document and run the code down below here:


$FilePath = "Path where you want your file to be exported to. CAREFUL, include a filename with the fileextension '.html'"

$HTMl | Out-file -FilePath $FilePath -Encoding UTF8

start-process -FilePath 'C:\Program Files (x86)\Internet Explorer\iexplore.exe' -ArgumentList $FilePath

#>