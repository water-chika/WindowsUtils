$destination = $PROFILE.CurrentUserAllHosts
$directory = Split-Path -Parent $destination
while (-not (Get-Item $directory)) {
	New-Item -ItemType Directory $directory
	$directory = Split-Path -Parent $directory
}
Copy-Item powershell_profile.ps1 $PROFILE.CurrentUserAllHosts
Copy-Item powershell_profile.ps1 $PROFILE
