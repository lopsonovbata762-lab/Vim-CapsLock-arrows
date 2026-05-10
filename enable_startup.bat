@echo off

set SCRIPT=%~dp0VimCapslockArrows.ahk
set STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%STARTUP%\VimCapslockArrows.lnk');$s.TargetPath='%SCRIPT%';$s.Save()"

echo Autostart enabled
pause