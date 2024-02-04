# Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ADUsers variable
$ADUsers = Import-Csv C:\IMPORT\NewUsersFinal.csv -Delimiter ";"

# Define UPN
$UPN = "OWLEYES.MAGIC"

# Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

    #Read user data from each field in each row and assign the data to a variable as below
    $username = $User.username
    $password = $User.password
    $firstname = $User.firstname
    $lastname = $User.lastname
    $initials = $User.initials
    $OU = $User.ou #This field refers to the OU the user account is to be created in
    $email = $User.email
    $streetaddress = $User.streetaddress
    $city = $User.city
    $zipcode = $User.zipcode
    $state = $User.state
    $telephone = $User.telephone
    $jobtitle = $User.jobtitle
    $company = $User.company
    $department = $User.department

    # Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$UPN" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Initials $initials `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path $OU `
            -City $city `
            -PostalCode $zipcode `
            -Company $company `
            -State $state `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -EmailAddress $email `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True

        # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"




# Haciéndolo pero usando hashtable


# Store the data from NewUsersFinal.csv in the $ADUsers variable
$usuarios = Import-Csv C:\IMPORT\au-500.csv -Delimiter ";"

# Importar datos de Excel
$usuarios = Import-Excel -Path $rutaArchivoExcel

# Importar usuarios a Active Directory
foreach ($usuario in $usuarios) {
    # Crear un nuevo objeto de usuario en AD con los datos de Excel
    $parametrosUsuario = @{
        SamAccountName = $usuario.SamAccountName
        Name           = "$($usuario.FirstName) $($usuario.LastName)"
        GivenName      = $usuario.FirstName
        Surname        = $usuario.LastName
        city           = $usuario.city
        state          = $usuario.state
        streetaddress  = $usuario.streetaddress
        Enabled        = $true
        postalcode     = $usuario.postalcode
        emailaddress   = $usuario.emailaddress
        officephone    = $usuario.telephoneNumber
        DisplayName    = "$($usuario.FirstName) $($usuario.LastName)"
        Path           = $usuario.ou 
        Department     = $usuario.department
        Company        = $usuario.company
        UserPrincipalName ="$usuario@owleyes.magic"
        country        = "AU"
        AccountPassword = (ConvertTo-SecureString -AsPlainText "6Agosto1973" -Force)
        ChangePasswordAtLogon = $false
    }

    try {
        New-ADUser @parametrosUsuario
        Write-Host "Usuario $($usuario.SamAccountName) creado."
    } catch {
        Write-Host "Error al crear el usuario $($usuario.SamAccountName): $_"
    }
}



####_________________________________________


Get-ADUser -identity "GladysRim"  -Properties 


get-help Set-ADUser -ShowWindow


$importusers=Get-ADUser -filter * -Properties * -SearchBase "ou=import,dc=owleyes,dc=magic" 
foreach ($user in $importusers){
Set-ADUser -Identity $user -country "US"
}

$USER.SamAccountName
