﻿$packageName = 'Brackets'
$version = '0.41.0.13418'

try {

    $bracketsRegistryVersion = $version -replace '^(\d+\.\d+)\..+', '$1'

    $params = @{
        PackageName = $packageName;
        FileType = 'msi';
        SilentArgs = '/q';
        Url = 'https://github.com/adobe/brackets/releases/download/release-0.41/Brackets.Release.0.41.msi';
    }

    $alreadyInstalled = Get-WmiObject -Class Win32_Product |
        Where-Object {($_.Name -eq 'Brackets') -and
        ($_.Version -match $bracketsRegistryVersion)}

    if ($alreadyInstalled) {
        Write-Host "Brackets $version is already installed. Skipping installation."
    } else {
        Install-ChocolateyPackage @params
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
