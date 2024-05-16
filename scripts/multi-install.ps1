function InstallChrome {
    $uri = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    $path = "$temp\ChromeStandaloneSetup64.exe" 
    Invoke-WebRequest -Uri $uri -OutFile $path
    & $path /install
    Remove-Item "$env:TEMP\ChromeStandaloneSetup64.exe"
}
function InstallFirefox {
    $firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=fr"
    $destination = "$env:TEMP\firefox_installer.exe"
    Invoke-WebRequest -Uri $firefoxUrl -OutFile $destination
    Start-Process -FilePath "$env:TEMP\firefox_installer.exe" -ArgumentList "/S" -Wait
    Remove-Item "$env:TEMP\firefox_installer.exe"
}

    # Telecharger et definir le logo comme icone
    $LogoUrl = "https://dl.poupli.net/logo-tools.png"
    $LogoPath = "C:\Windows\Temp\logo-tools.png"
    
    # Verifier si le fichier existe deja
    if (-not (Test-Path $LogoPath)) {
        # Telecharger le fichier
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($LogoUrl, $LogoPath)
        Write-Host "Logo telecharger depuis : $LogoUrl"
    } else {
        Write-Output "Logo deja existant ici : $LogoPath"
    }
    
    # Telecharger et definir l'image comme fond d ecran
     $BackgroundURL = "https://dl.poupli.net/background-tools.jpg"
     $BackgroundPath = "C:\Windows\Temp\background-tools.jpg"
     
     # Verifier si le fichier existe deja
     if (-not (Test-Path $BackgroundPath)) {
         # Telecharger le fichier
         $wc = New-Object System.Net.WebClient
         $wc.DownloadFile($BackgroundURL, $BackgroundPath)
         Write-Host "Fond telecharger depuis : $BackgroundURL"
     } else {
         Write-Output "Fond deja existant ici : $BackgroundPath"
     }
    cls 
  
    EchoToolsBox
    #############################################################
    #               Menu Multistall                             #
    #############################################################
    
    $subform = New-Object System.Windows.Forms.Form
    $subform.Text = "ToolsBox - Graphique"
    $subform.Size = New-Object System.Drawing.Size(400, 400)
    $subform.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
    #$subform.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
    $subform.BackgroundImageLayout = "Stretch"
    $subform.StartPosition = "CenterScreen"   
 
    ######################################################################
    # Installer Google Chrome
    $buttonChrome = New-Object System.Windows.Forms.Button
    $buttonChrome.Text = "Installer Google Chrome"
    $buttonChrome.Size = New-Object System.Drawing.Size(300, 30)
    $buttonChrome.Location = New-Object System.Drawing.Point(50, 20)
    $buttonChrome.Add_Click({
        InstallChrome
    })
    $subform.Controls.Add($buttonChrome)
    #######################################################################
    # Installer FireFox
    $buttonFirefox = New-Object System.Windows.Forms.Button
    $buttonFirefox.Text = "Installer Firefox"
    $buttonFirefox.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFirefox.Location = New-Object System.Drawing.Point(50, 70)
    $buttonFirefox.Add_Click({
        InstallFirefox
    })
    $subform.Controls.Add($buttonFirefox)
     #######################################################################
    
    # Creer un bouton "Quitter"
    $buttonQuitter = New-Object System.Windows.Forms.Button
    $buttonQuitter.Text = "Quitter"
    $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
    $buttonQuitter.Location = New-Object System.Drawing.Point(50, 320)
    $buttonQuitter.Add_Click({
        $subform.Close()
    })

    # Ajouter le bouton "Quitter" a la fenetre
    $subform.Controls.Add($buttonQuitter)

    ###########################################################################
    $subform.ShowDialog()