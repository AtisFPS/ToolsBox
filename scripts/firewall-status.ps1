    Add-Type -AssemblyName System.Windows.Forms

    # Fonction pour obtenir l'état du pare-feu pour un profil
    function Get-FirewallState($profile) {
        $firewallStatus = Get-NetFirewallProfile -Profile $profile -ErrorAction SilentlyContinue
        if ($firewallStatus) {
            return $firewallStatus.Enabled
        }
        return "Inconnu"
    }
    ####################################################
    # Création du formulaire
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Etat des Pare-feu Windows"
    $form.Size = New-Object System.Drawing.Size(400, 175)
        # Telecharger et definir le logo comme icone
        $LogoUrl = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/logo-tools.png"
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
         $BackgroundURL = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/background-tools.jpg"
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
        $form.StartPosition = "CenterScreen" 
        # Defini le logo comme icone de la fenetre
        $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
        $form.BackgroundImageLayout = "Stretch"
        $form.StartPosition = "CenterScreen"  
        EchoToolsBox
    ###################################################

    $labelDomaine = New-Object System.Windows.Forms.Label
    $labelDomaine.Text = "Domaine:  " + (Get-FirewallState "Domain")
    $labelDomaine.Location = New-Object System.Drawing.Point(50, 20)
    $form.Controls.Add($labelDomaine)
    
    $labelPrive = New-Object System.Windows.Forms.Label
    $labelPrive.Text = "Prive:  " + (Get-FirewallState "Private")
    $labelPrive.Location = New-Object System.Drawing.Point(150, 20)
    $form.Controls.Add($labelPrive)

    $labelPublic = New-Object System.Windows.Forms.Label
    $labelPublic.Text = "Public:  " + (Get-FirewallState "Public")
    $labelPublic.Location = New-Object System.Drawing.Point(250, 20)
    $form.Controls.Add($labelPublic)

    $buttonFirewallSettings = New-Object System.Windows.Forms.Button
    $buttonFirewallSettings.Text = "Acceder au Pare-feu"
    $buttonFirewallSettings.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFirewallSettings.Location = New-Object System.Drawing.Point(50, 80)
    $buttonFirewallSettings.Add_Click({
        Start-Process "wf.msc"
    })

    $form.Controls.Add($buttonFirewallSettings)
    $form.ShowDialog()