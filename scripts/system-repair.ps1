Start-Process PowerShell -ArgumentList "Write-Host '(1/4) Chkdsk' -ForegroundColor Green; Chkdsk /scan;
Write-Host '`n(2/4) SFC - 1er scan' -ForegroundColor Green; sfc /scannow;
Write-Host '`n(3/4) DISM' -ForegroundColor Green; DISM /Online /Cleanup-Image /Restorehealth;
Write-Host '`n(4/4) SFC - 2eme scan' -ForegroundColor Green; sfc /scannow;
Read-Host '`nReparation systeme termine . Appuyez sur ENTRER pour terminer !'" -verb runas