Install-WindowsFeature SNMP-Service -IncludeManagementTools

$params = 'HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters'
New-ItemProperty -Path "$params\ValidCommunities" -Name 'aysr' -Value 4 -PropertyType DWord -Force
New-ItemProperty -Path "$params\PermittedManagers" -Name '2' -Value '10.2.78.55' -PropertyType String -Force
New-ItemProperty -Path "$params\PermittedManagers" -Name '3' -Value '10.2.78.58' -PropertyType String -Force
Restart-Service SNMP

New-NetFirewallRule -DisplayName 'SNMP aysr' -Direction Inbound -Protocol UDP -LocalPort 161 -Action Allow
