# Submit Guides to PSAtlas

First of all, since you're here thanks for considering contributing to this project! 
Please be sure to also check out the [Contribution Guide](CONTRIBUTING.md), since I also recommend 
you stick to it while contributing Guides.

## How Guides are built up

Basically you have a topic you want to showcase. A module of yours for example.

Go ahead and think about how you could divide that topic up into different steps for somebody to learn it.

I also highly recommend you check out the [documentation on using the module](Students.md). Like this you will see what people are gonna face with your Guides. 

Also also, Check out my (very basic) [Guide on Powershell datatypes](https://github.com/bateskevin/PSAtlas/tree/master/Guides/Variable_Datatypes). This could serve you as a template for your first Guide.

## Speaking of steps

Speaking of steps, cause that's exactly how you gonna do it. There is a basic folder structure to follow 
while creating a PSAtlas Guide. Let me show it to you.

# How to build your Guide

PSAtlas provides you with a set of cmdlets to create Guides. 

Creating a Guide contains two steps.

## Create a Guide

You can create a Guide with the following command:

```
New-AtlasGuide
```

it does require a few inputs in order for it to work.

Example:

```
New-AtlasGuide -on "YourGuideTopic" -Level "Beginner" -Prerequisites "YourModuleOne","YourModuleTwo" -Artifacts "PathToYourModuleThree","PathToYourModuleFour"
```

### Parameter

#### Path

The Path parameter will be the location where your Guide will be saved. Note that the Name parameter (below) will be the name of the folder and the Path parameter really is only the path to your Guide folder. 

You can also ignore it and your Guide will be created at the current location of your shell.

#### on 

The on parameter will be the name of the folder containing your Guide. Also it will be Name of your Guide in PSAtlas.

#### Level

You can set one of 4 values here

* Beginner
* Intermediate
* Advanced
* Expert

Set the level according to how hard your Guide is gonna be to solve.

#### Prerequisites

Here you can pass your prerequisites. So if you want to have the module(s) loaded you created you can pass it here. **Note that prerequisites is for modules on the gallery only.**

#### Artifacts

If your module is not deployed to the gallery you can add it via the artifacts parameter. Just pass the path(s) to your modules here and they will be included in the Guide.

## Create a Step

Once you have created a Guide you can go ahead and create multiple steps for your Guide. 

```
New-AtlasStep
```

it does require a few inputs in order for it to work.

Example:

```
New-PSAtlasStep -Guide "PathToYourGuide" -Title "Title of your Step" -Description "Here you fill in what the Task for this step is" -Hint "Add a hint here if needed" -Template "PathToYourTemplate\Template.ps1" -Test "PathToYourTest\Test.Tests.ps1"
```

### Template

For each step you will have to create a code template that the user then can edit. Make sure to comment your sample code to make it as clear as possible to the user what he has to do. 

For example:

```
 Function Define-Datatype {
    
    #create your variable under here
    

    #return your variable here (delete <variablename> and replace it with your variable)
    return <variable>
}

# Save your code when finished and continue in the shell you started the Guide.
 ```
 
 ### Test
 
 For each step you will have to add a test that tests the code that the user edited. 
 
 For example:
 
  
 ```
 $File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

. $File.Fullname

Import-Module Pester

Describe "Testing Step1" {
    it "The variable should contain 'PSAtlas'" {
        $variable = Define-Datatype
        $variable | Should BeExactly "PSAtlas" 
    }
}
 ```
 
Make sure to add the following code at the start of your test:

 ```
 $File = (Get-Childitem "$PSScriptRoot\..\" -File) | ?{$_.name -ne "Template.ps1" -and $_.name -ne "Step.json"}  | select fullname

. $File.Fullname

Import-Module Pester
 ```
 
 With this code at the start of your test, pester will be loaded and also the file the user is editing in the current step will be loaded in to the test and you can use the edited code.

### Parameter 

#### Guide

Pass the path to the Guide you made.

#### Title

Enter the name of the step here

#### Description

Enter the description of your task here. This is the information the user is gonna have to solve your task, so try to make it as meaningfull as you can.

#### Hint

If you want you can add a Hint for your task, which the user then can call while solving your task.

#### Template

Pass the path to the file you prepared for this step. 

#### Test

Pass the path to the Test you created to test the code that the user edits.

# How do I add it to the module?

Once you have a fully finished Guide. Clone this module and save it in the "PWHSSchool\Guides" directory. Then import the Module and you can try out your Guide with the following code:

```
Start-PSAtlasGuide -Guide <Your_Guide_Name>
```
It will automatically be available for autocompletion, so no need for "Your_Guide_Name".

## Test it

Try it out yourself and if it works how you imagine, go ahead and submit a pull request. 

## Once again

Thanks for your interest in this module! I would love to see what you do with this module.
