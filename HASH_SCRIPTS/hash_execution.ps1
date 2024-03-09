

$securePassword = ConvertTo-SecureString "6Agosto1973" -AsPlainText -Force
$securePassword | ConvertFrom-SecureString | Out-File "C:\export\user01pwd.txt"




# Path to the encrypted password file
$encryptedPasswordPath = "C:\export\user01pwd.txt"
# Username
$userName = "owleyes\administrator"

# Reading the encrypted password and converting it back to a secure string
$encryptedPassword = Get-Content $encryptedPasswordPath | ConvertTo-SecureString

# Creating the credential object
$credential = New-Object System.Management.Automation.PSCredential ($userName, $encryptedPassword)

# Starting the script as user01
Start-Process -FilePath "powershell.exe" -ArgumentList "-File C:\export\test.ps1" -Credential $credential

$securePassword = ConvertTo-SecureString "6Agosto1973" -AsPlainText -Force
$securePassword | ConvertFrom-SecureString -Key (1..64) | Out-File "C:\export\user01pwd.txt"

# Path to the encrypted password file
$encryptedPasswordPath = "C:\export\user01pwd.txt"
# Username
$userName = "owleyes\administrator"

# Reading the encrypted password and converting it back to a secure string
$encryptedPassword = Get-Content $encryptedPasswordPath | ConvertTo-SecureString -Key (1..64)

# Creating the credential object
$credential = New-Object System.Management.Automation.PSCredential ($userName, $encryptedPassword)

# Starting the script as user01
Start-Process -FilePath "powershell.exe" -ArgumentList "-File C:\export\test.ps1" -Credential $credential
