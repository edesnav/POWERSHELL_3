# Ruta del directorio a verificar_prueba_test
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine


# Verifica si el directorio existe
if (Test-Path -Path $directoryPath) {
    # Obtiene todo el contenido del directorio
    $directoryContent = Get-ChildItem -Path $directoryPath
    
    # Verifica si el directorio tiene contenido
    if ($directoryContent.Count -gt 0) {
        # Obtiene el subdirectorio más reciente
        $mostRecentSubdirectory = $directoryContent | Where-Object { $_.PSIsContainer } |  `
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
        
        # Elimina todos los subdirectorios excepto el más reciente
        $subdirectoriesToDelete = $directoryContent | `
        Where-Object { $_.PSIsContainer -and $_ -ne $mostRecentSubdirectory }
        $subdirectoriesToDelete | Remove-Item -Recurse -Force
    }
}

# Verifica nuevamente si el directorio existe y está vacío
$directoryExists = Test-Path -Path $directoryPath
$directoryContent = Get-ChildItem -Path $directoryPath
$directoryIsEmpty = $directoryExists -and ($directoryContent.Count -eq 0)

# Devuelve el estado de compliance
if (-not $directoryExists -or $directoryIsEmpty) {
    Write-Output "Compliant"
} elseif ($directoryContent.Count -eq 1 -or $directoryContent.Count -eq 0) {
    Write-Output "Compliant"
} else {
    Write-Output "Non-Compliant"
}




