
Clear-Host
Write-Host "Installing tldag-version"

$UserHome = (Get-Item -Path "~").FullName
$InstallDir = [System.IO.Path]::Combine($UserHome, "tldag-version")
$ZipPath = [System.IO.Path]::Combine($InstallDir, "tldag-version.zip")
$ExePath = [System.IO.Path]::Combine($InstallDir, "tldag-version.exe")

Write-Host "Installation Directory: " $InstallDir

if ([System.IO.File]::Exists($ExePath))
{
    Write-Host "Already installed."
}
else
{
    Write-Host "Downloading tldag-version.zip"
    New-Item -Path $InstallDir -ItemType "directory" -ErrorAction Ignore | Out-Null
    Invoke-WebRequest -Uri "https://github.com/tldag/tldag-version/releases/download/latest/tldag-version.zip" -OutFile $ZipPath
    Expand-Archive -Path $ZipPath -DestinationPath $InstallDir
}
