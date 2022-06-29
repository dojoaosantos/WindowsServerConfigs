#Script Configuración Inicial Windows Server
#--------------------------------------------
# 1. Cambiar el nombre del server
Rename-Computer -ComputerName "$env:computername" -NewName "Activedirect02" -Force
#--------------------------------------------
# 2. Cambiar la zona horaria (esta es la zona horaria UTC-5)
# Para obtener el ID de la zona horaria elegida se debe ejecutar el siguiente comando:
# Get-TimeZone -ListAvailable | Format-Table
#--------------------------------------------
Set-TimeZone -id "SA Pacific Standard Time"
#--------------------------------------------
# 3. Instalar Chrome
#--------------------------------------------
$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
#--------------------------------------------
# 4. Reiniciar Server
#--------------------------------------------
Restart-Computer
echo "Restarting..."
