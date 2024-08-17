# Vérifier si le script est exécuté en tant qu'administrateur
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Le script doit être exécuté en tant qu'administrateur." -ForegroundColor Red
    Start-Process powershell -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"" + $PSCommandPath + "`"") -Verb RunAs
    exit
}

# Définir temporairement la région sur la France (région EEA) pour la désinstallation d'Edge
$geoKey = "HKEY_USERS\.DEFAULT\Control Panel\International\Geo"
$nationKey = "Nation"

$originalNation = [Microsoft.Win32.Registry]::GetValue($geoKey, $nationKey, "")
if ($originalNation) {
    [Microsoft.Win32.Registry]::SetValue($geoKey, $nationKey, 84, [Microsoft.Win32.RegistryValueKind]::String) | Out-Null
}

# Désinstaller Edge Stable
$registryPath = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}'
if (Test-Path -Path $registryPath) {
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate' -Name "IsEdgeStableUninstalled" -ErrorAction SilentlyContinue | Out-Null
    Remove-ItemProperty -Path $registryPath -Name "experiment_control_labels" -ErrorAction SilentlyContinue | Out-Null

    $uninstallString = (Get-ItemProperty -Path $registryPath).UninstallString
    $uninstallArguments = (Get-ItemProperty -Path $registryPath).UninstallArguments + " --force-uninstall --delete-profile"

    if (Test-Path -Path $uninstallString) {
        Start-Process -FilePath $uninstallString -ArgumentList $uninstallArguments -Wait -NoNewWindow -Verbose
    }
}

# Restaurer la région d'origine
if ($originalNation) {
    [Microsoft.Win32.Registry]::SetValue($geoKey, $nationKey, $originalNation, [Microsoft.Win32.RegistryValueKind]::String) | Out-Null
}

# Désinstaller les composants Edge et les clés de registre associées
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null

Remove-Item -Path "Computer\HKEY_CLASSES_ROOT\MSEdgePDF" -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "Computer\HKEY_CLASSES_ROOT\MSEdgeHTM" -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "Computer\HKEY_CLASSES_ROOT\MSEdgeMHT" -ErrorAction SilentlyContinue | Out-Null

Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" -Recurse -ErrorAction SilentlyContinue | Out-Null

# Désinstaller le client EdgeUpdate
$edgeUpdateRegistryPath = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate'
if (Test-Path -Path $edgeUpdateRegistryPath) {
    $uninstallCmdLine = (Get-ItemProperty -Path $edgeUpdateRegistryPath).UninstallCmdLine
    if ($uninstallCmdLine) {
        Start-Process cmd.exe -ArgumentList "/c $uninstallCmdLine" -WindowStyle Hidden -Wait
    }
}

Write-Host "Microsoft Edge et les composants associés ont été désinstallés."