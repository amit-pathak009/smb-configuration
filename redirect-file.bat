@echo off
echo Applying registry changes for User Shell Folders...

REM Writing registry entries
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop /t REG_EXPAND_SZ /d "Z:\Desktop" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Documents /t REG_EXPAND_SZ /d "Z:\Documents" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Downloads /t REG_EXPAND_SZ /d "Z:\Downloads" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Pictures /t REG_EXPAND_SZ /d "Z:\Pictures" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Videos /t REG_EXPAND_SZ /d "Z:\Videos" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Music /t REG_EXPAND_SZ /d "Z:\Music" /f

echo Registry changes applied.

REM Copy the contents of the user's folders to the Z:\ server location

REM Copying Documents folder
echo Copying Documents folder...
xcopy /E /I /H /Y "%USERPROFILE%\Documents" "Z:\Documents\"

REM Copying Downloads folder
echo Copying Downloads folder...
xcopy /E /I /H /Y "%USERPROFILE%\Downloads" "Z:\Downloads\"

REM Copying Pictures folder
echo Copying Pictures folder...
xcopy /E /I /H /Y "%USERPROFILE%\Pictures" "Z:\Pictures\"

REM Copying Videos folder
echo Copying Videos folder...
xcopy /E /I /H /Y "%USERPROFILE%\Videos" "Z:\Videos\"

REM Copying Music folder
echo Copying Music folder...
xcopy /E /I /H /Y "%USERPROFILE%\Music" "Z:\Music\"

echo Data copied to Z:\ drive.

REM Restart Windows Explorer to apply the registry changes
echo Restarting Windows Explorer...
taskkill /f /im explorer.exe
start explorer.exe

echo Done. Please verify the changes and copied data.
pause
