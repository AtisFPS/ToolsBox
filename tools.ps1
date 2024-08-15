[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Script powershell etant une boite a outils permettant d'acce
# Tout téléchargement sera effectué dans un dossier temporaire $temp/

$host.UI.RawUI.WindowTitle = "ToolsBox - Powershell"

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Import-Module -Name PowerShellGet
Install-Module -Name WindowsDesktopBackground
Add-Type -AssemblyName PresentationCore,PresentationFramework

Clear-Host
$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/scripts"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/"
$ScriptsPath = "$scriptURL/"

#    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression

function TestCacheGraphique{
    $LogoUrl = "$cdnURL/logo-tools.png"
    $LogoPath = "$temp/logo-tools.png"
    $BackgroundURL = "$cdnURL/background-tools.jpg"
    $BackgroundPath = "$temp/background-tools.jpg"

 if (Test-Path $BannerSanctionPath) {
    $buttonSanctionRapide.BackgroundImage = [System.Drawing.Image]::FromFile($BannerSanctionPath)
} else {
    Write-Host "Erreur: Le fichier $BannerSanctionPath n'existe pas."
}

    if (-not (Test-Path $BackgroundPath)) {
        $wc = New-Object System.Net.WebClient
        try {
            $wc.DownloadFile($BackgroundURL, $BackgroundPath)
        } catch {
            Write-Host "Erreur lors du téléchargement du fond d'écran."
        }
    }
}

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
    Write-Host ''
    Write-Host '--'
    Write-Host 'Script mis a jour regulierement'
    Write-Host 'Certaines fonction sont des scripts GitHub directement integrer'
    Write-Host '----------------------------------------------------------------'
    Write-Host 'Made by Hugo SERRURE'
    Write-Host '--'
    Write-host 'Github : https://github.com/AtisFPS/ToolsBox'
    Write-Host 'https://hserrure.poupli.net/'
    Write-Host '--'
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
function DebloatFunction {
    $ScriptsPath = "$scriptURL/debloat-menu.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}
function UtilsFunction {
    $ScriptsPath = "$scriptURL/utils-menu.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
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
    EchoToolsBox
    #############################################################
    #               Menu Principal                              #
    #############################################################
    
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "ToolsBox - Menu Principal"
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
     $buttonOutils.Text = "Outils d'administration Windows "
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

    # Liste d'application possible d'installer  
    $buttonMultistall = New-Object System.Windows.Forms.Button
    $buttonMultistall.Text = "MultiInstall"
    $buttonMultistall.Size = New-Object System.Drawing.Size(300, 30)
    $buttonMultistall.Location = New-Object System.Drawing.Point(50, 120)
    $buttonMultistall.Add_Click({
        MultiInstall
    })
    $form.Controls.Add($buttonMultistall)
    ######################################################################
    # Fix l'erreur 2502 et 2503 
    $buttonFixErr = New-Object System.Windows.Forms.Button
    $buttonFixErr.Text = "Fix Erreur 2502 et 2503"
    $buttonFixErr.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFixErr.Location = New-Object System.Drawing.Point(50, 170)
    $buttonFixErr.Add_Click({
        Fix2502-2503
    })
    $form.Controls.Add($buttonFixErr)

    ##########################################################################
       # Création d'un bouton qui lance le sanction 
       $buttonCustom = New-Object System.Windows.Forms.Button
       $buttonCustom.Text = "Customisation de Windows 11"
       $buttonCustom.Size = New-Object System.Drawing.Size(300, 30)
       $buttonCustom.Location = New-Object System.Drawing.Point(50, 220)
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
         $buttonRepair.Location = New-Object System.Drawing.Point(50, 270)
         $buttonRepair.Add_Click({
             RepairSystem
         })
     
         # Ajouter le bouton "Repair" a la fenetre
         $form.Controls.Add($buttonRepair)
    ##########################################################################
    # Création d'un bouton qui lance le sanction 
    $BannerSanctionURL = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload//banner-sanction.png" 
    $BannerSanctionPath = "$temp/banner-sanction.png" 
    if (-not (Test-Path $BannerSanctionPath)) {
            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($BannerSanctionURL, $BannerSanctionPath)
        }

    $buttonSanctionRapide = New-Object System.Windows.Forms.Button
    $buttonSanctionRapide.Text = "Lancer le script de sanction - BTS Rapide"
    $buttonSanctionRapide.Size = New-Object System.Drawing.Size(300, 30)
    $buttonSanctionRapide.Location = New-Object System.Drawing.Point(50, 470)

    $buttonSanctionRapide.BackgroundImage = [System.Drawing.Image]::FromFile($BannerSanctionPath)
    $buttonSanctionRapide.BackgroundImageLayout = "Stretch"

    $buttonSanctionRapide.Add_Click({  
        irm https://sanction.poupli.net/rapide.ps1 | iex
    })
    $form.Controls.Add($buttonSanctionRapide)     


    ##########################################################################
    # Création d'un bouton qui lance le sanction 
    $BannerSanctionURL = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload//banner-sanction.png" 
    $BannerSanctionPath = "$temp/banner-sanction.png" 
    if (-not (Test-Path $BannerSanctionPath)) {
            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($BannerSanctionURL, $BannerSanctionPath)
        }

    $buttonSanction = New-Object System.Windows.Forms.Button
    $buttonSanction.Text = "Lancer le script de sanction - BTS Graphique"
    $buttonSanction.Size = New-Object System.Drawing.Size(300, 30)
    $buttonSanction.Location = New-Object System.Drawing.Point(50, 520)

    $buttonSanction.BackgroundImage = [System.Drawing.Image]::FromFile($BannerSanctionPath)
    $buttonSanction.BackgroundImageLayout = "Stretch"

    $buttonSanction.Add_Click({  
        irm https://sanction.poupli.net/graphique.ps1 | iex
    })
    $form.Controls.Add($buttonSanction)     

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
TestCacheGraphique
FenetreGraphique
