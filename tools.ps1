# Script graphique d'outils pour les STS2
# Tout téléchargement sera effectué dans un dossier temporaire $temp/

$host.UI.RawUI.WindowTitle = "ToolsBox - STS2"
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Import-Module -Name PowerShellGet
Install-Module -Name WindowsDesktopBackground
Add-Type -AssemblyName PresentationCore,PresentationFramework

Clear-Host
$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://sanction.poupli.net/scripts/"
#$cdnURL         = "https://dl.poupli.net"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload"


#    $ScriptsPath = "$scriptURL/"
#    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression

function EchoToolsBox {
    cls
    Write-Host ''
    Write-Host 'Tout telechargement sera effectue dans les dossier temporaire ou dans vos images '
    Write-Host ''
    Write-Host '                  $$$$$$$$`                  $$\           $$$$$$$\                      '
    Write-Host '                  \__$$  __|                 $$ |          $$  __$$\                     '
    Write-Host '                     $$ | $$$$$$\   $$$$$$\  $$ | $$$$$$$\ $$ |  $$ | $$$$$$\  $$\   $$\ '
    Write-Host '                     $$ |$$  __$$\ $$  __$$\ $$ |$$  _____|$$$$$$$\ |$$  __$$\ \$$\ $$  |'
    Write-Host '                     $$ |$$ /  $$ |$$ /  $$ |$$ |\$$$$$$\  $$  __$$\ $$ /  $$ | \$$$$  / '
    Write-Host '                     $$ |$$ |  $$ |$$ |  $$ |$$ | \____$$\ $$ |  $$ |$$ |  $$ | $$  $$<  '
    Write-Host '                     $$ |\$$$$$$  |\$$$$$$  |$$ |$$$$$$$  |$$$$$$$  |\$$$$$$  |$$  /\$$\ '
    Write-Host '                     \__| \______/  \______/ \__|\_______/ \_______/  \______/ \__/  \__|'
    Write-Host ''
    Write-Host ''
    Write-Host '--'
    Write-Host 'Script mis a jour regulierement'
    Write-Host 'Certaines fonction sont des scripts GitHub directement integrer'
    Write-Host '----------------------------------------------------------------'
    Write-Host 'Made by Hugo SERRURE'
    Write-Host 'https://hserrure.poupli.net/'
    Write-Host 'Contact : hserrure@poupli.net'
    Write-Host 'All right reserved'
    Write-Host '--'
}
function Fix2502-2503 {
    $2502 = "$scriptURL/Fix2502-2503.ps1"
    Invoke-RestMethod -Uri $2502 | Invoke-Expression
}
function wppChanger {
    $ScriptsPath = "$scriptURL/Change-Wallpaper.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}   
function PoupliWPP {
    $ScriptsPath = "$scriptURL/fond-poupli.net.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function IPtools{
    $ScriptsPath = "$scriptURL/ip.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function RepairSystem{
    $ScriptsPath = "$scriptURL/system-repair.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function Tankedge {
    $WinUtilsEdgeURL = "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/edgeremoval.bat"
    $WinUtilsEdgePath = "$env:TEMP\edgeremoval.bat"
    Invoke-WebRequest -Uri $WinUtilsEdgeURL -OutFile $WinUtilsEdgePath
    Start-Process $WinUtilsEdgePath
}
function RemoveOneDrive {
    $ScriptsPath = "$scriptURL/remove-onedrive.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function firewallfun {
    $ScriptsPath = "$scriptURL/firewall-status.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function MultiInstall {
    $ScriptsPath = "$scriptURL/multi-install.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function ResetSSHFunction{
    cd $env:USERPROFILE
    cd .ssh
    rm .\known_hosts
}

function UtilsFunction {
      # Telecharger et definir le logo comme icone
      $LogoUrl = "$cdnURL/logo-tools.png"
      $LogoPath = "$temp/logo-tools.png"

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
       $BackgroundURL = "$cdnURL/background-tools.jpg"
       $BackgroundPath = "$temp/background-tools.jpg"
       
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
      #               Menu Principal                              #
      #############################################################
      
      $form = New-Object System.Windows.Forms.Form
      $form.Text = "Outils - Administration"
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
}

function Win11CustomFunction {
      # Telecharger et definir le logo comme icone
      $LogoUrl = "$cdnURL/logo-tools.png"
      $LogoPath = "$temp/logo-tools.png"
      
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
       $BackgroundURL = "$cdnURL/background-tools.jpg"
       $BackgroundPath = "$temp/background-tools.jpg"
       
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
      #               Menu Principal                              #
      #############################################################
      
      $form = New-Object System.Windows.Forms.Form
      $form.Text = "Windows 11 - Customisation"
      $form.Size = New-Object System.Drawing.Size(400, 650)
      # Defini le logo comme icone de la fenetre
      $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
      # Defini le fond d ecran de la fenetre
      $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
      $form.BackgroundImageLayout = "Stretch"
      $form.StartPosition = "CenterScreen"  
  
      ##########################################################################
      
        # Creer un bouton "Fond d'ecran Poupli.net"
        $buttonQuitter = New-Object System.Windows.Forms.Button
        $buttonQuitter.Text = "Fond d'ecran - Poupli.net "
        $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
        $buttonQuitter.Location = New-Object System.Drawing.Point(50, 20)
        $buttonQuitter.Add_Click({
            PoupliWPP
        })
    
        # Ajouter le bouton "Quitter" a la fenetre
        $form.Controls.Add($buttonQuitter)

  
      ##########################################################################

            # OLD Right Click
    $buttonBetterRightClick = New-Object System.Windows.Forms.Button
    $buttonBetterRightClick.Text = "Retrouver l'ancien clic droit sous Win11 "
    $buttonBetterRightClick.Size = New-Object System.Drawing.Size(300, 30)
    $buttonBetterRightClick.Location = New-Object System.Drawing.Point(50, 70)
    $buttonBetterRightClick.Add_Click({
        reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    })
    $form.Controls.Add($buttonBetterRightClick)    
        
    ##########################################################################
    ##########################################################################
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
}

function FenetreGraphique {

    # Telecharger et definir le logo comme icone
    $LogoUrl = "$cdnURL/logo-tools.png"
    $LogoPath = "$temp//logo-tools.png"
    
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
     $BackgroundURL = "$cdnURL/background-tools.jpg"
     $BackgroundPath = "$temp//background-tools.jpg"
     
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
    #               Menu Principal                              #
    #############################################################
    
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "ToolsBox - Graphique"
    $form.Size = New-Object System.Drawing.Size(400, 650)
    # Defini le logo comme icone de la fenetre
    $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
    # Defini le fond d ecran de la fenetre
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
    $form.BackgroundImageLayout = "Stretch"
    $form.StartPosition = "CenterScreen"  

    ##########################################################################
     #   Affiche le panneau de configuration
     $buttonOutils = New-Object System.Windows.Forms.Button
     $buttonOutils.Text = "Outils - Administration"
     $buttonOutils.Size = New-Object System.Drawing.Size(300, 30)
     $buttonOutils.Location = New-Object System.Drawing.Point(50, 20)
 
     $buttonOutils.Add_Click({
         UtilsFunction
     })
     $form.Controls.Add($buttonOutils)
     ##########################################################################
    # Debloat Windows
     $buttonDebloat = New-Object System.Windows.Forms.Button
     $buttonDebloat.Text = "Debloat Windows"
     $buttonDebloat.Size = New-Object System.Drawing.Size(300, 30)
     $buttonDebloat.Location = New-Object System.Drawing.Point(50, 70)
 
     $buttonDebloat.Add_Click({
         DebloatFunction
     })
     $form.Controls.Add($buttonDebloat)
    ##########################################################################    
    ##########################################################################

    #  Sortie d un tank T29 pour detruire Edge 
    $buttonTankedge = New-Object System.Windows.Forms.Button
    $buttonTankedge.Text = "Bye bye Edge"
    $buttonTankedge.Size = New-Object System.Drawing.Size(300, 30)
    $buttonTankedge.Location = New-Object System.Drawing.Point(50, 170)
    $buttonTankedge.Add_Click({
        TankEdge
    })
    $form.Controls.Add($buttonTankedge)
    ##########################################################################
    # Création du bouton pour supprimer OneDrive
    $buttonRemoveOneDrive = New-Object System.Windows.Forms.Button
    $buttonRemoveOneDrive.Text = "Remove OneDrive"
    $buttonRemoveOneDrive.Size = New-Object System.Drawing.Size(300, 30)
    $buttonRemoveOneDrive.Location = New-Object System.Drawing.Point(50, 220)
    $buttonRemoveOneDrive.Add_Click({  
        RemoveOneDrive
    })
    $form.Controls.Add($buttonRemoveOneDrive)
 
    ##########################################################################

    # Liste d'application possible d'installer  
    $buttonMultistall = New-Object System.Windows.Forms.Button
    $buttonMultistall.Text = "MultiInstall"
    $buttonMultistall.Size = New-Object System.Drawing.Size(300, 30)
    $buttonMultistall.Location = New-Object System.Drawing.Point(50, 270)
    $buttonMultistall.Add_Click({
        MultiInstall
    })
    $form.Controls.Add($buttonMultistall)
    ######################################################################
    # Fix l'erreur 2502 et 2503 
    $buttonFixErr = New-Object System.Windows.Forms.Button
    $buttonFixErr.Text = "Fix Erreur 2502 et 2503"
    $buttonFixErr.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFixErr.Location = New-Object System.Drawing.Point(50, 320)
    $buttonFixErr.Add_Click({
        Fix2502-2503
    })
    $form.Controls.Add($buttonFixErr)

    ##########################################################################
    # Création du bouton pour accéder au pare-feu
    $buttonFirewall = New-Object System.Windows.Forms.Button
    $buttonFirewall.Text = "Firewall - Settings"
    $buttonFirewall.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFirewall.Location = New-Object System.Drawing.Point(50, 370)
    $buttonFirewall.Add_Click({  
        firewallfun
    })
    $form.Controls.Add($buttonFirewall)  
    
   ##########################################################################
       # Création d'un bouton qui lance le sanction 
       $buttonSanction = New-Object System.Windows.Forms.Button
       $buttonSanction.Text = "Lancer sanction en version graphique "
       $buttonSanction.Size = New-Object System.Drawing.Size(300, 30)
       $buttonSanction.Location = New-Object System.Drawing.Point(50, 420)
       $buttonSanction.Add_Click({  
           iwr -useb https://sanction.poupli.net/graphique.ps1 | iex
       })
       EchoToolsBox
       $form.Controls.Add($buttonSanction)
    ##########################################################################
       # Création d'un bouton qui lance le sanction 
       $buttonCustom = New-Object System.Windows.Forms.Button
       $buttonCustom.Text = "Customisation de Windows 11"
       $buttonCustom.Size = New-Object System.Drawing.Size(300, 30)
       $buttonCustom.Location = New-Object System.Drawing.Point(50, 470)
       $buttonCustom.Add_Click({  
           Win11CustomFunction
       })
       EchoToolsBox
       $form.Controls.Add($buttonCustom)
    ##########################################################################

         # Creer un bouton de reparation Windows
         $buttonRepair = New-Object System.Windows.Forms.Button
         $buttonRepair.Text = "Reparer Windows"
         $buttonRepair.Size = New-Object System.Drawing.Size(300, 30)
         $buttonRepair.Location = New-Object System.Drawing.Point(50, 520)
         $buttonRepair.Add_Click({
             RepairSystem
         })
     
         # Ajouter le bouton "Repair" a la fenetre
         $form.Controls.Add($buttonRepair)
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
    
    ##########################################################################
    
    # Afficher la fenetre
    $form.ShowDialog()
}
FenetreGraphique
