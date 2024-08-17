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
$cdnURL          = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/"
$ScriptsPath = "$scriptURL/"

function TestCacheGraphique {
    $LogoUrl = "$cdnURL/logo-tools.png"
    $LogoPath = "$temp/logo-tools.png"
    $BackgroundURL = "$cdnURL/background-tools.jpg"
    $BackgroundPath = "$temp/background-tools.jpg"

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
    Write-Host 'Github : https://github.com/AtisFPS/ToolsBox'
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

function IPtools {
    $ScriptsPath = "$scriptURL/ip.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}

function RepairSystem {
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

function ResetSSHFunction {
    cd $env:USERPROFILE
    cd .ssh
    rm .\known_hosts
}

function DebloatFunction {
    # Vérifie si le script est exécuté avec les droits d'administrateur
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        # Relance le script en tant qu'administrateur
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$PSCommandPath`"" -Verb RunAs
        return
    }

    # Continue avec l'exécution du script si les droits d'administrateur sont présents
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
        reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-1b8b4d7b2f85}" /f
        Write-Host "Registre mis a jour"
    })
    $form.Controls.Add($buttonBetterRightClick)

    ##########################################################################
    
    # Creer un bouton "Telecharger Fond Ecran"
    $buttonFond = New-Object System.Windows.Forms.Button
    $buttonFond.Text = "Telecharger Fond d'ecran"
    $buttonFond.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFond.Location = New-Object System.Drawing.Point(50, 120)
    $buttonFond.Add_Click({
        $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
        Write-Host "Fond d'écran mis à jour"
    })
    $form.Controls.Add($buttonFond)

    ##########################################################################
    # Creer un bouton "Changer le fond d'écran"
    $buttonChangerWPP = New-Object System.Windows.Forms.Button
    $buttonChangerWPP.Text = "Changer le fond d'écran"
    $buttonChangerWPP.Size = New-Object System.Drawing.Size(300, 30)
    $buttonChangerWPP.Location = New-Object System.Drawing.Point(50, 170)
    $buttonChangerWPP.Add_Click({
        wppChanger
    })
    $form.Controls.Add($buttonChangerWPP)
    
    ##########################################################################
    # Creer un bouton "Changer le fond d'écran"
    $buttonInstallSoft = New-Object System.Windows.Forms.Button
    $buttonInstallSoft.Text = "Installations et mises à jour"
    $buttonInstallSoft.Size = New-Object System.Drawing.Size(300, 30)
    $buttonInstallSoft.Location = New-Object System.Drawing.Point(50, 220)
    $buttonInstallSoft.Add_Click({
        MultiInstall
    })
    $form.Controls.Add($buttonInstallSoft)

    ##########################################################################
    # Creer un bouton "IP"
    $buttonIP = New-Object System.Windows.Forms.Button
    $buttonIP.Text = "Afficher IP"
    $buttonIP.Size = New-Object System.Drawing.Size(300, 30)
    $buttonIP.Location = New-Object System.Drawing.Point(50, 270)
    $buttonIP.Add_Click({
        IPtools
    })
    $form.Controls.Add($buttonIP)

    ##########################################################################
    # Creer un bouton "System Repair"
    $buttonRepair = New-Object System.Windows.Forms.Button
    $buttonRepair.Text = "Réparer Windows"
    $buttonRepair.Size = New-Object System.Drawing.Size(300, 30)
    $buttonRepair.Location = New-Object System.Drawing.Point(50, 320)
    $buttonRepair.Add_Click({
        RepairSystem
    })
    $form.Controls.Add($buttonRepair)

    ##########################################################################
    # Creer un bouton "FireWall"
    $buttonFirewall = New-Object System.Windows.Forms.Button
    $buttonFirewall.Text = "Etat du pare-feu"
    $buttonFirewall.Size = New-Object System.Drawing.Size(300, 30)
    $buttonFirewall.Location = New-Object System.Drawing.Point(50, 370)
    $buttonFirewall.Add_Click({
        firewallfun
    })
    $form.Controls.Add($buttonFirewall)

    ##########################################################################
    # Creer un bouton "Utils"
    $buttonUtils = New-Object System.Windows.Forms.Button
    $buttonUtils.Text = "Outils Utilitaires"
    $buttonUtils.Size = New-Object System.Drawing.Size(300, 30)
    $buttonUtils.Location = New-Object System.Drawing.Point(50, 420)
    $buttonUtils.Add_Click({
        UtilsFunction
    })
    $form.Controls.Add($buttonUtils)

    ##########################################################################
    # Creer un bouton "Debloat"
    $buttonDebloat = New-Object System.Windows.Forms.Button
    $buttonDebloat.Text = "Debloat Windows"
    $buttonDebloat.Size = New-Object System.Drawing.Size(300, 30)
    $buttonDebloat.Location = New-Object System.Drawing.Point(50, 470)
    $buttonDebloat.Add_Click({
        DebloatFunction
    })
    $form.Controls.Add($buttonDebloat)
    
    ##########################################################################
    # Creer un bouton "Exit"
    $buttonQuitter = New-Object System.Windows.Forms.Button
    $buttonQuitter.Text = "Quitter"
    $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
    $buttonQuitter.Location = New-Object System.Drawing.Point(50, 520)
    $buttonQuitter.Add_Click({
        $form.Close()
    })
    $form.Controls.Add($buttonQuitter)

    $form.TopMost = $true
    $form.ShowDialog()
}

TestCacheGraphique
Win11CustomFunction
