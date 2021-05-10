$CucumberProcess = New-Module -ScriptBlock {

    $inputRootFolder = ""
    $outputFile = ""
 
    $processCount = 0
    $processCountFiles = 0
    $processCountLines = 0
    $spacer = ';'
    #$hasConsole = $false
    #$outputFileErrors = ""
    $list = @()

    $featureInfo = @{
        TagsFeature      = $null
        Feature          = $null
        Background       = $null
        TagsScenario     = $null
        Scenario         = $null
        Scenario_outline = $null
        Examples         = $null
        Given            = $null
        When             = $null
        Then             = $null
        And              = $null
        But              = $null
    }

    ########################
    ### Public Functions ###
    ########################
				
    Function SetParameters([string] $inputRootFolder, [string] $outputFile) {
        $script:inputRootFolder = $inputRootFolder.Trim()
        $script:outputFile = $outputFile.Trim()
    }
        
    Function ValidateParameters() {
        if ($script:inputRootFolder -eq "") {
            return "RootFolder";
        }
		
        #if (!System.IO.Directory.Exists($script:inputRootFolder))
        if (-not (Test-Path $script:inputRootFolder -PathType Container)) {
            return "RootFolder";
        }
		
        if (($script:outputFile -eq "") -or (-not $script:outputFile.ToLower().EndsWith(".csv"))) {
            return "OutputFile";
        }
		
        return "OK";
    }

    Function Start() {
        Processing
    }

    #########################
    ### Private Functions ###
    #########################

    Function Processing() {
        MountListFiles
        SortList
        ProcessListFiles
    }

    Function MountListFiles() {
        $script:list = Get-ChildItem -Path $script:inputRootFolder �Recurse -Filter *.feature | Select FullName #| sort FullName
    }

    Function SortList() {
        $script:list = $script:list | sort FullName
    }

    Function ProcessListFiles() {
        $script:processCount = 0;
        $script:processCountFiles = 0;
        $script:processCountLines = 0;

        Out-File $script:outputFile -Encoding "UTF8" -Force
       
        #language: Portuguese
        $line = "NumLinha" + $script:spacer #LineNum
        $line += "Func_Tags" + $script:spacer #Tags Feature
        $line += "Funcionalidade" + $script:spacer #Feature
        $line += "Cenario_Tags" + $script:spacer #Tags Scenario  
        $line += "Tipo_Cen�rio" + $script:spacer #Scenario Type
        $line += "Cen�rio" + $script:spacer #Scenario 
        $line += "Codigo" + $script:spacer #Code
        $line += "Frase" #phrase
                
        Add-Content -path $script:outputFile -value $line -Encoding "UTF8" -Force

        foreach ($element in $script:list) {
            ProcessSingleFile($element.FullName)
        }
       
    }
    
    function ProcessSingleFile($fileName) {
        ClearFeatureInfo
            
        $content = Get-Content -path $fileName -Encoding "UTF8" -Force
          
        foreach ($line in $content) {
            ProcessSingleLine($line)
        }
            
        $script:processCountFiles++
        #ReportProgress("Process File:" + _processCountFiles + ":" + _processCount);
    }
    
    function ProcessSingleLine($line) {
        $script:processCountLines++
          
        $temp = $line.Replace("\t", "").Trim();

        if (($temp.StartsWith("#") -or $temp.StartsWith("|") -or $temp.Length -eq 0)) {
            return
        }

        if ($temp.StartsWith("@")) {
            if ($script:featureInfo.Feature -eq $null) {
                $script:featureInfo.TagsFeature = $temp
            }
            else {
                $script:featureInfo.TagsScenario = $temp
            }

            return
        }


        if ($temp.StartsWith("Funcionalidade:") -or $temp.StartsWith("Caracter�stica:") -or $temp.StartsWith("Caracteristica:")) {
            $script:featureInfo.Feature = $temp
            return
        }

        if ($temp.StartsWith("Contexto:") -or $temp.StartsWith("Cen�rio de Fundo:") -or $temp.StartsWith("Cenario de Fundo:") -or $temp.StartsWith("Fundo:")) {
            $script:featureInfo.Background = $temp
            $script:featureInfo.Scenario = $null
            $script:featureInfo.Scenario_outline = $null
            return
        }

        if ($temp.StartsWith("Cen�rio:") -or $temp.StartsWith("Cenario:")) {
            $script:featureInfo.Background = $null
            $script:featureInfo.Scenario = $temp
            $script:featureInfo.Scenario_outline = $null
            return
        }

        if ($temp.StartsWith("Esquema do Cen�rio:") -or $temp.StartsWith("Esquema do Cenario:") -or $temp.StartsWith("Delinea��o do Cen�rio") -or $temp.StartsWith("Delineacao do Cenario")) {
            $script:featureInfo.Background = $null
            $script:featureInfo.Scenario = $null
            $script:featureInfo.Scenario_outline = $temp
            return
        }

        if ($temp.StartsWith("Exemplos:") -or $temp.StartsWith("Cen�rios:") -or $temp.StartsWith("Cenarios:")) {
            $script:featureInfo.Examples = $temp
            return
        }

        if ($temp.StartsWith("Dado ") -or $temp.StartsWith("Dada ") -or $temp.StartsWith("Dados ") -or $temp.StartsWith("Dadas ")) {
            $script:featureInfo.Given = $temp
        }

        if ($temp.StartsWith("Quando ")) {
            $script:featureInfo.When = $temp
        }

        if ($temp.StartsWith("Ent�o ") -or $temp.StartsWith("Entao ")) {
            $script:featureInfo.Then = $temp
        }

        if ($temp.StartsWith("E ")) {
            $script:featureInfo.And = $temp
        }

        if ($temp.StartsWith("Mas ")) {
            $script:featureInfo.But = $temp
        }

        #write final line
        if (($script:featureInfo.Background -ne $null) -or ($script:featureInfo.Scenario -ne $null) -or ($script:featureInfo.Scenario_outline -ne $null)) {
            $pos = $temp.IndexOf(" ")
            if ($pos -gt 0) {
                #_processCountLines++;
                #System.Threading.Thread.Sleep(5);

                #ini
                $keyWord = $temp.Substring(0, $pos);
                $phrase = $temp.Substring($pos).Trim();

                $finalLine = $script:processCountLines.ToString() + $spacer
                $finalLine += $script:featureInfo.TagsFeature + $spacer
                $finalLine += $script:featureInfo.Feature + $spacer
                $finalLine += $script:featureInfo.TagsScenario + $spacer

                # three options for same colum n
                if ($script:featureInfo.Background -ne $null) {
                    $finalLine += "Fundo" + $spacer
                    $finalLine += $script:featureInfo.Background + $spacer
                }

                if ($script:featureInfo.Scenario -ne $null) {
                    $finalLine += "Cenario" + $spacer
                    $finalLine += $script:featureInfo.Scenario + $spacer
                }

                if ($script:featureInfo.Scenario_outline -ne $null) {
                    $finalLine += "Esquema de Cenario" + $spacer
                    $finalLine += $script:featureInfo.Scenario_outline + $spacer
                }

                $finalLine += $keyWord, $true;
                $finalLine += $phrase

                Add-Content -path $script:outputFile -value $finalLine -Encoding "UTF8" -Force
            }
        }
	 
    }

    function ClearFeatureInfo() {
        $script:featureInfo.TagsFeature = $null
        $script:featureInfo.Feature = $null
        $script:featureInfo.Background = $null
        $script:featureInfo.TagsScenario = $null
        $script:featureInfo.Scenario = $null
        $script:featureInfo.Scenario_outline = $null
        $script:featureInfo.Examples = $null
        $script:featureInfo.Given = $null
        $script:featureInfo.When = $null
        $script:featureInfo.Then = $null
        $script:featureInfo.And = $null
        $script:featureInfo.But = $null
    }
    

    #Export-ModuleMember -Variable * -Function *                
    Export-ModuleMember -Function SetParameters, ValidateParameters, Start
    
} -asCustomObject
# -asCustomObject -name GreetingModule



