$computerName = "DCOWLEYES01" # Replace with the actual computer name

# Import the SCCM PowerShell module
Import-Module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')

# Check if the SCCM client is installed on the computer
$ccmClient = Get-CMDevice -Name $computerName

if ($ccmClient) {
    Write-Host "SCCM client is installed on $computerName."
    
    # Get the client version
    $clientVersion = $ccmClient.ClientVersion
    Write-Host "Client version: $clientVersion"
} else {
    Write-Host "SCCM client is not installed on $computerName."
}
