param(
    [Parameter(Mandatory=$true)]
    [string]$Path,
    $ResolvePath = $true,
    $AddToCurrentEnv = $true
)

if ($ResolvePath) {
    $Path = Resolve-Path $Path
}

if ($AddToCurrentEnv) {
	$env:PATH = "$Path;$env:PATH"
}

$Path = $Path + ";" + [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$paths = $Path -split ';' | Select-Object -Unique
$Path = [string]::Join(';', $paths)
[System.Environment]::SetEnvironmentVariable("PATH", $Path, [System.EnvironmentVariableTarget]::Machine)
Write-Output "Path updated successfully."
