#Permissions to run
#https:/go.microsoft.com/fwlink/?LinkID=135170

#Set-ExecutionPolicy Unrestricted -Scope CurrentUser

cls

Set-ExecutionPolicy unrestricted
#Set-ExecutionPolicy RemoteSigned

#region Import the Assemblies
#Add-Type -AssemblyName System.Windows.Forms
#Add-Type -AssemblyName System.Drawing
#Add-Type -AssemblyName System.IO
#Add-Type -AssemblyName System

[reflection.assembly]::loadwithpartialname("System.Windows.Forms") 
[reflection.assembly]::loadwithpartialname("System.Drawing") 
[reflection.assembly]::loadwithpartialname("System.IO") 
[reflection.assembly]::loadwithpartialname("System") 
#endregion

############
### MAIN ###
############
Write-Host "Start Pipeline."

#ps v2
$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Path
#write-host $ScriptDir
#ps v3...
#write-host $PSScriptRoot

cls

#include "No module"
#Import-module $ScriptDir\Cucumber_Includes\Cucumber_Form_NO_MODULE.ps1 -Force
#CreateGlobalVariables
#MountForm
#ShowIt

#include "With module"Com o user: francisc
Import-module $ScriptDir\Cucumber_Includes\Cucumber_Form.ps1 -Force
Import-module $ScriptDir\Cucumber_Includes\Cucumber_Process.ps1 -Force


$CucumberProcess.SetParameters("E:\_MEGA_DRIVE\PowerShell\features", "xpto.csv")
$CucumberProcess.Start()
            


$result = Get-ChildItem -Path "E:\MyBackups" –Recurse -Filter *.pbd | Select FullName | sort FullName
Write-Host $result[2]

Write-Host $result[3]

###############$CucumberForm.MountForm()
################$CucumberForm.ShowDialog()

Write-Host "Finished Pipeline."
$myname = read-host "Please enter your name:"
