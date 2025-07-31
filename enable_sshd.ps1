param(
    $CopyWaterKey=$false,
    $CheckIsAdministrator=$true
)

if ($CheckIsAdministrator) {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $is_admin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (!$is_admin) {
        Write-Error "Need run as administrator"
        throw "Not Run as administrator"
    }
}

Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP(public)" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP(public)' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP(public)' -DisplayName 'OpenSSH Server (sshd)(public)' -Profile Any -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP(public)' has been created and exists."
}

if ($CopyWaterKey) {
    scp $PSScriptRoot/water.pub $env:ProgramData/ssh/administrators_authorized_keys
}