param (
    $SetDenyTSConnectionsAs0=$true,
    $EnableRemoteDesktopNetFirewallRule=$true,
    $CheckIsAdministrator=$true,
    $VerifyDenyTSConnectionIs0=$true
    )

if ($CheckIsAdministrator) {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $is_admin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (!$is_admin) {
        Write-Error "Need run as administrator"
        throw "Not Run as administrator"
    }
}

if ($SetDenyTSConnectionsAs0) {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
}

if ($EnableRemoteDesktopNetFirewallRule) {
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

if ($VerifyDenyTSConnectionIs0) {
    $result = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections"
    if ($result.fDenyTSConnections -eq 0) {
        Write-Output "Remote Desktop enabled successfully!"
    }
    else {
        Write-Output "Remote Desktop enabled failed!!!"
    }
}
