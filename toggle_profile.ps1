param(
    $Value
)

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value $Value
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value $Value

if ($Value -eq 0) {
    Enable-Display -DisplayId 3

    Set-DisplayPrimary -DisplayId 3

    Start-Sleep 2

    Disable-Display -DisplayId 1
    Disable-Display -DisplayId 2
}
else {
    Enable-Display -DisplayId 1
    Enable-Display -DisplayId 2

    Set-DisplayPrimary -DisplayId 2

    Disable-Display -DisplayId 3
}