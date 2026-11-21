function Show-Host($ip) {
    $snmp = New-Object -ComObject olePrn.OleSNMP
    $snmp.Open($ip, 'aysr', 1, 2000)
    $idx = $snmp.Get(".1.3.6.1.2.1.4.20.1.2.$ip")
    Write-Host "===== $($snmp.Get('.1.3.6.1.2.1.1.5.0')) ($ip) ====="
    Write-Host 'Uptime (1/100 s):          ' $snmp.Get('.1.3.6.1.2.1.1.3.0')
    Write-Host 'CPU user / system / idle %:' $snmp.Get('.1.3.6.1.4.1.2021.11.9.0') '/' $snmp.Get('.1.3.6.1.4.1.2021.11.10.0') '/' $snmp.Get('.1.3.6.1.4.1.2021.11.11.0')
    Write-Host 'Memory total / free (kB):  ' $snmp.Get('.1.3.6.1.4.1.2021.4.5.0') '/' $snmp.Get('.1.3.6.1.4.1.2021.4.6.0')
    Write-Host 'Disk / used %:             ' $snmp.Get('.1.3.6.1.4.1.2021.9.1.9.1')
    Write-Host 'Processes:                 ' $snmp.Get('.1.3.6.1.2.1.25.1.6.0')
    Write-Host 'Bytes received / sent:     ' $snmp.Get(".1.3.6.1.2.1.2.2.1.10.$idx") '/' $snmp.Get(".1.3.6.1.2.1.2.2.1.16.$idx")
    Write-Host ''
    $snmp.Close()
}

while ($true) {
    Clear-Host
    Show-Host '10.2.78.55'
    Show-Host '10.2.78.58'
    Start-Sleep -Seconds 5
}
