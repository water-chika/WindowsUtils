
winget install --id Microsoft.WinDbg

$kd_path = (Get-Process kd).Path
if ($kd_path -eq $null) {
    Start-Process 'kdX64.exe' -ArgumentList '-k','net:port=50000'
    $kd_path = (Get-Process kd).Path
    Get-Process kd | Stop-Process
}

if (!(Get-NetFirewallRule -Name "Windows Kernel Debugger-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'Windows Kernel Debugger-TCP' does not exist, creating it..."
    New-NetFirewallRule -Program $kd_path -Name 'Windows Kernel Debugger-TCP' -DisplayName 'Windows Kernel Debugger-TCP' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort Any
} else {
    Write-Output "Firewall rule 'Windows Kernel Debugger-TCP' has been created and exists."
}

if (!(Get-NetFirewallRule -Name "Windows Kernel Debugger-UDP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'Windows Kernel Debugger-UDP' does not exist, creating it..."
    New-NetFirewallRule -Program $kd_path -Name 'Windows Kernel Debugger-UDP' -DisplayName 'Windows Kernel Debugger-UDP' -Enabled True -Direction Inbound -Protocol UDP -Action Allow -LocalPort Any
} else {
    Write-Output "Firewall rule 'Windows Kernel Debugger-UDP' has been created and exists."
}

