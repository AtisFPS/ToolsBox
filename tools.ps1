# Script graphique d'outils pour les STS2
# Tout téléchargement sera effectué dans un dossier temporaire $temp
$host.UI.RawUI.WindowTitle = "ToolsBox - STS2"
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Import-Module -Name PowerShellGet
Install-Module -Name WindowsDesktopBackground
Add-Type -AssemblyName PresentationCore,PresentationFramework

Clear-Host
$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"

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
    Write-Host ' $$$$$$\ $$$$$$$$\  $$$$$$\   $$$$$$\                       $$$$$$\  $$$$$$\  $$$$$$\  $$$$$$$\  '
    Write-Host ' $$  __$$\\__$$  __|$$  __$$\ $$  __$$\                     $$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ '
    Write-Host ' $$ /  \__|  $$ |   $$ /  \__|\__/  $$ |                    $$ /  \__|  $$ |  $$ /  \__|$$ |  $$ |'
    Write-Host ' \$$$$$$\    $$ |   \$$$$$$\   $$$$$$  |      $$$$$$\       \$$$$$$\    $$ |  \$$$$$$\  $$$$$$$  |'
    Write-Host '  \____$$\   $$ |    \____$$\ $$  ____/       \______|       \____$$\   $$ |   \____$$\ $$  __$$< '
    Write-Host ' $$\   $$ |  $$ |   $$\   $$ |$$ |                          $$\   $$ |  $$ |  $$\   $$ |$$ |  $$ |'
    Write-Host ' \$$$$$$  |  $$ |   \$$$$$$  |$$$$$$$$\                     \$$$$$$  |$$$$$$\ \$$$$$$  |$$ |  $$ |'
    Write-Host '  \______/   \__|    \______/ \________|                     \______/ \______| \______/ \__|  \__|'
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
function Fix2502-2503{
    Invoke-Item -Path "C:\Windows\Temp"

   $msgTitle = "OutilsBox - STS2 SISR"
    $msgBody = "Instructiion de Fix des erreurs 2502 et 2503 . Le script arrivera prochainement"
    [System.Windows.MessageBox]::Show($msgBody, $msgTitle)

    $etape1 = "1. Ouvre le dossier C:\Windows\Temp afin que tu sois directement dans le dossier."
    $etape2 = "2. Change le proprietaire du dossier et des fichiers herites pour 'Tout le monde'."
    $etape3 = "3. Ajoute l'utilisateur 'Tout le monde' et donne-lui le controle total."

    $etapeSuivante = @"
Les etapes suivantes doivent etre effectuees :
$etape1
$etape2
$etape3
"@
    
    [System.Windows.MessageBox]::Show($etapeSuivante, $msgTitle)
}


function wppChanger {
        param (
            [string]$ImagePath
        )

        if (Test-Path $ImagePath) {
            # Verifier si le type Wallpaper existe deja
            if (-not ("Wallpaper" -as [type])) {
                Add-Type -TypeDefinition @"
                    using System;
                    using System.Runtime.InteropServices;
                    public class Wallpaper {
                        [DllImport("user32.dll", CharSet = CharSet.Auto)]
                        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
                    }
"@
            }

            # Changer le fond d'ecran
            [Wallpaper]::SystemParametersInfo(20, 0, $ImagePath, 3)
        }
    }   


function PoupliWPP {
        # Telecharger et definir le logo comme icone
        $downloadUrl = "https://dl.poupli.net/Logo-PPNET-192x192-WB.png"
        $destinationPath = "$temp\Logo-PPNET-192x192-WB.png"
    
        # Verifier si le fichier existe deja
        if (-not (Test-Path $destinationPath)) {
            # Telecharger le fichier
            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($downloadUrl, $destinationPath)
            Write-Host "Logo telecharge depuis : $destinationPath"
        } else {
            Write-Output "Logo deja existant ici : $destinationPath"
        }
    
        # Creer une fenetre
        $subForm = New-Object System.Windows.Forms.Form
        $subForm.Text = "Poupli.net - Wallpaper"
        $subForm.Size = New-Object System.Drawing.Size(400, 400)
    
        # Definir le logo comme icone de la fenetre
        $subForm.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $destinationPath).GetHicon())
    
        # Creer une nouvelle fenetre pour les boutons de choix
        $subFormChoix = New-Object System.Windows.Forms.Form
        $subFormChoix.Text = "Choix du Fond d'Ecran"
        $subFormChoix.Size = New-Object System.Drawing.Size(735, 390)
        $subFormChoix.BackgroundImageLayout = "Stretch"
        $subFormChoix.StartPosition = "CenterScreen"  
    
        # Definir le logo comme icone de la fenetre de choix
        $subFormChoix.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $destinationPath).GetHicon())
        
        # Creer le bouton "Fermer"
        $buttonFermer = New-Object System.Windows.Forms.Button
        $buttonFermer.Text = "Fermer"
        $buttonFermer.Size = New-Object System.Drawing.Size(150, 30)
        $buttonFermer.Location = New-Object System.Drawing.Point(500, 290)
        $buttonFermer.Add_Click({
            $subFormChoix.Close()
        })
    
        # Ajouter le bouton "Fermer" a la fenetre
        $subFormChoix.Controls.Add($buttonFermer)
        ## TEST DU DOSSIER IF = YES = RIEN // IF = NO = Crée le dossier ##
        if (-not (Test-Path -Path $imgfolder -PathType Container)) {
        New-Item -Path $imgfolder -ItemType Directory
        }
         #################################################################################################
        ########################################### COLONNE 1 ###########################################
        #################################################################################################
        
        # Creer les boutons de choix de fond d'ecran
        $button1 = New-Object System.Windows.Forms.Button
        $button1.Text = "Blanc et noir "
        $button1.Size = New-Object System.Drawing.Size(150, 30)
        $button1.Location = New-Object System.Drawing.Point(50, 50)
        $button1.Add_Click({
            $wppPath = "$imgfolder\BandW-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/BandW-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })
                
        # Bouton 2
        $button2 = New-Object System.Windows.Forms.Button
        $button2.Text = "BlackTest-Poupli.net"
        $button2.Size = New-Object System.Drawing.Size(150, 30)
        $button2.Location = New-Object System.Drawing.Point(50, 90)
        $button2.Add_Click({
            $wppPath = "$imgfolder\BlackTest-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/BlackTest-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 3
        $button3 = New-Object System.Windows.Forms.Button
        $button3.Text = "CableTEST-Poupli.net"
        $button3.Size = New-Object System.Drawing.Size(150, 30)
        $button3.Location = New-Object System.Drawing.Point(50, 130)
        $button3.Add_Click({
            $wppPath = "$imgfolder\CableTEST-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/CableTEST-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 4
        $button4 = New-Object System.Windows.Forms.Button
        $button4.Text = "CableW-Poupli.net"
        $button4.Size = New-Object System.Drawing.Size(150, 30)
        $button4.Location = New-Object System.Drawing.Point(50, 170)
        $button4.Add_Click({
            $wppPath = "$imgfolder\CableW-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/CableW-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })
        # Bouton 5
        $button5 = New-Object System.Windows.Forms.Button
        $button5.Text = "GfB-Poupli.net"
        $button5.Size = New-Object System.Drawing.Size(150, 30)
        $button5.Location = New-Object System.Drawing.Point(50, 210)
        $button5.Add_Click({
            $wppPath = "$imgfolder\GfB-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/GfB-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 6
        $button6 = New-Object System.Windows.Forms.Button
        $button6.Text = "GfW-Poupli.net"
        $button6.Size = New-Object System.Drawing.Size(150, 30)
        $button6.Location = New-Object System.Drawing.Point(50, 250)
        $button6.Add_Click({
            $wppPath = "$imgfolder\GfW-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/GfW-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 7
        $button7 = New-Object System.Windows.Forms.Button
        $button7.Text = "Lake-Poupli.net"
        $button7.Size = New-Object System.Drawing.Size(150, 30)
        $button7.Location = New-Object System.Drawing.Point(50, 290)
        $button7.Add_Click({
            $wppPath = "$imgfolder\Lake-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/Lake-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        #################################################################################################
        ########################################### COLONNE 2 ###########################################
        #################################################################################################

        # Bouton 9
        $button9 = New-Object System.Windows.Forms.Button
        $button9.Text = "Moon2-Poupli.net"
        $button9.Size = New-Object System.Drawing.Size(150, 30)
        $button9.Location = New-Object System.Drawing.Point(300, 50)
        $button9.Add_Click({
            $wppPath = "$imgfolder\Moon2-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/Moon2-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 10
        $button10 = New-Object System.Windows.Forms.Button
        $button10.Text = "Moon-Poupli.net"
        $button10.Size = New-Object System.Drawing.Size(150, 30)
        $button10.Location = New-Object System.Drawing.Point(300, 90)
        $button10.Add_Click({
            $wppPath = "$imgfolder\Moon-Poupli.net.jpg"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/Moon-Poupli.net.jpg" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 11
        $button11 = New-Object System.Windows.Forms.Button
        $button11.Text = "NightLake-Poupli.net"
        $button11.Size = New-Object System.Drawing.Size(150, 30)
        $button11.Location = New-Object System.Drawing.Point(300, 130)
        $button11.Add_Click({
            $wppPath = "$imgfolder\NightLake-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/NightLake-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 12
        $button12 = New-Object System.Windows.Forms.Button
        $button12.Text = "Road-Poupli.net"
        $button12.Size = New-Object System.Drawing.Size(150, 30)
        $button12.Location = New-Object System.Drawing.Point(300, 170)
        $button12.Add_Click({
            $wppPath = "$imgfolder\Road-Poupli.net.jpg"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/Road-Poupli.net.jpg" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 13
        $button13 = New-Object System.Windows.Forms.Button
        $button13.Text = "TEST-Cable-Poupli.net"
        $button13.Size = New-Object System.Drawing.Size(150, 30)
        $button13.Location = New-Object System.Drawing.Point(300, 210)
        $button13.Add_Click({
            $wppPath = "$imgfolder\TEST-Cable-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/TEST-Cable-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 14
        $button14 = New-Object System.Windows.Forms.Button
        $button14.Text = "WandB-Poupli.net"
        $button14.Size = New-Object System.Drawing.Size(150, 30)
        $button14.Location = New-Object System.Drawing.Point(300, 250)
        $button14.Add_Click({
            $wppPath = "$imgfolder\WandB-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/WandB-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 15
        $button15 = New-Object System.Windows.Forms.Button
        $button15.Text = "WPP-BfW.png"
        $button15.Size = New-Object System.Drawing.Size(150, 30)
        $button15.Location = New-Object System.Drawing.Point(300, 290)
        $button15.Add_Click({
            $wppPath = "$imgfolder\WPP-BfW.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/WPP-BfW.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        #################################################################################################
        ########################################### COLONNE 3 ###########################################
        #################################################################################################

        # Bouton 16
        $button16 = New-Object System.Windows.Forms.Button
        $button16.Text = "WPP-Earth-Poupli.net"
        $button16.Size = New-Object System.Drawing.Size(150, 30)
        $button16.Location = New-Object System.Drawing.Point(500, 50)
        $button16.Add_Click({
            $wppPath = "$imgfolder\WPP-Earth-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/WPP-Earth-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })

        # Bouton 17
        $button17 = New-Object System.Windows.Forms.Button
        $button17.Text = "WPP-WfB-Poupli.net"
        $button17.Size = New-Object System.Drawing.Size(150, 30)
        $button17.Location = New-Object System.Drawing.Point(500, 90)
        $button17.Add_Click({
            $wppPath = "$imgfolder\WPP-WfB-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://dl.poupli.net/WPP-WfB-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath
        })
        
       # Bouton 18
       $button18 = New-Object System.Windows.Forms.Button
       $button18.Text = "Blue-Simple-Poupli.net"
       $button18.Size = New-Object System.Drawing.Size(150, 30)
       $button18.Location = New-Object System.Drawing.Point(500, 130)
       $button18.Add_Click({
           $wppPath = "$imgfolder\Blue-PPNET.png"
           if (-not (Test-Path -Path $wppPath)) {
               Invoke-WebRequest -Uri "https://dl.poupli.net/Blue-PPNET.png" -OutFile $wppPath
           }
           wppChanger $wppPath
       }) 
        
        # Bouton 18b
       $button18b = New-Object System.Windows.Forms.Button
       $button18b.Text = "Blue-Simple2-Poupli.net"
       $button18b.Size = New-Object System.Drawing.Size(150, 30)
       $button18b.Location = New-Object System.Drawing.Point(500, 170)
       $button18b.Add_Click({
           $wppPath = "$imgfolder\Blue-PPNET2.png"
           if (-not (Test-Path -Path $wppPath)) {
               Invoke-WebRequest -Uri "https://dl.poupli.net/Blue-PPNET2.png" -OutFile $wppPath
           }
           wppChanger $wppPath
       }) 

       # Bouton 19
       $button19 = New-Object System.Windows.Forms.Button
       $button19.Text = "LightGold-Poupli.net"
       $button19.Size = New-Object System.Drawing.Size(150, 30)
       $button19.Location = New-Object System.Drawing.Point(500, 210)
       $button19.Add_Click({
           $wppPath = "$imgfolder\LightGold-PPNET.png"
           if (-not (Test-Path -Path $wppPath)) {
               Invoke-WebRequest -Uri "https://dl.poupli.net/LightGold-PPNET.png" -OutFile $wppPath
           }
           wppChanger $wppPath
       })            
        
      # Bouton 20
      $button20 = New-Object System.Windows.Forms.Button
      $button20.Text = "LightBlue-Poupli.net"
      $button20.Size = New-Object System.Drawing.Size(150, 30)
      $button20.Location = New-Object System.Drawing.Point(500, 250)
      $button20.Add_Click({
          $wppPath = "$imgfolder\LightBlue-PPNET.png"
          if (-not (Test-Path -Path $wppPath)) {
              Invoke-WebRequest -Uri "https://dl.poupli.net/LightBlue-PPNET.png" -OutFile $wppPath
          }
          wppChanger $wppPath
      })       

        #################################################################################################
        ########################################### COLONNE 4 ###########################################
        #################################################################################################
    

        
        # Ajouter les boutons a la fenetre
        $subFormChoix.Controls.Add($button1)
        $subFormChoix.Controls.Add($button2)
        $subFormChoix.Controls.Add($button3)
        $subFormChoix.Controls.Add($button4)
        $subFormChoix.Controls.Add($button5)
        $subFormChoix.Controls.Add($button6)
        $subFormChoix.Controls.Add($button7)
        $subFormChoix.Controls.Add($button9)
        $subFormChoix.Controls.Add($button10)
        $subFormChoix.Controls.Add($button11)
        $subFormChoix.Controls.Add($button12)
        $subFormChoix.Controls.Add($button13)
        $subFormChoix.Controls.Add($button14)
        $subFormChoix.Controls.Add($button15)
        $subFormChoix.Controls.Add($button16)
        $subFormChoix.Controls.Add($button17)
        $subFormChoix.Controls.Add($button18)
        $subFormChoix.Controls.Add($button18b)
        $subFormChoix.Controls.Add($button19)
        $subFormChoix.Controls.Add($button20)

    
        # Afficher la fenetre
        $subFormChoix.ShowDialog()
}

function IPtools{
    $msgTitle = "IP Tools - ToolsBox"
    $msgBody = "Bientot !"
    [System.Windows.MessageBox]::Show($msgBody,$msgTitle)
}

function RepairSystem{
    Start-Process PowerShell -ArgumentList "Write-Host '(1/4) Chkdsk' -ForegroundColor Green; Chkdsk /scan;
    Write-Host '`n(2/4) SFC - 1st scan' -ForegroundColor Green; sfc /scannow;
    Write-Host '`n(3/4) DISM' -ForegroundColor Green; DISM /Online /Cleanup-Image /Restorehealth;
    Write-Host '`n(4/4) SFC - 2nd scan' -ForegroundColor Green; sfc /scannow;
    Read-Host '`nPress Enter to Continue'" -verb runas
}

function Tankedge {
    $edgeRemovalScriptUrl = "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/edgeremoval.bat"
    $edgeRemovalScriptPath = "$env:TEMP\edgeremoval.bat"
    Invoke-WebRequest -Uri $edgeRemovalScriptUrl -OutFile $edgeRemovalScriptPath
    Start-Process $edgeRemovalScriptPath
}

function RemoveOneDrive {
    Write-Host "Kill OneDrive process"
    taskkill.exe /F /IM "OneDrive.exe"
    taskkill.exe /F /IM "explorer.exe"

    Write-Host "Copy all OneDrive to Root UserProfile"
    Start-Process -FilePath robocopy -ArgumentList "$env:USERPROFILE\OneDrive $env:USERPROFILE /e /xj" -NoNewWindow -Wait

    Write-Host "Remove OneDrive"
    Start-Process -FilePath winget -ArgumentList "uninstall -e --purge --force --silent Microsoft.OneDrive " -NoNewWindow -Wait

    Write-Host "Removing OneDrive leftovers"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"

    # Vérifiez si le répertoire est vide avant de le supprimer :
    If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
    }

    Write-Host "Remove Onedrive from explorer sidebar"
    Set-ItemProperty -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0
    Set-ItemProperty -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0

    Write-Host "Removing run hook for new users"
    reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
    reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
    reg unload "hku\Default"

    Write-Host "Removing startmenu entry"
    Remove-Item -Force -ErrorAction SilentlyContinue "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

    Write-Host "Removing scheduled task"
    Get-ScheduledTask -TaskPath '\' -TaskName 'OneDrive*' -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

    # Ajout de la restauration des emplacements par défaut des dossiers Shell
    Write-Host "Shell Fixing"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "AppData" -Value "$env:userprofile\AppData\Roaming" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Cache" -Value "$env:userprofile\AppData\Local\Microsoft\Windows\INetCache" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Cookies" -Value "$env:userprofile\AppData\Local\Microsoft\Windows\INetCookies" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Favorites" -Value "$env:userprofile\Favorites" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "History" -Value "$env:userprofile\AppData\Local\Microsoft\Windows\History" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Local AppData" -Value "$env:userprofile\AppData\Local" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "My Music" -Value "$env:userprofile\Music" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "My Video" -Value "$env:userprofile\Videos" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "NetHood" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Network Shortcuts" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "PrintHood" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Printer Shortcuts" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Programs" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Recent" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Recent" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "SendTo" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\SendTo" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Start Menu" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Startup" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Templates" -Value "$env:userprofile\AppData\Roaming\Microsoft\Windows\Templates" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}" -Value "$env:userprofile\Downloads" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop" -Value "$env:userprofile\Desktop" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "My Pictures" -Value "$env:userprofile\Pictures" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal" -Value "$env:userprofile\Documents" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{F42EE2D3-909F-4907-8871-4C22FC0BF756}" -Value "$env:userprofile\Documents" -Type ExpandString
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{0DDD015D-B06C-45D5-8C4C-F59713854639}" -Value "$env:userprofile\Pictures" -Type ExpandString

    Write-Host "Restarting explorer"
    Start-Process "explorer.exe"
    Start-Sleep 5
}

function firewallfun {
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
}

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

function MultiInstall {
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
}
function ResetSSHFunction{
    cd $env:USERPROFILE
    cd .ssh
    rm .\known_hosts
}

function UtilsFunction {
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
