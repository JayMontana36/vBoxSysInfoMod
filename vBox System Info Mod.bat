@echo off
:PreInit
set title=vBoxSysInfoMod - VirtualBox VM System Information Modifier v5.2 Final by JayMontana36
TITLE %title%
set vBoxInstallLocation=C:\Program Files\Oracle\Virtualbox

:vBoxLocationInit
echo Starting %title%...
IF NOT EXIST "%vBoxInstallLocation%" (goto vBoxLocateFailed) else IF NOT EXIST "%vBoxInstallLocation%\VBoxManage.exe" (goto vBoxLocateFailed) else set vBox="%vBoxInstallLocation%\VBoxManage.exe"

:ModifyVM
cls
echo %title%
echo.
%vBox% list vms
echo.
set /p VMname="Which vBox VM do you wish to modify? "
@REM for /f "tokens=1 delims={" %%F in ('"%vBox% list vms | findstr /C:"%VMname%""') do set _VMname=%%F
@REM IF ["%_VMname%"] NEQ [\"%VMname%\"] goto ModifyVM
for /f "tokens=1 delims=firmware=" %%F in ('"%vBox% showvminfo "%VMname%" --machinereadable | findstr firmware"') do set _vmMode=%%~F
IF [%_vmMode%] EQU [BIOS] (set fw=pcbios) else IF [%_vmMode%] EQU [EFI] (set fw=efi) else (goto ModifyVM)
set /p SYSven="New System Manufacturer? "
set /p SYSprod="New System Model? "
set /p SYSdate="New BIOS Date (in M/D/YYYY or MM/DD/YYYY)? "

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
cls
echo %title%
echo.

:ModifyVMprocess
echo Suppressing VM Indications in TaskManager and other areas for "%VMname%"
echo ...
%vBox% modifyvm "%VMname%" --paravirtprovider none
echo Applying System Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVersion" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSKU" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemFamily" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo Applying BIOS Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseDate" "%SYSdate%"
echo Applying Motherboard Information to vBox "%VMname%" in %_VMmode% Mode.
echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardAssetTag" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardLocInChass" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardBoardType" "10"
echo.
echo Complete!
echo.
echo Successfully applied vBox System Information to vBox VM "%VMname%" in %_VMmode% Mode!
echo.
pause
echo.
%vBox% startvm %vmname% --type gui
@REM start /MIN "%vBoxInstallLocation%\VirtualBox.exe"
goto end

:vBoxLocateFailed
cls
echo Failed to start %title%:
echo.
echo VirtualBox was not found in directory "%vBoxInstallLocation%"
echo.
set /p vBoxInstallLocation="Please provide the location of your current VirtualBox Installation: "
goto vBoxLocationInit

:end
cls
echo %title%
echo.
echo vBoxSysInfoMod - VirtualBox VM System Information Modifier was originally created and maintained by JayMontana36.
echo.
echo Official Website: https://sites.google.com/site/jaymontana36jasen - Bookmark my website for easy access if you'd like,
echo as I will be updating it in the future with new scripts, content, and programs. Site - https://goo.gl/3SCLQN
echo.
echo YouTube: https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA - Please subscribe if you haven't already, as 
echo I'll be uploading Tutorials and other content in the future. [JM36] JayMontana36 TV - https://goo.gl/aMknzL
echo.
echo So what do we do now? You may modify another VM by typing "modifyvm", open my website by typing "site", open my YouTube channel by typing "yt", or exit with "exit" (or of course, type something invalid to exit)
echo.
set /p sel="%username%@%computername%>"
goto %sel%

:exit
exit

:site
start https://sites.google.com/site/jaymontana36jasen
goto end

:yt
start https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA
goto end
