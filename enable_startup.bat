@echo off
set "AHK_FILE=%~dp0VimCapslockArrows.ahk"
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

if exist "%AHK_FILE%" (
    powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%STARTUP%\VimCapslockArrows.lnk');$s.TargetPath='%AHK_FILE%';$s.Save()"
    echo ------------------------------------------------
    echo Autostart successfully enabled for Vim arrows script. Link: github.com
    echo ------------------------------------------------
) else (
    echo Error: VimCapslockArrows.ahk not found in this folder.
)

pause
