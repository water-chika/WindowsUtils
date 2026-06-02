$destination = $PROFILE.CurrentUserAllHosts
$directory = Split-Path --parent $destination
while (-not (Get-Item $directory)) {
	New-Item -ItemType Directory $directory
}
Copy-Item powershell_profile.ps1 $PROFILE.CurrentUserAllHosts
