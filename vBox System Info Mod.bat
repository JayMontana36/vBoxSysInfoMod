@echo off
:init
set title=vBoxSysInfoMod - VirtualBox VM System Information Modifier v5.0 Experimental Alpha by JayMontana36
TITLE %title%
:vBoxLocationInit
echo Starting %title%...
C:
IF NOT EXIST "C:\Program Files\Oracle\Virtualbox" goto vBoxLocateFailed
cd "C:\Program Files\Oracle\Virtualbox"
IF NOT EXIST "VBoxManage.exe" goto vBoxLocateFailed

:ModifyVM
cls
echo %title%
echo.
VBoxManage list vms
echo.
set /p VMname="Which vBox VM do you wish to modify? "
@REM for /f "tokens=1 delims=*{" %%F in ('"VBoxManage list vms | findstr %VMname%"') do set _VMname=%%~F
@REM Set _VMname=%_VMname:"=%
@REM IF [%_VMname%] NEQ [%VMname%] goto ModifyVM
set /p SYSven="New System Manufacturer? "
set /p SYSprod="New System Model? "
set /p SYSdate="New BIOS Date (in M/D/YYYY or MM/DD/YYYY)? "
for /f "tokens=1 delims=firmware=" %%F in ('"VBoxManage showvminfo %VMname% --machinereadable | findstr firmware"') do set _vmMode=%%~F
IF [%_vmMode%] EQU [BIOS] set fw=pcbios
IF [%_vmMode%] EQU [EFI] set fw=efi

:ModifyVMsummary
cls
echo %title%
echo.
echo Summary:
echo Ready to modify vBox VM "%VMname%" whenever you're ready.
echo %_VMmode% Information will be changed to "%SYSven% %SYSprod%"
echo %_VMmode% Date will be changed to "%SYSdate%"
echo.
echo Warning: Before continuing, please shutdown any/all vBox VMs you care about;
echo failure to do so may result in data loss or data corruption for running VMs.
pause

:ModifyVMtaskkill
echo Force closing any and all VirtualBox VM windows...
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe

:ModifyVMproperties
cls
echo %title%
echo.
echo Suppressing VM Indications in TaskManager and other areas for "%VMname%"
echo ...
VBoxManage modifyvm "%VMname%" --paravirtprovider none
echo Applying System Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVendor" "%SYSven%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemProduct" "%SYSprod%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVersion" "<empty>"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSerial" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSKU" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemFamily" "<empty>"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo Applying BIOS Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVendor" "%SYSven%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVersion" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseDate" "%SYSdate%"
echo Applying Motherboard Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVendor" "%SYSven%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardProduct" "%SYSprod%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVersion" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardSerial" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardAssetTag" "string:%random%"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardLocInChass" "<empty>"
VBoxManage setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardBoardType" "10"
echo.
echo Complete!
echo.
echo Successfully applied vBox System Information to vBox VM "%VMname%" in %_VMmode% Mode!
echo.
start VirtualBox.exe
VBoxManage startvm %vmname% --type gui
pause
goto end

:exit
start VirtualBox.exe
exit

:vBoxLocateFailed
cls
echo Failed to start %title%:
echo VirtualBox was not found on this system in the default install location (Manually selecting it's location is not a thing yet).
echo Please install/reinstall VirtualBox in the default install location, or create a symlink/shortcut in the default install location.
pause
exit

:end
cls
echo vBox VM System Information Modifier is created and maintained by JayMontana36
echo.
echo Official Website: https://sites.google.com/site/jaymontana36jasen - Bookmark my website for easy access if you'd like,
echo as I will be updating it in the future with new scripts, content, and programs. Site - https://goo.gl/3SCLQN
echo.
echo YouTube: https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA - Please subscribe if you haven't already, as 
echo I'll be uploading Tutorials and other content in the future. [JM36] JayMontana36 TV - https://goo.gl/aMknzL
echo.
echo So what do we do now? You may modify another VM by typing "modifyvm", you may view my website by typing "site", you may open my YouTube channel by typing "yt", or exit with "exit" (or of course, type something invalid to exit)
echo.
set /p sel="%username%@%computername%>"
goto %sel%

:site
start https://sites.google.com/site/jaymontana36jasen
goto end

:yt
start https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA
goto end
