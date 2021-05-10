
  
$global:form = $null

$global:progressBar = $null
$global:label1 = $null
$global:textBoxRootDir = $null
$global:buttonDialogRoot = $null
$global:label2 = $null
$global:textBoxOutputFile = $null
$global:buttonDialogCSV = $null
$global:checkBoxRunAtEnd = $null
$global:labelMessage = $null
$global:labelNote = $null
$global:buttonGenerate = $null
$global:buttonCloseOrCancel = $null
    
$global:batchProcess = $null


##################
### Form mount ###
##################
Function CreateGlobalVariables() {

    $global:form = $null

    $global:progressBar = $null
    $global:label1 = $null
    $global:textBoxRootDir = $null
    $global:buttonDialogRoot = $null
    $global:label2 = $null
    $global:textBoxOutputFile = $null
    $global:buttonDialogCSV = $null
    $global:checkBoxRunAtEnd = $null
    $global:labelMessage = $null
    $global:labelNote = $null
    $global:buttonGenerate = $null
    $global:buttonCloseOrCancel = $null
    
    $global:batchProcess = $null
	
}

Function MountForm() {
    #Create controls
    $global:form = New-Object system.Windows.Forms.Form
    
    $global:progressBar = New-Object System.Windows.Forms.ProgressBar 
    $global:label1 = New-Object System.Windows.Forms.Label 
    $global:textBoxRootDir = New-Object System.Windows.Forms.TextBox 
    $global:buttonDialogRoot = New-Object System.Windows.Forms.Button 
    $global:label2 = New-Object System.Windows.Forms.Label 
    $global:textBoxOutputFile = New-Object System.Windows.Forms.TextBox 
    $global:buttonDialogCSV = New-Object System.Windows.Forms.Button 
    $global:checkBoxRunAtEnd = New-Object System.Windows.Forms.CheckBox 
    $global:labelMessage = New-Object System.Windows.Forms.Label 
    $global:labelNote = New-Object System.Windows.Forms.Label 
    $global:buttonGenerate = New-Object System.Windows.Forms.Button 
    $global:buttonCloseOrCancel = New-Object System.Windows.Forms.Button 


    # 
    # progressBar
    # 
    $global:progressBar.Dock = [System.Windows.Forms.DockStyle]::Top
    $global:progressBar.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:progressBar.Location = New-Object System.Drawing.Point(0, 0)
    $global:progressBar.MarqueeAnimationSpeed = 10
    $global:progressBar.Name = "progressBar"
    $global:progressBar.Size = New-Object System.Drawing.Size(584, 13);
    $global:progressBar.TabIndex = 73;

            
    # 
    # label1
    # 
    $global:label1.Name = "label1"
    $global:label1.AutoSize = $global:true
    $global:label1.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:label1.Location = New-Object System.Drawing.Point(12, 34)
    $global:label1.Size = New-Object System.Drawing.Size(77, 13)
    $global:label1.TabIndex = 68
    $global:label1.Text = "Features Root:"

    # 
    # textBoxRootDir
    # 
    $global:textBoxRootDir.Location = New-Object System.Drawing.Point(115, 31)
    $global:textBoxRootDir.Name = "textBoxRootDir"
    $global:textBoxRootDir.Size = New-Object  System.Drawing.Size(428, 20)
    $global:textBoxRootDir.TabIndex = 64;
    $global:textBoxRootDir.Text = "\\nas-qnap\\projects\DOT.NET\CucumberFeaturesToCSV (public)\CucumberFeaturesToCSV\features" 
 
    # 
    # buttonDialogRoot
    # 
    $global:buttonDialogRoot.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:buttonDialogRoot.Location = New-Object System.Drawing.Point(549, 31);
    $global:buttonDialogRoot.Name = "buttonDialogRoot"
    $global:buttonDialogRoot.Size = New-Object System.Drawing.Size(24, 20)
    $global:buttonDialogRoot.TabIndex = 66
    $global:buttonDialogRoot.Text = "..."
    $global:buttonDialogRoot.UseVisualStyleBackColor = $global:true
    ##$global:buttonDialogRoot.Click += new System.EventHandler(this.buttonDialogRoot_Click);
    #$global:buttonDialogRoot.Add_Click( {buttonDialogRoot_Click} )       

    ##################################

    #
    #label2
    #
    $global:label2.AutoSize = $global:true
    $global:label2.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:label2.Location = New-Object System.Drawing.Point(11, 61)
    $global:label2.Name = "label2"
    $global:label2.Size = New-Object System.Drawing.Size(91, 13)
    $global:label2.TabIndex = 69
    $global:label2.Text = "Output File (CSV):"
    
    #
    # textBoxOutputFile
    # 
    $global:textBoxOutputFile.Location = New-Object System.Drawing.Point(114, 58);
    $global:textBoxOutputFile.Name = "textBoxOutputFile";
    $global:textBoxOutputFile.Size = New-Object System.Drawing.Size(428, 20);
    $global:textBoxOutputFile.TabIndex = 65;
    $global:textBoxOutputFile.Text = "test.csv";
            
    #
    # buttonDialogCSV
    # 
    $global:buttonDialogCSV.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:buttonDialogCSV.Location = New-Object System.Drawing.Point(548, 57)
    $global:buttonDialogCSV.Name = "buttonDialogCSV"
    $global:buttonDialogCSV.Size = New-Object System.Drawing.Size(24, 20)
    $global:buttonDialogCSV.TabIndex = 67
    $global:buttonDialogCSV.Text = "..."
    $global:buttonDialogCSV.UseVisualStyleBackColor = $global:true
    ##$global:buttonDialogCSV.Click += new System.EventHandler(this.buttonDialogCSV_Click);
    #$global:buttonDialogCSV.Add_Click( {buttonDialogCSV_Click} )   
        
    ###################################
            
    # 
    # checkBoxRunAtEnd
    # 
    $global:checkBoxRunAtEnd.AutoSize = $global:true
    $global:checkBoxRunAtEnd.Checked = $global:true
    $global:checkBoxRunAtEnd.CheckState = [System.Windows.Forms.CheckState]::Checked
    $global:checkBoxRunAtEnd.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:checkBoxRunAtEnd.Location = New-Object System.Drawing.Point(15, 91)
    $global:checkBoxRunAtEnd.Name = "checkBoxRunAtEnd"
    $global:checkBoxRunAtEnd.Size = New-Object System.Drawing.Size(205, 17)
    $global:checkBoxRunAtEnd.TabIndex = 74
    $global:checkBoxRunAtEnd.Text = "Open result file  after process finished."
    $global:checkBoxRunAtEnd.UseVisualStyleBackColor = $global:true
    
    #
    # labelMessage
    # 
    $global:labelMessage.AutoSize = $global:true;
    $global:labelMessage.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:labelMessage.Location = New-Object  System.Drawing.Point(12, 202)
    $global:labelMessage.Name = "labelMessage"
    $global:labelMessage.Size = New-Object  System.Drawing.Size(50, 13)
    $global:labelMessage.TabIndex = 71
    $global:labelMessage.Text = "Message"
            
            
    # 
    # labelNote
    # 
    $global:labelNote.AutoSize = $global:true
    $global:labelNote.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:labelNote.Location = New-Object  System.Drawing.Point(341, 160)
    $global:labelNote.Name = "labelNote"
    $global:labelNote.Size = New-Object  System.Drawing.Size(218, 13)
    $global:labelNote.TabIndex = 75
    $global:labelNote.Text = "Note: All char semicolon are replaced by <$global:>"     
            
    ################################################
            
    #
    # buttonGenerate
    # 
    $global:buttonGenerate.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:buttonGenerate.Location = New-Object System.Drawing.Point(344, 192)
    $global:buttonGenerate.Name = "buttonGenerate"
    $global:buttonGenerate.Size = New-Object System.Drawing.Size(105, 24)
    $global:buttonGenerate.TabIndex = 70
    $global:buttonGenerate.Text = "Generate"
    $global:buttonGenerate.UseVisualStyleBackColor = $global:true
    ##$global:buttonGenerate.Click += new System.EventHandler(this.buttonGenerate_Click)
    #$global:buttonGenerate.Add_Click({buttonGenerate_Click})
        
    # 
    # buttonCloseOrCancel
    # 
    $global:buttonCloseOrCancel.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
    $global:buttonCloseOrCancel.Location = New-Object System.Drawing.Point(464, 192)
    $global:buttonCloseOrCancel.Name = "buttonCloseOrCancel"
    $global:buttonCloseOrCancel.Size = New-Object System.Drawing.Size(105, 24)
    $global:buttonCloseOrCancel.TabIndex = 72
    $global:buttonCloseOrCancel.Text = "Close"
    $global:buttonCloseOrCancel.UseVisualStyleBackColor = $global:true
    ##$global:buttonCloseOrCancel.Click += new System.EventHandler(this.buttonCloseOrCancel_Click);
    #$global:buttonCloseOrCancel.Add_Click({buttonCloseOrCancel_Click})
    
    ##########################################################            
            
    # 
    # Form
    # 
    $global:form.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
    $global:form.ClientSize = New-Object System.Drawing.Size(584, 230)
    $global:form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle #enum
    #$global:form.Icon = ((System.Drawing.Icon)(resources.GetObject("$global:this.Icon")))
    $global:form.MaximizeBox = $global:false
    $global:form.Name = "FormCucumberFeaturesExport"
    $global:form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen #enum
    $global:form.Text = "Cucumber - Export features to CSV file"
    $global:form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font #enum
    $global:form.Cursor = [System.Windows.Forms.Cursors]::Default #enum

    # 
    # Add Controls to Form
    # 
    $global:form.Controls.Add($global:progressBar)

    $global:form.Controls.Add($global:label1)
    $global:form.Controls.Add($global:textBoxRootDir)
    $global:form.Controls.Add($global:buttonDialogRoot)

    $global:form.Controls.Add($global:label2)
    $global:form.Controls.Add($global:textBoxOutputFile)
    $global:form.Controls.Add($global:buttonDialogCSV)
            
    $global:form.Controls.Add($global:checkBoxRunAtEnd)
    $global:form.Controls.Add($global:labelMessage)
    $global:form.Controls.Add($global:labelNote)
    $global:form.Controls.Add($global:buttonGenerate)
    $global:form.Controls.Add($global:buttonCloseOrCancel)
            
    ##$global:Load += new System.EventHandler($global:FormCucumberFeaturesExport_Load)
    #$global:form.Add_Load({FormCucumberFeaturesExport_Load})            
    ##$global:FormClosed += new System.Windows.Forms.FormClosedEventHandler($global:FormCucumberFeaturesExport_FormClosed)
    #$global:form.Add_Closed( {FormCucumberFeaturesExport_FormClosed} )
	
}

Function ShowIt() {
    Write-Host $global:form.Name
    $global:form.ShowDialog()
}

