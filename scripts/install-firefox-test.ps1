# Définition de l'URL de téléchargement de Firefox
$url = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=fr"

# Chemin de destination pour le téléchargement
$destination = "$env:TEMP\FirefoxSetup.exe"

# Fonction pour afficher une barre de progression
function Show-ProgressBar {
    param (
        [int]$Completed,
        [int]$Total
    )
    
    $percentComplete = ($Completed / $Total) * 100
    $ProgressBar = "[" + "-" * $percentComplete + (" " * (100 - $percentComplete)) + "]"
    Write-Progress -Activity "Téléchargement en cours..." -Status "Progression" -PercentComplete $percentComplete -CurrentOperation $ProgressBar
}

# Téléchargement du fichier
Invoke-WebRequest -Uri $url -OutFile $destination -Verbose:$false

# Afficher une barre de progression factice
$totalBytes = (Invoke-WebRequest -Uri $url -Method Head).Headers['Content-Length']
$bytesDownloaded = 0
while ($bytesDownloaded -lt $totalBytes) {
    $bytesDownloaded = (Get-Item $destination).Length
    Show-ProgressBar -Completed $bytesDownloaded -Total $totalBytes
    Start-Sleep -Milliseconds 500
}

# Supprimer la barre de progression une fois le téléchargement terminé
Write-Progress -Activity "Téléchargement terminé." -Completed
