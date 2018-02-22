@echo off
:PreInit
set title=vBoxSysInfoMod - VirtualBox VM System Information Modifier v5.2-GUI Beta by JayMontana36
TITLE %title%
messagebox "%title%" "vBoxSysInfoMod - VirtualBox VM System Information Modifier v5.2-GUI Beta created and maintained by JayMontana36"
set vBoxInstallLocation=C:\Program Files\Oracle\Virtualbox

:vBoxLocationInit
@REM echo Starting %title%...
IF NOT EXIST "%vBoxInstallLocation%" (goto vBoxLocateFailed) else IF NOT EXIST "%vBoxInstallLocation%\VBoxManage.exe" (goto vBoxLocateFailed) else set vBox="%vBoxInstallLocation%\VBoxManage.exe"

:ModifyVM
@REM cls
@REM echo %title%
@REM echo.
@REM VBoxManage list vms
@REM echo.
@REM set /p VMname="Which vBox VM do you wish to modify? "
for /f %%n in ('inputbox.exe "%title%" "Enter the name of the vBox VM that you wish to modify" ""') do set VMname=%%n
@REM @REM for /f "tokens=1 delims=" %%F in ('"VBoxManage list vms | findstr %VMname%"') do set _VMname=%%~F
@REM @REM set _VMname=%_VMname:"=%
@REM @REM IF [%_VMname%] NEQ [%VMname%] goto ModifyVM
for /f "tokens=1 delims=firmware=" %%F in ('"%vBox% showvminfo "%VMname%" --machinereadable | findstr firmware"') do set _vmMode=%%~F
IF [%_vmMode%] EQU [BIOS] (set fw=pcbios) else IF [%_vmMode%] EQU [EFI] (set fw=efi) else (goto ModifyVM)
for /f %%v in ('inputbox.exe "%title%" "New System Manufacturer?" ""') do set SYSven=%%v
for /f %%p in ('inputbox.exe "%title%" "New System Model?" ""') do set SYSprod=%%p
for /f %%d in ('inputbox.exe "%title%" "New BIOS Date (in M/D/YYYY or MM/DD/YYYY)?" ""') do set SYSdate=%%d

:ModifyVMsummary
@REM cls
@REM echo %title%
@REM echo.
@REM echo Summary:
@REM echo Ready to modify vBox VM "%VMname%" whenever you're ready.
@REM echo %_VMmode% Information will be changed to "%SYSven% %SYSprod%"
@REM echo %_VMmode% Date will be changed to "%SYSdate%"
@REM echo.
@REM echo Warning: Before continuing, please shutdown any/all vBox VMs you care about;
@REM echo failure to do so may result in data loss or data corruption for running VMs.
@REM pause
messagebox "%title%" "Ready to modify vBox VM '%VMname%' whenever you're ready; %_VMmode% Information will be changed to '%SYSven% %SYSprod%', and the %_VMmode% Date will be changed to '%SYSdate%'."
messagebox "%title%" "Warning: Before continuing, please shutdown any/all vBox VMs that you care about; failure to do so may result in the loss of data and/or data corruption for any running VMs."
messagebox "%title%" "Whenever you're ready, you may push the 'OK' button to continue..."

:ModifyVMtaskkill
@REM echo Force closing any and all VirtualBox VM windows...
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe
@REM cls
@REM echo %title%
@REM echo.

:ModifyVMprocess
@REM echo Suppressing VM Indications in TaskManager and other areas for "%VMname%"
@REM echo ...
%vBox% modifyvm "%VMname%" --paravirtprovider none
@REM echo Applying System Information to vBox "%VMname%" in %_VMmode% Mode.
@REM echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVersion" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSKU" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemFamily" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
@REM echo Applying BIOS Information to vBox "%VMname%" in %_VMmode% Mode.
@REM echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseDate" "%SYSdate%"
@REM echo Applying Motherboard Information to vBox "%VMname%" in %_VMmode% Mode.
@REM echo ...
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVendor" "%SYSven%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardProduct" "%SYSprod%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVersion" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardSerial" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardAssetTag" "string:%random%"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardLocInChass" "<empty>"
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardBoardType" "10"
@REM echo.
@REM echo Complete!
@REM echo.
@REM echo Successfully applied vBox System Information to vBox VM "%VMname%" in %_VMmode% Mode!
messagebox "%title%" "Successfully applied vBox System Information to vBox VM '%VMname%' in %_VMmode% Mode!"
@REM echo.
@REM pause
@REM echo.
%vBox% startvm %vmname% --type gui
@REM start /MIN "%vBoxInstallLocation%\VirtualBox.exe"
goto end

:vBoxLocateFailed
@REM cls
@REM echo Failed to start %title%:
@REM echo.
@REM echo VirtualBox was not found in directory "%vBoxInstallLocation%"
@REM echo.
@REM set /p vBoxInstallLocation="Please provide the location of your current VirtualBox Installation: "
messagebox "%title%" "VirtualBox could not be located; please select the location of your current VirtualBox installation within the following dialog."
for /f %%L in ('folderbrowse.exe "%title% - Please provide the location of your current VirtualBox Installation:"') do set vBoxInstallLocation=%%L
goto vBoxLocationInit

:end
@REM cls
@REM echo %title%
@REM echo.
@REM echo vBoxSysInfoMod - VirtualBox VM System Information Modifier was originally created and maintained by JayMontana36.
@REM echo.
@REM echo Official Website: https://sites.google.com/site/jaymontana36jasen - Bookmark my website for easy access if you'd like,
@REM echo as I will be updating it in the future with new scripts, content, and programs. Site - https://goo.gl/3SCLQN
@REM echo.
@REM echo YouTube: https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA - Please subscribe if you haven't already, as 
@REM echo I'll be uploading Tutorials and other content in the future. [JM36] JayMontana36 TV - https://goo.gl/aMknzL
@REM echo.
@REM echo So what do we do now? You may modify another VM by typing "modifyvm", open my website by typing "site", open my YouTube channel by typing "yt", or exit with "exit" (or of course, type something invalid to exit)
@REM echo.
@REM set /p sel="%username%@%computername%>"
@REM goto %sel%

:exit
exit

:site
start https://sites.google.com/site/jaymontana36jasen
goto end

:yt
start https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA
goto end
