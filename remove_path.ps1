param(
    [Parameter(Mandatory=$true)]
    [string]$Path,
    $ResolvePath = $true,
    $RemoveFromCurrentEnv = $true
)

if ($ResolvePath) {
    $Path = Resolve-Path $Path
}

if ($RemoveFromCurrentEnv) {
	$env:PATH = $env:PATH -replace [regex]::Escape($Path + ';'), ''
}

$Path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$paths = $Path -split ';' | Select-Object -Unique | Where-Object { $_ -ne $Path }
$Path = [string]::Join(';', $paths)
[System.Environment]::SetEnvironmentVariable("PATH", $Path, [System.EnvironmentVariableTarget]::Machine)
Write-Output "Path updated successfully."
