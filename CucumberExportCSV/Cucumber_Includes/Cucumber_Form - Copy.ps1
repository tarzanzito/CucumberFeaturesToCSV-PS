$CucumberForm = New-Module -ScriptBlock { 
  
    $form = $null

    $progressBar = $null
    $label1 = $null
    $textBoxRootDir = $null
    $buttonDialogRoot = $null
    $label2 = $null
    $textBoxOutputFile = $null
    $buttonDialogCSV = $null
    $checkBoxRunAtEnd = $null
    $labelMessage = $null
    $labelNote = $null
    $buttonGenerate = $null
    $buttonCloseOrCancel = $null
    
    $batchProcess = $null

	
    ### metodo 1####################################
    #$My_Button_Click = 
    #{
    #    [System.Windows.Forms.MessageBox]::Show("Hello World." , "My Dialog Box")
    #}

    ######################
    ### Form Functions ###
    ######################
    Function ValidateAllFields() {

        ########################### $invalidInput = $batchProcess.ValidateAllInputs()

        if ($invalidInput -eq 0) {
            return $true
        }
            
        #$message = "Content of Field " $invalidInput " is invalid."
        #MessageBox.Show(message, "Validation Fields", MessageBoxButtons.OK, MessageBoxIcon.Warning);

        #Ajust (Set Focus)
        switch ($invalidInput) {
            1 { $textBoxRootDir.Focus() }
            2 { $textBoxOutputFile.Focus() }
            default {$textBoxRootDir.Focus() }
        }

        return $false
    }

    Function EnableControls([bool] $enable) {
        # foreach (Control control in $Form.Controls)
        foreach ($control in $Form.Controls) {
            if ($control.GetType() -eq [System.Windows.Forms.Button]) {
                $control.Enabled = $enable
            }
                
                
            if ($control.GetType() -eq [System.Windows.Forms.TextBox]) {
                $control.Enabled = $enable
            }
        }

        #//buttonCloseOrCancel.Enabled = true;

        if ($enable) {
            $buttonCloseOrCancel.Text = "Close"
            $buttonCloseOrCancel.Tag = $null
            $Form.Cursor = Cursors.Default
            $buttonCloseOrCancel.Cursor = Cursors.Default
            $progressBar.Style = ProgressBarStyle.Continuous
            $progressBar.Visible = $false
            $labelMessage.Text = ""
        }
        else {
            #//buttonCloseOrCancel.Text = "Cancel";
            $buttonCloseOrCancel.Tag = 1;
            $Form.Cursor = Cursors.WaitCursor;
            $buttonCloseOrCancel.Cursor = Cursors.AppStarting;
            $progressBar.Style = ProgressBarStyle.Marquee;
            $progressBar.Style = ProgressBarStyle.Marquee;
            $progressBar.Visible = $true;
        }

    }

    ###################
    ### Form events ###
    ###################

    Function FormCucumberFeaturesExport_Load() {
        Write-Output "Form is Load."
            
        $textBoxRootDir.Text = "a";
        $textBoxOutputFile.Text = "b";

        $labelMessage.Text = "";
        $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous;
        $progressBar.Visible = $false;
    }

    Function FormCucumberFeaturesExport_FormClosed() {
        Write-Output "Form is Closed."
    }

    Function buttonDialogRoot_Click() {
        #$path = [System.Windows.Forms.Application]::ExecutablePath
        #$path = [System.Environment.SpecialFolder]::MyDocuments  --> error
        $path = [System.Environment]::GetFolderPath("MyDocuments")
        $dirName = [System.IO.Path]::GetDirectoryName($path)
    
        if ([String]::IsNullOrEmpty($textBoxRootDir.Text) -ne $true) {
            $dirName = [System.IO.Path]::GetDirectoryName($textBoxRootDir.Text);
        }

        $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        #folderBrowserDialog.RootFolder = Environment.SpecialFolder.MyComputer;
        $folderBrowserDialog.SelectedPath = $dirName;
        $folderBrowserDialog.ShowNewFolderButton = $true;

        #System.Windows.Forms.DialogResult result = folderBrowserDialog.ShowDialog();
        $result = $folderBrowserDialog.ShowDialog();
        if ($result -eq [DialogResult]::OK) {
            $textBoxRootDir.Text = $folderBrowserDialog.SelectedPath;
        }
        $textBoxRootDir.Focus();
    }

    Function buttonDialogCSV_Click() {
        #$path = [System.Windows.Forms.Application]::ExecutablePath
        $path = [System.Environment.SpecialFolder]::MyDocuments
        $dirName = [System.IO.Path]::GetDirectoryName($path)

        if ([String]::IsNullOrEmpty($textBoxRootDir.Text) -ne $true) {
            $dirName = [System.IO.Path]::GetDirectoryName($textBoxRootDir.Text);
        }

        $saveFileDialog1 = New-Object System.Windows.Forms.SaveFileDialog

        $saveFileDialog1.InitialDirectory = $dirName
        $saveFileDialog1.Title = "Save CSV File"
        $saveFileDialog1.CheckFileExists = $false
        $saveFileDialog1.CheckPathExists = $true
        $saveFileDialog1.DefaultExt = ".csv"
        $saveFileDialog1.Filter = "CSV files |(*.csv)"
        $saveFileDialog1.FilterIndex = 2
        $saveFileDialog1.RestoreDirectory = $true

        if ($saveFileDialog1.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $textBoxOutputFile.Text = $saveFileDialog1.FileName
        }
    
        $textBoxOutputFile.Focus()
    }

    Function buttonGenerate_Click() {
        #[System.Windows.Forms.MessageBox]::Show("Hello World222." , "My Dialog Box")
    
        $progressBar.MarqueeAnimationSpeed = 10
        $progressBar.Minimum = 0
        $progressBar.Maximum = 100
        $progressBar.MarqueeAnimationSpeed = 10
        $progressBar.Value = 0

        if (($textBoxOutputFile.Text.Length -gt 0) -and (!textBoxOutputFile.Text.ToLower.EndsWith(".csv"))) {
            $textBoxOutputFile.Text += ".csv";
        }
            
        ###################if ($batchProcess -eq $null)
        ###################    $batchProcess = New-Object BatchProcess.GenerateExport($textBoxRootDir.Text, $textBoxOutputFile.Text, $false);

        ###################if (!ValidateAllFields)
        ###################    return;

        EnableControls($false)
                        
        ###################$batchProcess.Start();
        ####################$batchProcess.Start(_handlerBatchMessage)

        EnableControls($true)

        if ($checkBoxRunAtEnd.Checked -eq $true) {
            try {
                System.Diagnostics.Process.Start($textBoxOutputFile.Text);
            }
            catch {
                break
            }
        }

        $Form.Activate();
        # MessageBox.Show("Process completed.", "Batch Process", MessageBoxButtons.OK, MessageBoxIcon.Information);
    
      
    
    
    
    }

    Function buttonCloseOrCancel_Click() {
        #[System.Windows.Forms.MessageBox]::Show("Hello World222." , "My Dialog Box")
        if ($buttonCloseOrCancel.Tag -eq $null) {
            $Form.Close()
        }
    }

    ##################
    ### Form mount ###
    ##################
    Function CreateGlobalVariables() {
        $form = $null

        $progressBar = $null
        $label1 = $null
        $textBoxRootDir = $null
        $buttonDialogRoot = $null
        $label2 = $null
        $textBoxOutputFile = $null
        $buttonDialogCSV = $null
        $checkBoxRunAtEnd = $null
        $labelMessage = $null
        $labelNote = $null
        $buttonGenerate = $null
        $buttonCloseOrCancel = $null
    
        $batchProcess = $null
    }

    Function MountForm() {
        #Create controls
        $form = New-Object system.Windows.Forms.Form
    
        $progressBar = New-Object System.Windows.Forms.ProgressBar 
        $label1 = New-Object System.Windows.Forms.Label 
        $textBoxRootDir = New-Object System.Windows.Forms.TextBox 
        $buttonDialogRoot = New-Object System.Windows.Forms.Button 
        $label2 = New-Object System.Windows.Forms.Label 
        $textBoxOutputFile = New-Object System.Windows.Forms.TextBox 
        $buttonDialogCSV = New-Object System.Windows.Forms.Button 
        $checkBoxRunAtEnd = New-Object System.Windows.Forms.CheckBox 
        $labelMessage = New-Object System.Windows.Forms.Label 
        $labelNote = New-Object System.Windows.Forms.Label 
        $buttonGenerate = New-Object System.Windows.Forms.Button 
        $buttonCloseOrCancel = New-Object System.Windows.Forms.Button 


        # 
        # progressBar
        # 
        $progressBar.Dock = [System.Windows.Forms.DockStyle]::Top
        $progressBar.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $progressBar.Location = New-Object System.Drawing.Point(0, 0)
        $progressBar.MarqueeAnimationSpeed = 10
        $progressBar.Name = "progressBar"
        $progressBar.Size = New-Object System.Drawing.Size(584, 13);
        $progressBar.TabIndex = 73;

        Write-Host $global:progressBar.Name
        Write-Host $progressBar.Name

            
        # 
        # label1
        # 
        $label1.Name = "label1"
        $label1.AutoSize = $true
        $label1.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $label1.Location = New-Object System.Drawing.Point(12, 34)
        $label1.Size = New-Object System.Drawing.Size(77, 13)
        $label1.TabIndex = 68
        $label1.Text = "Features Root:"

        # 
        # textBoxRootDir
        # 
        $textBoxRootDir.Location = New-Object System.Drawing.Point(115, 31)
        $textBoxRootDir.Name = "textBoxRootDir"
        $textBoxRootDir.Size = New-Object  System.Drawing.Size(428, 20)
        $textBoxRootDir.TabIndex = 64;
        $textBoxRootDir.Text = "\\nas-qnap\\projects\DOT.NET\CucumberFeaturesToCSV (public)\CucumberFeaturesToCSV\features" 
 
        # 
        # buttonDialogRoot
        # 
        $buttonDialogRoot.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $buttonDialogRoot.Location = New-Object System.Drawing.Point(549, 31);
        $buttonDialogRoot.Name = "buttonDialogRoot"
        $buttonDialogRoot.Size = New-Object System.Drawing.Size(24, 20)
        $buttonDialogRoot.TabIndex = 66
        $buttonDialogRoot.Text = "..."
        $buttonDialogRoot.UseVisualStyleBackColor = $true
        #$buttonDialogRoot.Click += new System.EventHandler(this.buttonDialogRoot_Click);
        $buttonDialogRoot.Add_Click( {buttonDialogRoot_Click} )       

        ##################################

        #
        #label2
        #
        $label2.AutoSize = $true
        $label2.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $label2.Location = New-Object System.Drawing.Point(11, 61)
        $label2.Name = "label2"
        $label2.Size = New-Object System.Drawing.Size(91, 13)
        $label2.TabIndex = 69
        $label2.Text = "Output File (CSV):"
    
        #
        # textBoxOutputFile
        # 
        $textBoxOutputFile.Location = New-Object System.Drawing.Point(114, 58);
        $textBoxOutputFile.Name = "textBoxOutputFile";
        $textBoxOutputFile.Size = New-Object System.Drawing.Size(428, 20);
        $textBoxOutputFile.TabIndex = 65;
        $textBoxOutputFile.Text = "test.csv";
            
        #
        # buttonDialogCSV
        # 
        $buttonDialogCSV.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $buttonDialogCSV.Location = New-Object System.Drawing.Point(548, 57)
        $buttonDialogCSV.Name = "buttonDialogCSV"
        $buttonDialogCSV.Size = New-Object System.Drawing.Size(24, 20)
        $buttonDialogCSV.TabIndex = 67
        $buttonDialogCSV.Text = "..."
        $buttonDialogCSV.UseVisualStyleBackColor = $true
        #$buttonDialogCSV.Click += new System.EventHandler(this.buttonDialogCSV_Click);
        $buttonDialogCSV.Add_Click( {buttonDialogCSV_Click} )   
        
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
        $checkBoxRunAtEnd.TabIndex = 74
        $checkBoxRunAtEnd.Text = "Open result file  after process finished."
        $checkBoxRunAtEnd.UseVisualStyleBackColor = $true
    
        #
        # labelMessage
        # 
        $labelMessage.AutoSize = $true;
        $labelMessage.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $labelMessage.Location = New-Object  System.Drawing.Point(12, 202)
        $labelMessage.Name = "labelMessage"
        $labelMessage.Size = New-Object  System.Drawing.Size(50, 13)
        $labelMessage.TabIndex = 71
        $labelMessage.Text = "Message"
            
            
        # 
        # labelNote
        # 
        $labelNote.AutoSize = $true
        $labelNote.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $labelNote.Location = New-Object  System.Drawing.Point(341, 160)
        $labelNote.Name = "labelNote"
        $labelNote.Size = New-Object  System.Drawing.Size(218, 13)
        $labelNote.TabIndex = 75
        $labelNote.Text = "Note: All char semicolon are replaced by <$>"     
            
        ################################################
            
        #
        # buttonGenerate
        # 
        $buttonGenerate.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $buttonGenerate.Location = New-Object System.Drawing.Point(344, 192)
        $buttonGenerate.Name = "buttonGenerate"
        $buttonGenerate.Size = New-Object System.Drawing.Size(105, 24)
        $buttonGenerate.TabIndex = 70
        $buttonGenerate.Text = "Generate"
        $buttonGenerate.UseVisualStyleBackColor = $true
        #$buttonGenerate.Click += new System.EventHandler(this.buttonGenerate_Click)
        $buttonGenerate.Add_Click( {buttonGenerate_Click})
        
        # 
        # buttonCloseOrCancel
        # 
        $buttonCloseOrCancel.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $buttonCloseOrCancel.Location = New-Object System.Drawing.Point(464, 192)
        $buttonCloseOrCancel.Name = "buttonCloseOrCancel"
        $buttonCloseOrCancel.Size = New-Object System.Drawing.Size(105, 24)
        $buttonCloseOrCancel.TabIndex = 72
        $buttonCloseOrCancel.Text = "Close"
        $buttonCloseOrCancel.UseVisualStyleBackColor = $true
        #$buttonCloseOrCancel.Click += new System.EventHandler(this.buttonCloseOrCancel_Click);
        $buttonCloseOrCancel.Add_Click( {buttonCloseOrCancel_Click})
    
        ##########################################################            
            
        # 
        # Form
        # 
        $form.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
        $form.ClientSize = New-Object System.Drawing.Size(584, 230)
        $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle #enum
        #$form.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")))
        $form.MaximizeBox = $false
        $form.Name = "FormCucumberFeaturesExport"
        $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen #enum
        $form.Text = "Cucumber - Export features to CSV file"
        $form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font #enum
        $form.Cursor = [System.Windows.Forms.Cursors]::Default #enum

        # 
        # Add Controls to Form
        # 
        $form.Controls.Add($progressBar)

        $form.Controls.Add($label1)
        $form.Controls.Add($textBoxRootDir)
        $form.Controls.Add($buttonDialogRoot)

        $form.Controls.Add($label2)
        $form.Controls.Add($textBoxOutputFile)
        $form.Controls.Add($buttonDialogCSV)
            
        $form.Controls.Add($checkBoxRunAtEnd)
        $form.Controls.Add($labelMessage)
        $form.Controls.Add($labelNote)
        $form.Controls.Add($buttonGenerate)
        $form.Controls.Add($buttonCloseOrCancel)
            
        #$Load += new System.EventHandler($FormCucumberFeaturesExport_Load)
        $form.Add_Load( {FormCucumberFeaturesExport_Load})            
        #$FormClosed += new System.Windows.Forms.FormClosedEventHandler($FormCucumberFeaturesExport_FormClosed)
        $form.Add_Closed( {FormCucumberFeaturesExport_FormClosed} )
    }
























                
    Export-ModuleMember -Variable * -Function *                
    
}
# -asCustomObject -name GreetingModule