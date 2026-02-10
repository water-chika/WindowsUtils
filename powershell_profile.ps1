Set-PSReadlineOption -Edit "Emacs"
function prompt {
    "[$Env:UserName@$Env:COMPUTERNAME $(Get-Location)]> "
}
