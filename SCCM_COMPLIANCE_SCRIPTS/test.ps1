# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users in the "contoso.com" domain whose usernames contain "ert"
$users = Get-ADUser -Filter {SamAccountName -like "*ert*"} -Server "contoso.com"

# Output the usernames of the matching users
$users | Select-Object SamAccountName