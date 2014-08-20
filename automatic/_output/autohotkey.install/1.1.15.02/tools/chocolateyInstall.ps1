﻿$name   = 'autohotkey.install'
$url = 'http://ahkscript.org/download/1.1/AutoHotkey111502_Install.exe'
$url64 = $url
$silent = '/S'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64  
if($is64bit) { $silent += ' /x64' }
 
Install-ChocolateyPackage $name 'exe' $silent $url $url64
