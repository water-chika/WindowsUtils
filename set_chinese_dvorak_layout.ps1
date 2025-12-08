# set Microsoft pinyin input system to use qwerty layout
Set-ItemProperty -Path "hklm:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000804" -Name "Layout File" -Value "KBDUS.DLL"
