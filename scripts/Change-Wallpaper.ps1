Install-Module -Name WindowsDesktopBackground 
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