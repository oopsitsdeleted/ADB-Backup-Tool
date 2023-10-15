@echo off
::misc
title Restore
adb start-server > nul
echo hold on starting adb


:Intro
cls
call :art
echo ADB Pull Backup Tool (That actually retains dates) Restorer V1                                                                 
timeout /T 1 /NOBREAK > nul

  
:: Check for connected devices
:errorcheck
for /f "tokens=1" %%a in ('adb devices ^| findstr "device$"') do (
    set deviceFound=1
)

if "%deviceFound%"=="1" (
    goto :restore
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


:restore
cls
echo Restoring... (Don't worry if it says it's restoring something you didn't backup)
adb push Pictures /sdcard/Pictures -a -p
adb push DCIM /sdcard/DCIM -a -p
adb push Download /sdcard/Download -a -p
adb push Movies /sdcard/Movies -a -p
adb push Documents /sdcard/Documents -a -p
adb push Music /sdcard/Music -a -p


:end
cls
call :art
msg * Restore Complete. Your phone will now automatically restart because Android MediaStore won't recognise the files if it doesn't
adb reboot
echo Terminal window will now automatically close in 10 seconds.
timeout /T 10 > nul

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
