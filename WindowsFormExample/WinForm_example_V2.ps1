###################################
#
# 
#
###################################

#Set-ExecutionPolicy unrestricted -Scope CurrentUser
#Set-ExecutionPolicy unrestricted
# Set-ExecutionPolicy RemoteSigned

Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName "System"


$isInAction = $false #ref1

function RunProcess() {

    $labelMessage.Text = "Process Started."

    #process ini
	For ($i=0; $i -le 100; $i++) {

        if (-not $isInAction) {
            break
        }

		$labelMessage.Text = "Execute Item: $i."

		[System.Threading.Thread]::Sleep(100)
        [System.Windows.Forms.Application]::DoEvents() 
    }
    #process end

    if ($isInAction) {
	    $labelMessage.Text = "Process Finished."
    } else {
        $labelMessage.Text = "Process cancelled."
    }
}

function ChangeControlsSate() {
   
    if ($isInAction) {
        $formExample.Cursor = "WaitCursor"
        $buttonGenerate.Cursor = "AppStarting"
        $buttonGenerate.Text = "Cancel"
    }
    else {
        $FormExample.Cursor = "Default"
        $buttonGenerate.Cursor = "Default"
        $buttonGenerate.Text = "Generate"
    }
           
    $textBoxRootDir.Enabled = -not $isInAction
    $buttonDialogRootDir.Enabled = -not $isInAction
    $textBoxOutputFile.Enabled = -not $isInAction
    $buttonDialogOutputFile.Enabled = -not $isInAction
    $checkBoxRunAtEnd.Enabled = -not $isInAction
    $buttonClose.Enabled = -not $isInAction                
 
    [System.Windows.Forms.Application]::DoEvents() 

 }

Function FormExample_Load() {

    $labelMessage.Text = ""
	$textBoxOutputFile.Text = "test.txt"
}

Function FormExample_FormClosing() {

    $_.Cancel = $isInAction 
}

Function ButtonGenerate_Click() {

    #$isInAction = -not $isInAction #error - this create a new variable with same name but in this scope "local" 
    $script:isInAction = -not $isInAction #ref1

	ChangeControlsSate

	if ($isInAction) {
		RunProcess
        $script:isInAction = $false #ref1
		ChangeControlsSate
	}

}

Function ButtonClose_Click() {

    #[System.Windows.Forms.MessageBox]::Show("Close." , "My Dialog Box")
    $formExample.Close()
}

Function ButtonDialogRootDir_Click() {
    
    if ([String]::IsNullOrEmpty($script:textBoxRootDir.Text) -ne $true) {
		$dirName = [System.IO.Path]::GetDirectoryName($script:textBoxRootDir.Text)
    }

    $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowserDialog.SelectedPath = $HOME;
    $folderBrowserDialog.ShowNewFolderButton = $true;

    $result = $folderBrowserDialog.ShowDialog();

    if ($result -eq "OK") {                                     
		$script:textBoxRootDir.Text = $folderBrowserDialog.SelectedPath
    }
    
    $script:textBoxRootDir.Focus();
}

Function ButtonDialogOutputFile_Click() {

    $dirName = $HOME

    if ([String]::IsNullOrEmpty($script:textBoxRootDir.Text) -ne $true) {
        $dirName = [System.IO.Path]::GetDirectoryName($script:textBoxRootDir.Text)
    }

    $saveFileDialog1 = New-Object System.Windows.Forms.SaveFileDialog

    $saveFileDialog1.InitialDirectory = $dirName
    $saveFileDialog1.Title = "Save TXT File"
    $saveFileDialog1.CheckFileExists = $false
    $saveFileDialog1.CheckPathExists = $true
    $saveFileDialog1.DefaultExt = ".txt" #extention
    $saveFileDialog1.Filter = "TXT files |(*.txt)" #extention
    $saveFileDialog1.FilterIndex = 2
    $saveFileDialog1.RestoreDirectory = $true

    $result = $saveFileDialog1.ShowDialog()
    if ($result -eq "OK") {
        $textBoxOutputFile.Text = $saveFileDialog1.FileName
    }
    
    $textBoxOutputFile.Focus()
}


############
### Main ###
############

#def vars - visual objects

$formExample = New-Object system.Windows.Forms.Form

$label1 = New-Object System.Windows.Forms.Label 
$textBoxRootDir = New-Object System.Windows.Forms.TextBox 
$buttonDialogRootDir = New-Object System.Windows.Forms.Button 
$label2 = New-Object System.Windows.Forms.Label 
$textBoxOutputFile = New-Object System.Windows.Forms.TextBox 
$buttonDialogOutputFile = New-Object System.Windows.Forms.Button 
$checkBoxRunAtEnd = New-Object System.Windows.Forms.CheckBox 
$labelMessage = New-Object System.Windows.Forms.Label 
$labelNote = New-Object System.Windows.Forms.Label 
$buttonGenerate = New-Object System.Windows.Forms.Button 
$buttonClose = New-Object System.Windows.Forms.Button 

#def Properties

# 
# label1
# 
$label1.Name = "label1"
$label1.AutoSize = $true
$label1.ImeMode = "NoControl"
$label1.Location = New-Object System.Drawing.Point(12, 21)
$label1.Size = New-Object System.Drawing.Size(77, 13)
$label1.TabIndex = 1
$label1.Text = "Features Root:"

# 
# textBoxRootDir
# 
$textBoxRootDir.Location = New-Object System.Drawing.Point(115, 18)
$textBoxRootDir.Name = "textBoxRootDir"
$textBoxRootDir.Size = New-Object  System.Drawing.Size(428, 20)
$textBoxRootDir.TabIndex = 2;
$textBoxRootDir.Text = "" 
                     
# 
# buttonDialogRoot
# 
$buttonDialogRootDir.ImeMode = "NoControl"
$buttonDialogRootDir.Location = New-Object System.Drawing.Point(549, 18)
$buttonDialogRootDir.Name = "buttonDialogRoot"
$buttonDialogRootDir.Size = New-Object System.Drawing.Size(24, 20)
$buttonDialogRootDir.TabIndex = 3
$buttonDialogRootDir.Text = "..."
$buttonDialogRootDir.UseVisualStyleBackColor = $true
$buttonDialogRootDir.Add_Click( {ButtonDialogRootDir_Click} )
            
##################################

#
#label2
#
$label2.AutoSize = $true
$label2.ImeMode = "NoControl"
$label2.Location = New-Object System.Drawing.Point(11, 51)
$label2.Name = "label2"
$label2.Size = New-Object System.Drawing.Size(91, 13)
$label2.TabIndex = 4
$label2.Text = "Output File (TXT):"
            
#
# textBoxOutputFile
# 
$textBoxOutputFile.Location = New-Object System.Drawing.Point(114, 48)
$textBoxOutputFile.Name = "textBoxOutputFile";
$textBoxOutputFile.Size = New-Object System.Drawing.Size(428, 20)
$textBoxOutputFile.TabIndex = 5
$textBoxOutputFile.Text = ""
            
#
# buttonDialogCSV
# 
$buttonDialogOutputFile.ImeMode = "NoControl"
$buttonDialogOutputFile.Location = New-Object System.Drawing.Point(548, 48)
$buttonDialogOutputFile.Name = "buttonDialogCSV"
$buttonDialogOutputFile.Size = New-Object System.Drawing.Size(24, 20)
$buttonDialogOutputFile.TabIndex = 6
$buttonDialogOutputFile.Text = "..."
$buttonDialogOutputFile.UseVisualStyleBackColor = $true
$buttonDialogOutputFile.Add_Click( {ButtonDialogOutputFile_Click} )
                        
###################################
            
# 
# checkBoxRunAtEnd
# 
$checkBoxRunAtEnd.AutoSize = $true
$checkBoxRunAtEnd.Checked = $true
$checkBoxRunAtEnd.CheckState = "Checked"
$checkBoxRunAtEnd.ImeMode = "NoControl"
$checkBoxRunAtEnd.Location = New-Object System.Drawing.Point(15, 78)
$checkBoxRunAtEnd.Name = "checkBoxRunAtEnd"
$checkBoxRunAtEnd.Size = New-Object System.Drawing.Size(205, 17)
$checkBoxRunAtEnd.TabIndex = 7
$checkBoxRunAtEnd.Text = "Open result file after process finished."
$checkBoxRunAtEnd.UseVisualStyleBackColor = $true
            
#
# labelMessage
# 
$labelMessage.AutoSize = $true;
$labelMessage.ImeMode = "NoControl"
$labelMessage.Location = New-Object  System.Drawing.Point(12, 202)
$labelMessage.Name = "labelMessage"
$labelMessage.Size = New-Object  System.Drawing.Size(50, 13)
$labelMessage.TabIndex = 8
$labelMessage.Text = "Message"
            
            
# 
# labelNote
# 
$labelNote.AutoSize = $true
$labelNote.ImeMode = "NoControl"
$labelNote.Location = New-Object  System.Drawing.Point(341, 160)
$labelNote.Name = "labelNote"
$labelNote.Size = New-Object  System.Drawing.Size(218, 13)
$labelNote.TabIndex = 9
$labelNote.Text = "Note: All char semicolon are replaced by <$>"     
            
################################################
            
#
# buttonGenerate
# 
$buttonGenerate.ImeMode = "NoControl"
$buttonGenerate.Location = New-Object System.Drawing.Point(344, 192)
$buttonGenerate.Name = "buttonGenerate"
$buttonGenerate.Size = New-Object System.Drawing.Size(105, 24)
$buttonGenerate.TabIndex = 50
$buttonGenerate.Text = "Generate"
$buttonGenerate.UseVisualStyleBackColor = $true
$buttonGenerate.Add_Click( {ButtonGenerate_Click} )
            
# 
# buttonClose
# 
$buttonClose.ImeMode = "NoControl"
$buttonClose.Location = New-Object System.Drawing.Point(464, 192)
$buttonClose.Name = "buttonCloseOrCancel"
$buttonClose.Size = New-Object System.Drawing.Size(105, 24)
$buttonClose.TabIndex = 60
$buttonClose.Text = "Close"
$buttonClose.UseVisualStyleBackColor = $true
$buttonClose.Add_Click( {ButtonClose_Click} )
            
##########################################################            
            
# 
# formExample
# 
$formExample.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
$formExample.ClientSize = New-Object System.Drawing.Size(584, 230)
$formExample.FormBorderStyle = "FixedSingle"
#$formExample.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")))
$formExample.MaximizeBox = $false
$formExample.Name = "FormExample"
$formExample.StartPosition = "CenterScreen"
$formExample.Text = "Export features to .... file"
$formExample.AutoScaleMode = "Font"
$formExample.Cursor = "Default"

$formExample.Controls.Add($label1)
$formExample.Controls.Add($textBoxRootDir)
$formExample.Controls.Add($buttonDialogRootDir)

$formExample.Controls.Add($label2)
$formExample.Controls.Add($textBoxOutputFile)
$formExample.Controls.Add($buttonDialogOutputFile)
            
$formExample.Controls.Add($checkBoxRunAtEnd)
$formExample.Controls.Add($labelMessage)
$formExample.Controls.Add($labelNote)
$formExample.Controls.Add($buttonGenerate)
$formExample.Controls.Add($buttonClose)

$formExample.Add_Load( {FormExample_Load})            
$formExample.Add_Closing( {FormExample_FormClosing} )
            
#Start window
[System.Windows.Forms.Application]::EnableVisualStyles()

#option 1
[System.Windows.Forms.Application]::Run($formExample);

#option 2
#$formExample.ShowDialog()
