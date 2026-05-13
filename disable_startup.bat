    @echo off
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

if exist "%STARTUP%\VimCapslockArrows.lnk" (
    del "%STARTUP%\VimCapslockArrows.lnk"
)

:: На всякий случай удаляем .ahk, если он был скопирован туда вручную вместо ярлыка
if exist "%STARTUP%\VimCapslockArrows.ahk" (
    del "%STARTUP%\VimCapslockArrows.ahk"
)

echo ------------------------------------------------
echo Autostart successfully disabled for Vim arrows script. Link: github.com
echo ------------------------------------------------
pause
