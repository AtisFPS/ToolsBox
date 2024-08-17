$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/scripts"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/"
$LogoUrl = "$cdnURL/logo-tools.png"
$LogoPath = "$temp/logo-tools.png"

    

      #############################################################
      #               Menu Principal                              #
      #############################################################
      
      $form = New-Object System.Windows.Forms.Form
      $form.Text = "Outils d'administration - ToolsBox"
      $form.Size = New-Object System.Drawing.Size(400, 650)
      # Defini le logo comme icone de la fenetre
      $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
      # Defini le fond d ecran de la fenetre
      $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
      $form.BackgroundImageLayout = "Stretch"
      $form.StartPosition = "CenterScreen"  
  
      ##########################################################################
     # Afficher le panneau de configuration
     $buttonControlPanel = New-Object System.Windows.Forms.Button
     $buttonControlPanel.Text = "ControlPanel"
     $buttonControlPanel.Size = New-Object System.Drawing.Size(300, 30)
     $buttonControlPanel.Location = New-Object System.Drawing.Point(50, 20)
 
     $buttonControlPanel.Add_Click({
         Start-Process "control"
     })
      $form.Controls.Add($buttonControlPanel)

 ##########################################################################
      # Afficher le panneau de configuration
     $buttonSSHReset = New-Object System.Windows.Forms.Button
     $buttonSSHReset.Text = "Reset les clefs SSH"
     $buttonSSHReset.Size = New-Object System.Drawing.Size(300, 30)
     $buttonSSHReset.Location = New-Object System.Drawing.Point(50, 70)
 
     $buttonSSHReset.Add_Click({
         ResetSSHFunction
     })
      $form.Controls.Add($buttonSSHReset)
    ##########################################################################
    #   Configuration de l addresse IP 
    $buttonIPtools = New-Object System.Windows.Forms.Button
    $buttonIPtools.Text = "Configuration de l'addresse IP"
    $buttonIPtools.Size = New-Object System.Drawing.Size(300, 30)
    $buttonIPtools.Location = New-Object System.Drawing.Point(50, 120)
    $buttonIPtools.Add_Click({
        IPtools
    })
    $form.Controls.Add($buttonIPtools)
    ##########################################################################
    #   Affiche les cartes reseaux du systeme
    $buttonNetCard = New-Object System.Windows.Forms.Button
    $buttonNetCard.Text = "Afficher les cartes reseaux"
    $buttonNetCard.Size = New-Object System.Drawing.Size(300, 30)
    $buttonNetCard.Location = New-Object System.Drawing.Point(50, 170)
    $buttonNetCard.Add_Click({
        Start-Process "ncpa.cpl"
    })
    $form.Controls.Add($buttonNetCard)
    
   ##########################################################################
        # Création du bouton pour accéder au pare-feu
    $buttonFirewall = New-Object System.Windows.Forms.Button
    $buttonFirewall.Text = "Firewall - Settings"
    $buttonFirewall.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFirewall.Location = New-Object System.Drawing.Point(50, 220)
    $buttonFirewall.Add_Click({  
        firewallfun
    })
    $form.Controls.Add($buttonFirewall)  
    

    # Ouvrir l'ancien melanger de volume
    $buttonMelangerVol = New-Object System.Windows.Forms.Button
    $buttonMelangerVol.Text = "Melangeur de volume - Windows 10"
    $buttonMelangerVol.Size = New-Object System.Drawing.Size(300, 30)
    $buttonMelangerVol.Location = New-Object System.Drawing.Point(50, 270)
    $buttonMelangerVol.Add_Click({  
        Start-Process "sndvol.exe"
    })
    $form.Controls.Add($buttonMelangerVol)  

    ##########################################################################
    ##########################################################################

        # Creer un bouton "Quitter"
        $buttonQuitter = New-Object System.Windows.Forms.Button
        $buttonQuitter.Text = "Quitter"
        $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
        $buttonQuitter.Location = New-Object System.Drawing.Point(50, 570)
        $buttonQuitter.Add_Click({
            $form.Close()
        })
    
        # Ajouter le bouton "Quitter" a la fenetre
        $form.Controls.Add($buttonQuitter)
    # Afficher la fenetre
    $form.ShowDialog()
