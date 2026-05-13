& $PSScriptRoot/add_path.ps1 .
& $PSScriptRoot/customize_powershell.ps1
& $PSScriptRoot/enable_sshd.ps1
& $PSScriptRoot/hide_recycle_bin.ps1
& $PSScriptRoot/set_chinese_dvorak_layout.ps1
& $PSScriptRoot/set_windows_theme.ps1 0
& $PSScriptRoot/enable_dev_mode.ps1 0

winget install --id Microsoft.PowerShell --source winget
winget install --id Vim.Vim --source winget
& $PSScriptRoot/add_path.ps1 'C:/Program Files/Vim/vim92'
winget install --id Microsoft.VisualStudioCode --source winget
winget install --id GlavSoft.TightVNC --source winget

