# Change temporary region to France (EEA region) for Edge uninstallation
[microsoft.win32.registry]::SetValue('HKEY_USERS\.DEFAULT\Control Panel\International\Geo', 'Nation', 84, [Microsoft.Win32.RegistryValueKind]::String) | Out-Null

# Uninstall Edge Stable
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

# Restore original region
$microsoft.win32.registry]::SetValue('HKEY_USERS\.DEFAULT\Control Panel\International\Geo', 'Nation', [microsoft.win32.registry]::GetValue('HKEY_USERS\.DEFAULT\Control Panel\International\Geo', 'Nation', [Microsoft.Win32.RegistryValueKind]::String), [Microsoft.Win32.RegistryValueKind]::String) | Out-Null

# Uninstall Edge components and related registry keys
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" -Name "NoRemove" -ErrorAction SilentlyContinue | Out-Null

Remove-Item -Path "Computer\\HKEY_CLASSES_ROOT\\MSEdgePDF" -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "Computer\\HKEY_CLASSES_ROOT\\MSEdgeHTM" -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "Computer\\HKEY_CLASSES_ROOT\\MSEdgeMHT" -ErrorAction SilentlyContinue | Out-Null

Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" -Recurse -ErrorAction SilentlyContinue | Out-Null

# Uninstall EdgeUpdate Client
$edgeUpdateRegistryPath = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate'
if (Test-Path -Path $edgeUpdateRegistryPath) {
    $uninstallCmdLine = (Get-ItemProperty -Path $edgeUpdateRegistryPath).UninstallCmdLine
    if ($uninstallCmdLine) {
        Start-Process cmd.exe "/c $uninstallCmdLine" -WindowStyle Hidden -Wait
    }
}

Write-Host "Microsoft Edge and related components have been uninstalled."
