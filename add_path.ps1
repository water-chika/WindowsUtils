param(
    [Parameter(Mandatory=$true)]
    [string]$Path,
    $ResolvePath = $true
)

if ($ResolvePath) {
    $Path = Resolve-Path $Path
}

$Path = $Path + ";" + [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", $Path, [System.EnvironmentVariableTarget]::Machine)
Write-Output "Path updated successfully."
