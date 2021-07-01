
Clear-Host
Write-Host "Installing tldag-version"

$UserHome = (Get-Item -Path "~").FullName
$InstallDir = [System.IO.Path]::Combine($UserHome, "tldag-version")
$ZipPath = [System.IO.Path]::Combine($InstallDir, "tldag-version.zip")
$ExePath = [System.IO.Path]::Combine($InstallDir, "tldag-version.exe")
$RegistryKey = "Registry::HKCU\Environment"

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

$OldPath = (Get-ItemProperty -Path $RegistryKey -Name "Path").Path

if ($OldPath.Contains($InstallDir))
{
    Write-Host "Path environment variable contains " $InstallDir
}
else
{
    Write-Host "Adjusting Path environment variable"

    $NewPath = $OldPath

    if (!$NewPath.EndsWith(";"))
    {
        $NewPath = $NewPath + ";"
    }

    $NewPath = $NewPath + $InstallDir
    Set-ItemProperty -Path "$RegistryKey" -Name "Path" -Value $NewPath
}
