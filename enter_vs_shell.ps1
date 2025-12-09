$VsInstallPath = "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools"
Import-Module "$VsInstallPath\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell -InstallPath $VsInstallPath -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
