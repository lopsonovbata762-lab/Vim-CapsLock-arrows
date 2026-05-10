@echo off

set STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

del "%STARTUP%\VimCapslockArrows.lnk"

echo Autostart disabled
pause