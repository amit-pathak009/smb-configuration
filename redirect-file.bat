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

REM Refresh Explorer to apply changes
echo Restarting Windows Explorer...
taskkill /f /im explorer.exe
start explorer.exe

echo Done. Please verify the changes.
pause
