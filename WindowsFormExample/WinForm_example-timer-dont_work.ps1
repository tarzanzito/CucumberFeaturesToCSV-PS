#Set-ExecutionPolicy unrestricted -Scope CurrentUser
#Set-ExecutionPolicy unrestricted
# Set-ExecutionPolicy RemoteSigned

##Add-Type -AssemblyName System.Windows.Forms

##region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms")
[reflection.assembly]::loadwithpartialname("System.Drawing")
[reflection.assembly]::loadwithpartialname("System")
[reflection.assembly]::loadwithpartialname("System.Threading")
##endregion

$isInAction = $false #ref1

function RunProcess() {

    #$timer1.Enabled = $true
    #$timer1.Start()
    $labelMessage.Text = "Begin Process."

	For ($i=0; $i -le 1000000; $i++) {
		$labelMessage.Text = "Execute Item: $i."
		[System.Threading.Thread]::Sleep(100)
        [System.Windows.Forms.Application]::DoEvents() 
    }

    #$timer1.Stop()
	$labelMessage.Text = "End Process."
}

function ChangeControlsSatus() {

   
    if ($isInAction) {
        $formExample.Cursor = [System.Windows.Forms.Cursors]::WaitCursor
        $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
        $buttonGenerate.Cursor = [System.Windows.Forms.Cursors]::AppStarting
    }
    else {
        $FormExample.Cursor = [System.Windows.Forms.Cursors]::Default
        $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
        $buttonGenerate.Cursor = [System.Windows.Forms.Cursors]::Default
    }
           
    #$progressBar.Visible = $isInAction
    $textBoxRootDir.Enabled = -not $isInAction
    $buttonDialogRootDir.Enabled = -not $isInAction
    $textBoxOutputFile.Enabled = -not $isInAction
    $buttonDialogOutputFile.Enabled = -not $isInAction
    $checkBoxRunAtEnd.Enabled = -not $isInAction
    $buttonClose.Enabled = -not $isInAction                
}

### method 1 ### - Declare Variable as function
$ButtonGenerate_Click = {

    #$isInAction = -not $isInAction #error - this create a new variable $isInAction in this scope 
    $script:isInAction = -not $isInAction #ref1

	ChangeControlsSatus

	if ($isInAction) {
		RunProcess
        $script:isInAction = -not $isInAction #ref1
		ChangeControlsSatus
	}
    

	#[System.Windows.Forms.MessageBox]::Show("Hello World." , "My Dialog Box")
}

### method 2 ### - Declare function

Function FormExample_Load() {
    $labelMessage.Text = ""
	$textBoxOutputFile.Text = "test.txt"
}

Function FormExample_FormClosing() {
    $_.Cancel = $isInAction 
}

Function ButtonClose_Click() {
    #[System.Windows.Forms.MessageBox]::Show("Close." , "My Dialog Box")
    $formExample.Close()
}

Function ButtonDialogRootDir_Click() {
    #[System.Windows.Forms.MessageBox]::Show("Button Dialog Root Click." , "My Dialog Box")
	
	$dirName = $HOME    
    if ([String]::IsNullOrEmpty($script:textBoxRootDir.Text) -ne $true) {
		$dirName = [System.IO.Path]::GetDirectoryName($script:textBoxRootDir.Text)
    }

    $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    #folderBrowserDialog.RootFolder = Environment.SpecialFolder.MyComputer;
    $folderBrowserDialog.SelectedPath = $dirName;
    $folderBrowserDialog.ShowNewFolderButton = $true;

    #System.Windows.Forms.DialogResult result = folderBrowserDialog.ShowDialog();
    $result = $folderBrowserDialog.ShowDialog();

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {                                     
		$script:textBoxRootDir.Text = $folderBrowserDialog.SelectedPath
    }
    
    $script:textBoxRootDir.Focus();
}

Function ButtonDialogOutputFile_Click() {
    
	#[System.Windows.Forms.MessageBox]::Show("Button Dialog CSV Click." , "My Dialog Box")
	#$path = [System.Windows.Forms.Application]::ExecutablePath
    #$path = [System.Environment.SpecialFolder]::MyDocuments
	
	$path = $HOME
    $dirName = [System.IO.Path]::GetDirectoryName($path)

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
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $script:textBoxOutputFile.Text = $saveFileDialog1.FileName
    }
    
    $script:textBoxOutputFile.Focus()
}

Function timer1_Tick() {

	$timer1.Enabled = $false
    #do sothing
    $a =Get-Random
$labelNote.Text = $a
	$timer1.Enabled = $true

}

############
### Main ###
############

#def vars - visual objects

$formExample = New-Object system.Windows.Forms.Form

$progressBar = New-Object System.Windows.Forms.ProgressBar 
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

$timer1 =  New-Object System.Windows.Forms.Timer

#def Properties

# 
# timer1
# 
$timer1.Interval = 3000
$timer1.add_Tick( {timer1_Tick} ) 

# 
# progressBar
# 
$progressBar.Dock = [System.Windows.Forms.DockStyle]::Top
$progressBar.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$progressBar.Location = New-Object System.Drawing.Point(0, 0)
$progressBar.MarqueeAnimationSpeed = 100
$progressBar.Name = "progressBar"
$progressBar.Size = New-Object System.Drawing.Size(584, 13)
$progressBar.TabIndex = 0;
#$progressBar.Visible = $false
            
# 
# label1
# 
$label1.Name = "label1"
$label1.AutoSize = $true
$label1.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$label1.Location = New-Object System.Drawing.Point(12, 34)
$label1.Size = New-Object System.Drawing.Size(77, 13)
$label1.TabIndex = 1
$label1.Text = "Features Root:"

# 
# textBoxRootDir
# 
$textBoxRootDir.Location = New-Object System.Drawing.Point(115, 31)
$textBoxRootDir.Name = "textBoxRootDir"
$textBoxRootDir.Size = New-Object  System.Drawing.Size(428, 20)
$textBoxRootDir.TabIndex = 2;
$textBoxRootDir.Text = "" 
                     
# 
# buttonDialogRoot
# 
$buttonDialogRootDir.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$buttonDialogRootDir.Location = New-Object System.Drawing.Point(549, 31)
$buttonDialogRootDir.Name = "buttonDialogRoot"
$buttonDialogRootDir.Size = New-Object System.Drawing.Size(24, 20)
$buttonDialogRootDir.TabIndex = 3
$buttonDialogRootDir.Text = "..."
$buttonDialogRootDir.UseVisualStyleBackColor = $true
#$buttonDialogRoot.Click += new System.EventHandler(this.buttonDialogRoot_Click);
$buttonDialogRootDir.Add_Click( {ButtonDialogRootDir_Click} )
            
##################################
#
#label2
#
$label2.AutoSize = $true
$label2.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$label2.Location = New-Object System.Drawing.Point(11, 61)
$label2.Name = "label2"
$label2.Size = New-Object System.Drawing.Size(91, 13)
$label2.TabIndex = 4
$label2.Text = "Output File (TXT):"
            
#
# textBoxOutputFile
# 
$textBoxOutputFile.Location = New-Object System.Drawing.Point(114, 58)
$textBoxOutputFile.Name = "textBoxOutputFile";
$textBoxOutputFile.Size = New-Object System.Drawing.Size(428, 20)
$textBoxOutputFile.TabIndex = 5
$textBoxOutputFile.Text = ""
            
#
# buttonDialogCSV
# 
$buttonDialogOutputFileImeMode = [System.Windows.Forms.ImeMode]::NoControl
$buttonDialogOutputFile.Location = New-Object System.Drawing.Point(548, 57)
$buttonDialogOutputFile.Name = "buttonDialogCSV"
$buttonDialogOutputFile.Size = New-Object System.Drawing.Size(24, 20)
$buttonDialogOutputFile.TabIndex = 6
$buttonDialogOutputFile.Text = "..."
$buttonDialogOutputFile.UseVisualStyleBackColor = $true
#$buttonDialogCSV.Click += new System.EventHandler(this.buttonDialogOutputFile_Click);
$buttonDialogOutputFile.Add_Click( {ButtonDialogOutputFile_Click})
                        
###################################
            
# 
# checkBoxRunAtEnd
# 
$checkBoxRunAtEnd.AutoSize = $true
$checkBoxRunAtEnd.Checked = $true
$checkBoxRunAtEnd.CheckState = [System.Windows.Forms.CheckState]::Checked
$checkBoxRunAtEnd.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$checkBoxRunAtEnd.Location = New-Object System.Drawing.Point(15, 91)
$checkBoxRunAtEnd.Name = "checkBoxRunAtEnd"
$checkBoxRunAtEnd.Size = New-Object System.Drawing.Size(205, 17)
$checkBoxRunAtEnd.TabIndex = 7
$checkBoxRunAtEnd.Text = "Open result file after process finished."
$checkBoxRunAtEnd.UseVisualStyleBackColor = $true
            
#
# labelMessage
# 
$labelMessage.AutoSize = $true;
$labelMessage.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$labelMessage.Location = New-Object  System.Drawing.Point(12, 202)
$labelMessage.Name = "labelMessage"
$labelMessage.Size = New-Object  System.Drawing.Size(50, 13)
$labelMessage.TabIndex = 8
$labelMessage.Text = "Message"
            
            
# 
# labelNote
# 
$labelNote.AutoSize = $true
$labelNote.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$labelNote.Location = New-Object  System.Drawing.Point(341, 160)
$labelNote.Name = "labelNote"
$labelNote.Size = New-Object  System.Drawing.Size(218, 13)
$labelNote.TabIndex = 9
$labelNote.Text = "Note: All char semicolon are replaced by <$>"     
            
################################################
            
#
# buttonGenerate
# 
$buttonGenerate.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$buttonGenerate.Location = New-Object System.Drawing.Point(344, 192)
$buttonGenerate.Name = "buttonGenerate"
$buttonGenerate.Size = New-Object System.Drawing.Size(105, 24)
$buttonGenerate.TabIndex = 50
$buttonGenerate.Text = "Generate"
$buttonGenerate.UseVisualStyleBackColor = $true
#$buttonGenerate.Click += new System.EventHandler(this.buttonGenerate_Click)
$buttonGenerate.Add_Click($ButtonGenerate_Click)
            
# 
# buttonClose
# 
$buttonClose.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$buttonClose.Location = New-Object System.Drawing.Point(464, 192)
$buttonClose.Name = "buttonCloseOrCancel"
$buttonClose.Size = New-Object System.Drawing.Size(105, 24)
$buttonClose.TabIndex = 60
$buttonClose.Text = "Close"
$buttonClose.UseVisualStyleBackColor = $true
#$buttonCloseOrCancel.Click += new System.EventHandler(this.buttonCloseOrCancel_Click);
$buttonClose.Add_Click( {ButtonClose_Click})
            
##########################################################            
            
# 
# formExample
# 
$formExample.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
$formExample.ClientSize = New-Object System.Drawing.Size(584, 230)
$formExample.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle #enum
#$formExample.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")))
$formExample.MaximizeBox = $false
$formExample.Name = "FormExample"
$formExample.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen #enum
$formExample.Text = "Export features to CSV file"
$formExample.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font #enum
$formExample.Cursor = [System.Windows.Forms.Cursors]::Default #enum

$formExample.Controls.Add($progressBar)

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

#$formExample.Controls.Add($timer1)      

#$script:Load += new System.EventHandler(FormCucumberFeaturesExport_Load)
$formExample.Add_Load( {FormExample_Load})            
#$script:FormClosed += new System.Windows.Forms.FormClosedEventHandler(FormCucumberFeaturesExport_FormClosed)
$formExample.Add_Closing( {FormExample_FormClosing} )
            
#Start window


#[System.Windows.Forms.Application]::SetCompatibleTextRenderingDefault($false)  ERROR
[System.Windows.Forms.Application]::EnableVisualStyles()
#option 1
[System.Windows.Forms.Application]::Run($formExample);

#option 2
#$formExample.ShowDialog()



