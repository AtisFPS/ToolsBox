# ID of the plan to duplicate
$sourceGUID = "e9a42b02-d5df-448d-aa00-03f14749eb61"


$scriptPath = $MyInvocation.MyCommand.Path
$directoryPath = Split-Path -Path $scriptPath -Parent

$duplicateOutputFilePath = Join-Path -Path $directoryPath -ChildPath "duplicate_output.txt"
$newPlanInfoFilePath = Join-Path -Path $directoryPath -ChildPath "new_plan_info.txt"

# Execute the command to duplicate the power plan
$duplicateOutput = powercfg /duplicatescheme $sourceGUID

try {
    $duplicateOutput | Out-File -FilePath $duplicateOutputFilePath -Append -Encoding utf8 -Force
    $duplicateOutput | Out-File -FilePath $newPlanInfoFilePath -Append -Encoding utf8 -Force

    Write-Output "The output of 'powercfg /duplicatescheme' has been added to $duplicateOutputFilePath and $newPlanInfoFilePath."
} catch {
    Write-Error "Error writing to the files: $_"
}

$content = Get-Content -Path $newPlanInfoFilePath -Encoding utf8
$guidFilePath = Join-Path -Path $directoryPath -ChildPath "guid.txt"
$nameFilePath = Join-Path -Path $directoryPath -ChildPath "name.txt"
$guid = $null
$name = $null

foreach ($line in $content) {
    if ($line -match "GUID du mode de gestion de l'alimentation\s*:\s*(\S+)\s*\(([^)]+)\)") {
        $guid = $matches[1]
        $name = $matches[2]
        
        $guid | Out-File -FilePath $guidFilePath -Encoding utf8 -Force
        $name | Out-File -FilePath $nameFilePath -Encoding utf8 -Force

        Write-Output "GUID: $guid has been saved to $guidFilePath"
        Write-Output "Name: $name has been saved to $nameFilePath"
    }
}

if (-not ($guid -and $name)) {
    Write-Output "No GUID or name found in $newPlanInfoFilePath. Check the content format."
}

$guidFromFile = Get-Content -Path $guidFilePath -Encoding utf8
$nameFromFile = "ChrisTitus - UltimatePowerPlan"


try {
    if ($guidFromFile -and $nameFromFile) {

        $changeNameOutput = powercfg /changename $guidFromFile $nameFromFile
        Write-Output "The power plan name has been changed. Output:"
        Write-Output $changeNameOutput

        $setActiveOutput = powercfg /setactive $guidFromFile
        Write-Output "The power plan has been set as active. Output:"
        Write-Output $setActiveOutput
    } else {
        Write-Output "GUID or name missing. Ensure that guid.txt and name.txt contain the necessary information."
    }
} catch {
    Write-Error "Error executing powercfg commands: $_"
}
