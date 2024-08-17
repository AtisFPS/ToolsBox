# Charger l'assembly nécessaire pour les objets Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$temp           = "$env:TEMP"
$imgfolder      = "$env:USERPROFILE\Pictures\Poupli.net"
$scriptURL      = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/scripts"
$cdnURL         = "https://raw.githubusercontent.com/AtisFPS/WinTools/main/upload"
$LogoUrl        = "$cdnURL/logo-tools.png"
$LogoPath       = "$temp/logo-tools.png"
$BackgroundURL  = "$cdnURL/background-tools.jpg"
$BackgroundPath = "$temp/background-tools.jpg"

function TestCacheGraphique {
    if (-not (Test-Path $BackgroundPath)) {
        $wc = New-Object System.Net.WebClient
        try {
            $wc.DownloadFile($BackgroundURL, $BackgroundPath)
        } catch {
            Write-Host "Erreur lors du téléchargement du fond d'écran."
        }
    }
}

#############################################################
#               Menu Principal                              #
#############################################################

$form = New-Object System.Windows.Forms.Form
$form.Text = "Outils d'administration - ToolsBox"
$form.Size = New-Object System.Drawing.Size(400, 650)

# Définir le logo comme icône de la fenêtre
if (Test-Path $LogoPath) {
    $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
} else {
    Write-Host "Erreur: Le fichier $LogoPath n'existe pas."
}

# Définir le fond d'écran de la fenêtre
if (Test-Path $BackgroundPath) {
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
    $form.BackgroundImageLayout = "Stretch"
} else {
    Write-Host "Erreur: Le fichier $BackgroundPath n'existe pas."
}

$form.StartPosition = "CenterScreen"

#####################################################################
# Créer des boutons et les ajouter à la fenêtre
#####################################################################

$buttonControlPanel = New-Object System.Windows.Forms.Button
$buttonControlPanel.Text = "ControlPanel"
$buttonControlPanel.Size = New-Object System.Drawing.Size(300, 30)
$buttonControlPanel.Location = New-Object System.Drawing.Point(50, 20)
$buttonControlPanel.Add_Click({
    Start-Process "control"
})
$form.Controls.Add($buttonControlPanel)

$buttonSSHReset = New-Object System.Windows.Forms.Button
$buttonSSHReset.Text = "Reset les clefs SSH"
$buttonSSHReset.Size = New-Object System.Drawing.Size(300, 30)
$buttonSSHReset.Location = New-Object System.Drawing.Point(50, 70)
$buttonSSHReset.Add_Click({
    ResetSSHFunction
})
$form.Controls.Add($buttonSSHReset)

$buttonIPtools = New-Object System.Windows.Forms.Button
$buttonIPtools.Text = "Configuration de l'addresse IP"
$buttonIPtools.Size = New-Object System.Drawing.Size(300, 30)
$buttonIPtools.Location = New-Object System.Drawing.Point(50, 120)
$buttonIPtools.Add_Click({
    IPtools
})
$form.Controls.Add($buttonIPtools)

$buttonNetCard = New-Object System.Windows.Forms.Button
$buttonNetCard.Text = "Afficher les cartes reseaux"
$buttonNetCard.Size = New-Object System.Drawing.Size(300, 30)
$buttonNetCard.Location = New-Object System.Drawing.Point(50, 170)
$buttonNetCard.Add_Click({
    Start-Process "ncpa.cpl"
})
$form.Controls.Add($buttonNetCard)

$buttonFirewall = New-Object System.Windows.Forms.Button
$buttonFirewall.Text = "Firewall - Settings"
$buttonFirewall.Size = New-Object System.Drawing.Size(300, 30)
$buttonFirewall.Location = New-Object System.Drawing.Point(50, 220)
$buttonFirewall.Add_Click({  
    firewallfun
})
$form.Controls.Add($buttonFirewall)

$buttonMelangerVol = New-Object System.Windows.Forms.Button
$buttonMelangerVol.Text = "Melangeur de volume - Windows 10"
$buttonMelangerVol.Size = New-Object System.Drawing.Size(300, 30)
$buttonMelangerVol.Location = New-Object System.Drawing.Point(50, 270)
$buttonMelangerVol.Add_Click({  
    Start-Process "sndvol.exe"
})
$form.Controls.Add($buttonMelangerVol)

$buttonQuitter = New-Object System.Windows.Forms.Button
$buttonQuitter.Text = "Quitter"
$buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
$buttonQuitter.Location = New-Object System.Drawing.Point(50, 570)
$buttonQuitter.Add_Click({
    $form.Close()
})

$form.Controls.Add($buttonQuitter)
$form.ShowDialog()
