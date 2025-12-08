Set-PSReadlineOption -Edit "Emacs"
Import-Module "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell a68e13d3 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
