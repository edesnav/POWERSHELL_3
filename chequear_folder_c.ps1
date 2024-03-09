# Define la ruta del directorio a comprobar
$directoryPath = "C:\cache"

# Comprueba si el directorio existe
if (Test-Path -Path $directoryPath) {
    # Obtiene todos los archivos y subdirectorios dentro del directorio
    $items = Get-ChildItem -Path $directoryPath

    # Comprueba si hay contenido en el directorio
    if ($items.Count -gt 0) {
        # Elimina todos los archivos y subdirectorios dentro del directorio
        $items | ForEach-Object { Remove-Item $_.FullName -Force -Recurse }
    }

    # Comprueba nuevamente si el directorio está vacío
    $items = Get-ChildItem -Path $directoryPath
    $isDirectoryEmpty = $items.Count -eq 0

    # Muestra el resultado de la variable booleana
    Write-Output "El directorio está vacío: $isDirectoryEmpty"
} else {
    Write-Output "El directorio especificado no existe."
    # Si el directorio no existe, se podría considerar que está "vacío"
    $isDirectoryEmpty = $true
}

# Retorna el valor booleano
return $isDirectoryEmpty
