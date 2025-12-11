Set-PSReadlineOption -Edit "Emacs"
function prompt {
    "[$Env:User@$Env:COMPUTERNAME $(Get-Location)]> "
}
