$downloadUrl = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Logo-PPNET-192x192-WB.png"
$destinationPath = "$temp\Logo-PPNET-192x192-WB.png"
$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
Install-Module -Name WindowsDesktopBackground

function wppChanger {
        param (
            [string]$ImagePath
        )

        if (Test-Path $ImagePath) {
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

            [Wallpaper]::SystemParametersInfo(20, 0, $ImagePath, 3)
        }
}   


        if (-not (Test-Path $destinationPath)) {

            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($downloadUrl, $destinationPath)
            #Write-Host "Logo telecharge depuis : $destinationPath"
        } else {
            #Write-Output "Logo deja existant ici : $destinationPath"
        }
        $subForm = New-Object System.Windows.Forms.Form
        $subForm.Text = "Poupli.net - Wallpaper"
        $subForm.Size = New-Object System.Drawing.Size(400, 400)
 
        $subForm.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $destinationPath).GetHicon())
    
    ########################################################################################
        $subFormChoix = New-Object System.Windows.Forms.Form
        $subFormChoix.Text = "Choix du Fond d'Ecran"
        $subFormChoix.Size = New-Object System.Drawing.Size(735, 390)
        $subFormChoix.BackgroundImageLayout = "Stretch"
        $subFormChoix.StartPosition = "CenterScreen"  
    
        $subFormChoix.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $destinationPath).GetHicon())
        
        $buttonFermer = New-Object System.Windows.Forms.Button
        $buttonFermer.Text = "Fermer"
        $buttonFermer.Size = New-Object System.Drawing.Size(150, 30)
        $buttonFermer.Location = New-Object System.Drawing.Point(500, 290)
        $buttonFermer.Add_Click({
            $subFormChoix.Close()
        })
    
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/BandW-Poupli.net.png" -OutFile $wppPath
            }
            wppChanger $wppPath -imgfolder $imgfolder
        })
                
        # Bouton 2
        $button2 = New-Object System.Windows.Forms.Button
        $button2.Text = "BlackTest-Poupli.net"
        $button2.Size = New-Object System.Drawing.Size(150, 30)
        $button2.Location = New-Object System.Drawing.Point(50, 90)
        $button2.Add_Click({
            $wppPath = "$imgfolder\BlackTest-Poupli.net.png"
            if (-not (Test-Path -Path $wppPath)) {
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/BlackTest-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/CableTEST-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/CableW-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/GfB-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/GfW-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Lake-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Moon2-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Moon-Poupli.net.jpg" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/NightLake-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Road-Poupli.net.jpg" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/TEST-Cable-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/WandB-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/WPP-BfW.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/WPP-Earth-Poupli.net.png" -OutFile $wppPath
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
                Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/WPP-WfB-Poupli.net.png" -OutFile $wppPath
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
               Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Blue-PPNET.png" -OutFile $wppPath
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
               Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/Blue-PPNET2.png" -OutFile $wppPath
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
               Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/LightGold-PPNET.png" -OutFile $wppPath
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
              Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/LightBlue-PPNET.png" -OutFile $wppPath
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