param([string]$Iface = 'Ethernet')

while ($true) {
    Write-Host ''
    Write-Host "===== NETWORK MENU - Windows - interface $Iface ====="
    Write-Host '1) Interfaces and their status     (Get-NetAdapter)'
    Write-Host '2) Active TCP connections          (Get-NetTCPConnection)'
    Write-Host '3) Open ports and their programs   (Get-NetTCPConnection -State Listen)'
    Write-Host '4) Routing table                   (Get-NetRoute)'
    Write-Host '5) Card speed, duplex and link     (Get-NetAdapter)'
    Write-Host '6) Card driver                     (Get-NetAdapter)'
    Write-Host '7) Bytes sent and received         (Get-NetAdapterStatistics)'
    Write-Host '8) Traffic during 5 seconds        (Get-NetAdapterStatistics)'
    Write-Host '9) TCP connections by state        (Get-NetTCPConnection)'
    Write-Host '0) Exit'
    $op = Read-Host 'Option'
    switch ($op) {
        '1' { Get-NetAdapter | Format-Table Name, Status, LinkSpeed, MacAddress | Out-Host }
        '2' { Get-NetTCPConnection -State Established |
              Format-Table LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess | Out-Host }
        '3' { Write-Host 'OwningProcess = PID of the program using the port'
              Get-NetTCPConnection -State Listen | Sort-Object LocalPort |
              Format-Table LocalAddress, LocalPort, OwningProcess, @{ n = 'Program'; e = { (Get-Process -Id $_.OwningProcess).ProcessName } } | Out-Host }
        '4' { Write-Host 'NextHop 0.0.0.0 = directly connected. 0.0.0.0/0 = default route'
              Get-NetRoute -AddressFamily IPv4 | Format-Table DestinationPrefix, NextHop, InterfaceAlias, RouteMetric | Out-Host }
        '5' { Get-NetAdapter -Name $Iface | Format-List Name, Status, LinkSpeed, FullDuplex, MediaConnectionState | Out-Host }
        '6' { Get-NetAdapter -Name $Iface | Format-List InterfaceDescription, DriverProvider, DriverVersionString, DriverDate | Out-Host }
        '7' { Write-Host 'Counters since the adapter was enabled'
              Get-NetAdapterStatistics -Name $Iface | Format-List ReceivedBytes, SentBytes, ReceivedPacketErrors, OutboundPacketErrors | Out-Host }
        '8' { $before = Get-NetAdapterStatistics -Name $Iface
              Start-Sleep -Seconds 5
              $after = Get-NetAdapterStatistics -Name $Iface
              Write-Host "Received in 5 seconds: $($after.ReceivedBytes - $before.ReceivedBytes) bytes"
              Write-Host "Sent in 5 seconds:     $($after.SentBytes - $before.SentBytes) bytes" }
        '9' { Get-NetTCPConnection | Group-Object State | Format-Table Name, Count | Out-Host }
        '0' { exit }
        default { Write-Host 'Invalid option' }
    }
}
