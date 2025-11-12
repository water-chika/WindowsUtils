
foreach ($key in 'NewStartPanel', 'ClassicStartMenu') {
    $HideDesktopIconsPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\$key"
    Get-ItemProperty $HideDesktopIconsPath
    New-ItemProperty -Path $HideDesktopIconsPath -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -PropertyType DWord -Value 1
}