$script:CucumberForm = New-Module -ScriptBlock { 
    
    #####################
    # $script:variables #
    #####################
    
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
    $buttonClose = $null

    ########################
    ### Public Functions ###
    ########################

    Function MountForm() {
   
        #Create controls
        $script:form = New-Object system.Windows.Forms.Form
    
        $script:progressBar = New-Object System.Windows.Forms.ProgressBar 
        $script:label1 = New-Object System.Windows.Forms.Label 
        $script:textBoxRootDir = New-Object System.Windows.Forms.TextBox 
        $script:buttonDialogRoot = New-Object System.Windows.Forms.Button 
        $script:label2 = New-Object System.Windows.Forms.Label 
        $script:textBoxOutputFile = New-Object System.Windows.Forms.TextBox 
        $script:buttonDialogCSV = New-Object System.Windows.Forms.Button 
        $script:checkBoxRunAtEnd = New-Object System.Windows.Forms.CheckBox 
        $script:labelMessage = New-Object System.Windows.Forms.Label 
        $script:labelNote = New-Object System.Windows.Forms.Label 
        $script:buttonGenerate = New-Object System.Windows.Forms.Button 
        $script:buttonClose = New-Object System.Windows.Forms.Button 

        # 
        # progressBar
        # 
        $script:progressBar.Dock = [System.Windows.Forms.DockStyle]::Top
        $script:progressBar.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:progressBar.Location = New-Object System.Drawing.Point(0, 0)
        $script:progressBar.MarqueeAnimationSpeed = 10
        $script:progressBar.Name = "progressBar"
        $script:progressBar.Size = New-Object System.Drawing.Size(584, 13);
        $script:progressBar.TabIndex = 73;

        # 
        # label1
        # 
        $script:label1.Name = "label1"
        $script:label1.AutoSize = $script:true
        $script:label1.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:label1.Location = New-Object System.Drawing.Point(12, 34)
        $script:label1.Size = New-Object System.Drawing.Size(77, 13)
        $script:label1.TabIndex = 68
        $script:label1.Text = "Features Root:"

        # 
        # textBoxRootDir
        # 
        $script:textBoxRootDir.Location = New-Object System.Drawing.Point(115, 31)
        $script:textBoxRootDir.Name = "textBoxRootDir"
        $script:textBoxRootDir.Size = New-Object  System.Drawing.Size(428, 20)
        $script:textBoxRootDir.TabIndex = 64;
        $script:textBoxRootDir.Text = $HOME
        # 
        # buttonDialogRoot
        # 
        $script:buttonDialogRoot.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:buttonDialogRoot.Location = New-Object System.Drawing.Point(549, 31);
        $script:buttonDialogRoot.Name = "buttonDialogRoot"
        $script:buttonDialogRoot.Size = New-Object System.Drawing.Size(24, 20)
        $script:buttonDialogRoot.TabIndex = 66
        $script:buttonDialogRoot.Text = "..."
        $script:buttonDialogRoot.UseVisualStyleBackColor = $true
        #$script:buttonDialogRoot.Click += new System.EventHandler(this.buttonDialogRoot_Click);
        $script:buttonDialogRoot.Add_Click( {buttonDialogRoot_Click} )       

        ##################################

        #
        #label2
        #
        $script:label2.AutoSize = $script:true
        $script:label2.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:label2.Location = New-Object System.Drawing.Point(11, 61)
        $script:label2.Name = "label2"
        $script:label2.Size = New-Object System.Drawing.Size(91, 13)
        $script:label2.TabIndex = 69
        $script:label2.Text = "Output File (CSV):"
    
        #
        # textBoxOutputFile
        # 
        $script:textBoxOutputFile.Location = New-Object System.Drawing.Point(114, 58);
        $script:textBoxOutputFile.Name = "textBoxOutputFile";
        $script:textBoxOutputFile.Size = New-Object System.Drawing.Size(428, 20);
        $script:textBoxOutputFile.TabIndex = 65;
        $script:textBoxOutputFile.Text = "test.csv";
            
        #
        # buttonDialogCSV
        # 
        $script:buttonDialogCSV.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:buttonDialogCSV.Location = New-Object System.Drawing.Point(548, 57)
        $script:buttonDialogCSV.Name = "buttonDialogCSV"
        $script:buttonDialogCSV.Size = New-Object System.Drawing.Size(24, 20)
        $script:buttonDialogCSV.TabIndex = 67
        $script:buttonDialogCSV.Text = "..."
        $script:buttonDialogCSV.UseVisualStyleBackColor = $true
        #$script:buttonDialogCSV.Click += new System.EventHandler(this.buttonDialogCSV_Click);
        $script:buttonDialogCSV.Add_Click( {buttonDialogCSV_Click} )   
        
        ###################################
            
        # 
        # checkBoxRunAtEnd
        # 
        $script:checkBoxRunAtEnd.AutoSize = $true
        $script:checkBoxRunAtEnd.Checked = $true
        $script:checkBoxRunAtEnd.CheckState = [System.Windows.Forms.CheckState]::Checked
        $script:checkBoxRunAtEnd.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:checkBoxRunAtEnd.Location = New-Object System.Drawing.Point(15, 91)
        $script:checkBoxRunAtEnd.Name = "checkBoxRunAtEnd"
        $script:checkBoxRunAtEnd.Size = New-Object System.Drawing.Size(205, 17)
        $script:checkBoxRunAtEnd.TabIndex = 74
        $script:checkBoxRunAtEnd.Text = "Open result file  after process finished."
        $script:checkBoxRunAtEnd.UseVisualStyleBackColor = $true
    
        #
        # labelMessage
        # 
        $script:labelMessage.AutoSize = $true;
        $script:labelMessage.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:labelMessage.Location = New-Object  System.Drawing.Point(12, 202)
        $script:labelMessage.Name = "labelMessage"
        $script:labelMessage.Size = New-Object  System.Drawing.Size(50, 13)
        $script:labelMessage.TabIndex = 71
        $script:labelMessage.Text = "Message"
            
        # 
        # labelNote
        # 
        $script:labelNote.AutoSize = $true
        $script:labelNote.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:labelNote.Location = New-Object  System.Drawing.Point(341, 160)
        $script:labelNote.Name = "labelNote"
        $script:labelNote.Size = New-Object  System.Drawing.Size(218, 13)
        $script:labelNote.TabIndex = 75
        $script:labelNote.Text = "Note: All char semicolon are replaced by ''"     
            
        ################################################
            
        #
        # buttonGenerate
        # 
        $script:buttonGenerate.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:buttonGenerate.Location = New-Object System.Drawing.Point(344, 192)
        $script:buttonGenerate.Name = "buttonGenerate"
        $script:buttonGenerate.Size = New-Object System.Drawing.Size(105, 24)
        $script:buttonGenerate.TabIndex = 70
        $script:buttonGenerate.Text = "Generate"
        $script:buttonGenerate.UseVisualStyleBackColor = $true
        #$script:buttonGenerate.Click += new System.EventHandler(this.buttonGenerate_Click)
        $script:buttonGenerate.Add_Click( {buttonGenerate_Click})
        
        # 
        # buttonClose
        # 
        $script:buttonClose.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
        $script:buttonClose.Location = New-Object System.Drawing.Point(464, 192)
        $script:buttonClose.Name = "buttonClose"
        $script:buttonClose.Size = New-Object System.Drawing.Size(105, 24)
        $script:buttonClose.TabIndex = 72
        $script:buttonClose.Text = "Close"
        $script:buttonClose.UseVisualStyleBackColor = $true
        #$script:buttonClose.Click += new System.EventHandler(this.buttonCloseOrCancel_Click);
        $script:buttonClose.Add_Click( {buttonClose_Click})
    
        ##########################################################            
            
        # 
        # Form
        # 
        $script:form.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
        $script:form.ClientSize = New-Object System.Drawing.Size(584, 230)
        $script:form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle #enum
        #$script:form.Icon = ((System.Drawing.Icon)(resources.GetObject("$script:this.Icon")))
        $script:form.MaximizeBox = $false
        $script:form.Name = "FormCucumberFeaturesExport"
        $script:form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen #enum
        $script:form.Text = "Cucumber - Export features to CSV file"
        $script:form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font #enum
        $script:form.Cursor = [System.Windows.Forms.Cursors]::Default #enum

        # 
        # Add Controls to Form
        # 
        $script:form.Controls.Add($script:progressBar)

        $script:form.Controls.Add($script:label1)
        $script:form.Controls.Add($script:textBoxRootDir)
        $script:form.Controls.Add($script:buttonDialogRoot)

        $script:form.Controls.Add($script:label2)
        $script:form.Controls.Add($script:textBoxOutputFile)
        $script:form.Controls.Add($script:buttonDialogCSV)
            
        $script:form.Controls.Add($script:checkBoxRunAtEnd)
        $script:form.Controls.Add($script:labelMessage)
        $script:form.Controls.Add($script:labelNote)
        $script:form.Controls.Add($script:buttonGenerate)
        $script:form.Controls.Add($script:buttonClose)
            
        ##$script:Load += new System.EventHandler(FormCucumberFeaturesExport_Load)
        $script:form.Add_Load( {FormCucumberFeaturesExport_Load})            
        ##$script:FormClosed += new System.Windows.Forms.FormClosedEventHandler(FormCucumberFeaturesExport_FormClosed)
        $script:form.Add_Closed( {FormCucumberFeaturesExport_FormClosed} )
	
    }

    Function ShowDialog() {
        $script:form.ShowDialog()
    }

    #########################
    ### Private Functions ###
    #########################

    Function ValidateAllFields() {

        $result = $CucumberProcess.ValidateParameters()
        if ($result -eq "OK") {
            return $true
        }

        $message = "Content of Field: $invalidInput is invalid."
        [System.Windows.FormsMessageBox]::Show($message, "Validation Fields", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning);

        #Ajust (Set Focus)
        switch ($invalidInput) {
            1 { $script:textBoxRootDir.Focus() }
            2 { $script:textBoxOutputFile.Focus() }
            default {$script:textBoxRootDir.Focus() }
        }

        return $false
    }

    Function EnableControls([bool] $enable) {
        foreach ($control in $script:form.Controls) {
            if ($control.GetType() -eq [System.Windows.Forms.Button]) {
                $control.Enabled = $enable
            }
                
            if ($control.GetType() -eq [System.Windows.Forms.TextBox]) {
                $control.Enabled = $enable
            }
                
            if ($control.GetType() -eq [System.Windows.Forms.CheckBox]) {
                $control.Enabled = $enable
            }
        }

        #//buttonCloseOrCancel.Enabled = true;

        if ($enable) {
            $script:form.Cursor = [System.Windows.Forms.Cursors]::Default
            #$script:buttonClose.Cursor = Cursors.Default
            $script:progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
            $script:progressBar.Visible = $false
            $script:labelMessage.Text = ""
        }
        else {
            $script:form.Cursor = [System.Windows.Forms.Cursors]::WaitCursor;
            #$script:buttonClose.Cursor = Cursors.AppStarting;
            $script:progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee;
            $script:progressBar.Visible = $true;
        }

    }

    ###########$$$#############
    ### Private Foem Events ###
    ###########################

    Function FormCucumberFeaturesExport_Load() {
        $script:textBoxRootDir.Text = ""
        $script:textBoxOutputFile.Text = ""

        $script:labelMessage.Text = ""
        $script:progressBar.Visible = $false
            
        $script:progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
        $script:progressBar.MarqueeAnimationSpeed = 10
        $script:progressBar.Minimum = 0
        $script:progressBar.Maximum = 100
        $script:progressBar.MarqueeAnimationSpeed = 10
        $script:progressBar.Value = 0
    }

    Function FormCucumberFeaturesExport_FormClosed() {
        Write-Output "Form is Closed."
    }

    Function buttonDialogRoot_Click() {
        #$path = [System.Environment]::GetFolderPath("MyDocuments")
        #$dirName = [System.IO.Path]::GetDirectoryName($path)
        $dirName = $HOME
    
        if ([String]::IsNullOrEmpty($script:textBoxRootDir.Text) -ne $true) {
            $dirName = [System.IO.Path]::GetDirectoryName($script:textBoxRootDir.Text);
        }

        $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        #folderBrowserDialog.RootFolder = Environment.SpecialFolder.MyComputer;
        $folderBrowserDialog.SelectedPath = $dirName;
        $folderBrowserDialog.ShowNewFolderButton = $true;

        #System.Windows.Forms.DialogResult result = folderBrowserDialog.ShowDialog();
        $result = $folderBrowserDialog.ShowDialog();

        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {                                     
            $script:textBoxRootDir.Text = $folderBrowserDialog.SelectedPath;
        }
    
        $script:textBoxRootDir.Focus();
    }

    Function buttonDialogCSV_Click() {
        #$path = [System.Windows.Forms.Application]::ExecutablePath
        $path = [System.Environment.SpecialFolder]::MyDocuments
        $dirName = [System.IO.Path]::GetDirectoryName($path)

        if ([String]::IsNullOrEmpty($script:textBoxRootDir.Text) -ne $true) {
            $dirName = [System.IO.Path]::GetDirectoryName($script:textBoxRootDir.Text);
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

        $result = $saveFileDialog1.ShowDialog()
        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            $script:textBoxOutputFile.Text = $saveFileDialog1.FileName
        }
    
        $script:textBoxOutputFile.Focus()
    }

    Function buttonGenerate_Click() {
        $script:progressBar.Value = 0

        $script:textBoxRootDir.Text = $script:textBoxRootDir.Text.Trim()
        $script:textBoxOutputFile.Text = $script:textBoxOutputFile.Text.Trim()
            
        #add extension
        if (($script:textBoxOutputFile.Text.Length -gt 0) -and (-not $script:textBoxOutputFile.Text.ToLower().EndsWith(".csv"))) {
            $script:textBoxOutputFile.Text += ".csv";
        }

        #set parameters            
        $CucumberProcess.SetParameters($script:textBoxRootDir.Text, $script:textBoxOutputFile.Text)
            
        #validate inputs
        $result = ValidateAllFields
        if (-not $result) {
            return
        }
            
        EnableControls($false)
                        
        #run
        $CucumberProcess.Start();

        EnableControls($true)

        if ($script:checkBoxRunAtEnd.Checked -eq $true) {
            try {
                #System.Diagnostics.Process.Start($script:textBoxOutputFile.Text);
            }
            catch {
                break
            }
        }

        $script:Form.Activate();
        # MessageBox.Show("Process completed.", "Batch Process", MessageBoxButtons.OK, MessageBoxIcon.Information);
        $message = "Xpto"
        [System.Windows.Forms.MessageBox]::Show($message, "Batch Process", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Info)
        #[System.Windows.Forms.MessageBox]::Show($message, "Batch Process", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    
    
    
    }

    Function buttonClose_Click() {
        $script:form.Close()
    }
                
    #Export-ModuleMember -Variable * -Function *                
    Export-ModuleMember -Function MountForm, ShowDialog               
    
} -asCustomObject
# -asCustomObject -name GreetingModule