@echo off
::misc
title Backup
adb start-server
echo hold on starting adb

:Generate folder
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
  set year=%%c
  set month=%%b
  set day=%%a
)
set folder=Backups\%year%-%month%-%day%
mkdir %folder% 2>nul

:Intro
cls
call :art
echo ADB Pull Backup Tool (That actually retains dates) V1                                                                 
timeout /T 1 /NOBREAK > nul

  
:: Check for connected devices
:errorcheck
for /f "tokens=1" %%a in ('adb devices ^| findstr "device$"') do (
    set deviceFound=1
)

if "%deviceFound%"=="1" (
    goto :choose
) else (
    goto :error-nodevice
)



:error-nodevice
cls
echo Error!
echo No device was detected. Make sure that 'USB Debugging' is enabled on your phone and that it is connected to this PC. If it is, check your connection, try another USB port, ensure your device is unlocked and make sure to to press 'OK' when the 'Allow USB debugging?' popup appears.
echo.
echo Press any key to restart
pause >nul
goto Intro


:choose
setlocal EnableDelayedExpansion
set "all=0"
set "Pictures=0"
set "DCIM=0"
set "Download=0"
set "Movies=0"
set "Documents=0"
set "Music=0"

echo Select what you would like to be backed up:
echo.
echo 1. All
echo 2. Pictures
echo 3. DCIM
echo 4. Download
echo 5. Movies
echo 6. Documents
echo 7. Music
echo.
echo Example: 2 for Pictures or 4 5 for both Download and Movies
set /p choices="Enter your choice(s) (1-7): "

rem Modified for loop to handle spaces in user input
for %%i in (%choices%) do (
 for /f "tokens=*" %%a in ("%%i") do (
  if "%%a"=="1" (
   echo You selected "All"
   set "all=1"
  ) else if "%%a"=="2" (
   echo You selected "Pictures"
   set "Pictures=1"
  ) else if "%%a"=="3" (
   echo You selected "DCIM"
   set "DCIM=1"
  ) else if "%%a"=="4" (
   echo You selected "Download"
   set "Download=1"
  ) else if "%%a"=="5" (
   echo You selected "Movies"
   set "Movies=1"
  ) else if "%%a"=="6" (
   echo You selected "Documents"
   set "Documents=1"
  ) else if "%%a"=="7" (
   echo You selected "Music"
   set "Music=1"
  ) else (
   echo Invalid choice: %%a
  )
 )
)

if "!all!"=="1" call :all
if "!all!"=="0" (
  if "!Pictures!"=="1" call :Pictures
  if "!DCIM!"=="1" call :DCIM
  if "!Download!"=="1" call :Download
  if "!Movies!"=="1" call :Movies
  if "!Documents!"=="1" call :Documents
  if "!Music!"=="1" call :Music
)

goto :reformat

:all
cls
echo Backing Up Pictures...
adb pull /sdcard/Pictures %folder% -a -p
echo Backing Up DCIM...
adb pull /sdcard/DCIM %folder% -a -p
echo Backing Up Download...
adb pull /sdcard/Download %folder% -a -p
echo Backing Up Movies...
adb pull /sdcard/Movies %folder% -a -p
echo Backing Up Documents...
adb pull /sdcard/Documents %folder% -a -p
echo Backing Up Music...
adb pull /sdcard/Music %folder% -a -p
exit /b

:Pictures
cls
echo Backing Up Pictures...
adb pull /sdcard/Pictures %folder% -a -p
exit /b

:DCIM
cls
echo Backing Up DCIM...
adb pull /sdcard/DCIM %folder% -a -p
exit /b

:Download
cls
echo Backing Up Download...
adb pull /sdcard/Download %folder% -a -p
exit /b

:Movies
cls
echo Backing Up Movies...
adb pull /sdcard/Movies %folder% -a -p
exit /b

:Documents
cls
echo Backing Up Documents...
adb pull /sdcard/Documents %folder% -a -p
exit /b

:Music
cls
echo Backing Up Music...
adb pull /sdcard/Music %folder% -a -p
exit

:reformat
setlocal EnableDelayedExpansion
PowerShell -Command "Get-ChildItem -Path !folder! -Recurse | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name CreationTime -Value $_.LastWriteTime -Force }"

:copy
xcopy Restore.bat %folder% /H
attrib -H -S  %folder%\Restore.bat

:End
cls
call :art
msg * Backup Complete. Your backups are in the 'Backups' folder.
echo Terminal window will now automatically close in 10 seconds.
timeout /T 10

:art
echo ----------------------------------------------------------------------------------------------------------------
echo.
echo                                     d8b 888                  888          888          888                 888 
echo                                     Y8P 888                  888          888          888                 888 
echo                                         888                  888          888          888                 888 
echo  .d88b.   .d88b.  88888b.  .d8888b  888 888888 .d8888b   .d88888  .d88b.  888  .d88b.  888888 .d88b.   .d88888 
echo d88""88b d88""88b 888 "88b 88K      888 888    88K      d88" 888 d8P  Y8b 888 d8P  Y8b 888   d8P  Y8b d88" 888 
echo 888  888 888  888 888  888 "Y8888b. 888 888    "Y8888b. 888  888 88888888 888 88888888 888   88888888 888  888 
echo Y88..88P Y88..88P 888 d88P      X88 888 Y88b.       X88 Y88b 888 Y8b.     888 Y8b.     Y88b. Y8b.     Y88b 888 
echo  "Y88P"   "Y88P"  88888P"   88888P' 888  "Y888  88888P'  "Y88888  "Y8888  888  "Y8888   "Y888 "Y8888   "Y88888 
echo                   888                        
echo                   888                                                                                          
echo                   888                      
echo.
echo ----------------------------------------------------------------------------------------------------------------