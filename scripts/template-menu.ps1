$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://raw.githubusercontent.com/AtisFPS/ToolsBox/main/scripts/"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload"

$LogoUrl = "$cdnURL/logo-tools.png"
$LogoPath = "$temp/logo-tools.png"
$BackgroundURL = "$cdnURL/background-tools.jpg"
$BackgroundPath = "$temp/background-tools.jpg"

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