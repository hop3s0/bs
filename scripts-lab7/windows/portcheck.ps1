param([Parameter(Mandatory = $true)][int]$Port)

Write-Host "Service registered for port $Port (services file):"
Select-String -Path "$env:SystemRoot\System32\drivers\etc\services" -Pattern "\s$Port/(tcp|udp)" | ForEach-Object { $_.Line }

$open = @(Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue) +
        @(Get-NetUDPEndpoint -LocalPort $Port -ErrorAction SilentlyContinue)

if ($open) {
    Write-Host "Port $Port open: YES"
    $open | Format-Table LocalAddress, LocalPort, OwningProcess, @{ n = 'Program'; e = { (Get-Process -Id $_.OwningProcess).ProcessName } } | Out-Host
} else {
    Write-Host "Port $Port open: NO"
}
