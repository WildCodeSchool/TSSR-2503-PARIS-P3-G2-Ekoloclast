$backupTarget = "D:"
$version = (wbadmin get versions -backupTarget:$backupTarget | Select-String "Version identifier").Line.Split(":")[1].Trim()

Write-Host "Dernière version détectée : $version"
Read-Host "Appuie sur Entrée pour lancer la restauration vers C:\RecoveredData"

wbadmin start recovery -version:$version -itemType:File -items:C:\ImportantData -recoveryTarget:C:\RecoveredData -quiet
