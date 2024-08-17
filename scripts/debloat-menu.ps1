$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/scripts"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload/"

$LogoUrl = "$cdnURL/logo-tools.png"
$LogoPath = "$temp/logo-tools.png"
$BackgroundURL = "$cdnURL/background-tools.jpg"
$BackgroundPath = "$temp/background-tools.jpg"

function Tankedge {
    $WinUtilsEdgeURL = "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/functions/private/Uninstall-WinUtilEdgeBrowser.ps1"
    $WinUtilsEdgePath = "$env:TEMP\edgeremoval.ps1"
    Invoke-WebRequest -Uri $WinUtilsEdgeURL -OutFile $WinUtilsEdgePath
    Start-Process $WinUtilsEdgePath
}
function RemoveOneDrive {
    $ScriptsPath = "$scriptURL/remove-onedrive.ps1"
    Invoke-RestMethod -Uri $ScriptsPath | Invoke-Expression
}

##############################################################################
##############################################################################
# Reglage de la fenetre
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Debloat - ToolsBox"
    $form.Size = New-Object System.Drawing.Size(400, 650)
    # logo 
    $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
    # fond d ecran
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
    $form.BackgroundImageLayout = "Stretch"
    $form.StartPosition = "CenterScreen"  
  
##############################################################################
##############################################################################

    #  Sortie d un tank T29 pour detruire Edge 
    $buttonTankedge = New-Object System.Windows.Forms.Button
    $buttonTankedge.Text = "Desinstaller Edge"
    $buttonTankedge.Size = New-Object System.Drawing.Size(300, 30)
    $buttonTankedge.Location = New-Object System.Drawing.Point(50, 20)
    $buttonTankedge.Add_Click({
        TankEdge
    })
    $form.Controls.Add($buttonTankedge)
    ##########################################################################
    # Création du bouton pour supprimer OneDrive
    $buttonRemoveOneDrive = New-Object System.Windows.Forms.Button
    $buttonRemoveOneDrive.Text = "Desinstaller OneDrive"
    $buttonRemoveOneDrive.Size = New-Object System.Drawing.Size(300, 30)
    $buttonRemoveOneDrive.Location = New-Object System.Drawing.Point(50, 70)
    $buttonRemoveOneDrive.Add_Click({  
        RemoveOneDrive
    })
    $form.Controls.Add($buttonRemoveOneDrive)

##############################################################################
##############################################################################
    $buttonQuitter = New-Object System.Windows.Forms.Button
    $buttonQuitter.Text = "Quitter"
    $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
    $buttonQuitter.Location = New-Object System.Drawing.Point(50, 570)
    $buttonQuitter.Add_Click({
        $form.Close()
    })
    $form.Controls.Add($buttonQuitter)

##############################################################################
    
$form.ShowDialog()