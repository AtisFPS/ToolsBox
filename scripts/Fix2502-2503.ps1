$msgTitle = "OutilsBox - STS2 SISR"
$msgBody = "Instructions pour corriger les erreurs 2502 et 2503. Le script arrivera prochainement."

$etape1 = "1. Ouvrez le dossier C:\Windows\Temp afin que vous soyez directement dans le dossier."
$etape2 = "2. Changez le proprietaire du dossier et des fichiers herites pour 'Tout le monde'."
$etape3 = "3. Ajoutez l'utilisateur 'Tout le monde' et donnez-lui le controle total."

$etapeSuivante = @"
Les etapes suivantes doivent etre effectuees :
$etape1
$etape2
$etape3
"@

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class SoundPlayer {
    [DllImport("user32.dll")]
    public static extern bool MessageBeep(uint uType);
}
"@


[System.Windows.MessageBox]::Show($msgBody, $msgTitle)
Invoke-Item -Path "C:\Windows\Temp"
Start-Sleep -Seconds 1
[SoundPlayer]::MessageBeep(0x40)
[System.Windows.MessageBox]::Show($etapeSuivante, $msgTitle)

