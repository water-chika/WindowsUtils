param(
    [Parameter(ParameterSetName = 'Toggle')]
    [switch]$Toggle,
    [Parameter(ParameterSetName = 'Value')]
    [string]$Value
)

$theme_path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$Value = $Value
if ($Toggle) {
    if (1 -eq (Get-ItemProperty -Path $theme_path -Name "SystemUsesLightTheme").SystemUsesLightTheme) {
        $Value = 0
    }
    else {
        $Value = 1
    }
}

Set-ItemProperty -Path $theme_path -Name "SystemUsesLightTheme" -Value $Value
Set-ItemProperty -Path $theme_path -Name "AppsUseLightTheme" -Value $Value
