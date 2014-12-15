﻿$packageName = 'flashplayerplugin'
$version = '16.0.0.235'
$installArgs = '/quiet /norestart REMOVE_PREVIOUS=YES'
$url = 'http://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_16_plugin.msi'

$majorVersion = ([version] $version).Major

$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -eq "Adobe Flash Player $majorVersion Plugin" -and
  $_.Version -eq $version
}

try {
  if ($alreadyInstalled) {
    Write-Output $('Adobe Flash Player Plugin (for non-IE browsers) ' +
      $version + ' is already installed.')
  } else {
    Install-ChocolateyPackage $packageName 'msi' $installArgs $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
