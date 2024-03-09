#SCRIPT EXTRAER DATOS DE NOMBRES COMPUTERS
#DEL COMPONENTE SMS_CLIENT_CONFIG_MANAGER
#Y EXPORTAR A CSV

$datosCsv = Import-Csv -Path "C:\exports\1week.csv"

# Patrón para identificar texto entre comillas
$patron = '"([^"]+)"'

# Lista para almacenar los datos extraídos
$datosExtraidos = @()

foreach ($fila in $datosCsv) {
    foreach ($propiedad in $fila.PSObject.Properties) {
        if ($propiedad.Value -match $patron) {
            # Agregar cada coincidencia a la lista de datos extraídos
            $datosExtraidos += $matches[1]
        }
    }
}
$datosExtraidos | ForEach-Object { Write-Host $_ }

# Eliminar duplicados y convertir en objetos para CSV
$objetosParaCsv = $datosExtraidos | Sort-Object -Unique | ForEach-Object { [PSCustomObject]@{Valor = $_} }

#--------------------------------------------------------------------------------
# Exportar a CSV
$objetosParaCsv | Export-Csv -Path "C:\exports\datosExtraidosUnicos2.csv" -NoTypeInformation
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
#ESTA PARTE LA OMITO PARA LUEGO GENERAR UN HASTABLE
#COMPROBAR SI RESUELVE POR DNS

<# foreach ($nombreComputadora in $datosExtraidos) {
    try {
        # Intenta resolver el nombre de la computadora por DNS
        $resultado = Resolve-DnsName -Name $nombreComputadora -ErrorAction Stop
        Write-Host "El nombre de computadora '$nombreComputadora' se resuelve a $($resultado.IPAddress)."
    } catch {
        # Maneja el caso en que la resolución de DNS falle
        Write-Host "El nombre de computadora '$nombreComputadora' no se pudo resolver por DNS."
    }
}

#>
#--------------------------------------------------------------------------------
#PRUEBA DE VARIABLE $DATOSEXTRAIDOS PARA COMPROBAR QUE SE HAYAN EXTRAIDO LOS DATOS
 $datosExtraidos = @("GM08XKS7", "GM08XJ4X", "GM08XKQK", "GM08XJ6E", "GM08XKT0", "GM08XJ5R", "PC2J2GZ7", "PC2HZ39W", "GM08XJ68", "GM08XJ6K", "GM08XKQS", "GM08XJ64", "GM08XKTG", "GM08XKQD", "GM08XKT6", "GM08XKQY", "GM08XKQX", "GM08XKRM")
#--------------------------------------------------------------------------------

#CREAR UN HASH TABLE PARA ALMACENAR LOS RESULTADOS



#EXPORTSTART RESULTADOS DE HASTABLE RESULTADOS DNS A UN ARCHIVO CSV"

$resultadosDns | Export-Csv -Path "C:\EXPORTS\resultadosDns.csv" -NoTypeInformation

# Importar los valores de una ARCHIVO CVS Y LUEGO CREAR UN ARRAY CON ELLOS
$datos = Import-Csv -Path "C:\EXPORTS\resultadosDns.csv"
$datos = $datos | ForEach-Object { $_.NombreComputadora }



