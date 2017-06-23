@echo off
:init
echo Starting VirtualBox VM System Information Changer by JayMontana36...
IF NOT EXIST "C:\Program Files\Oracle\Virtualbox" goto vBoxNotFound
cd "C:\Program Files\Oracle\Virtualbox"
IF NOT EXIST "VBoxManage.exe" goto vBoxNotFound

:ModifyVM
cls
echo VirtualBox VM System Information Changer by JayMontana36 v3 Final (Formly v2.1)
echo.
set /p vmID="Name of the VirtualBox VM to modify: "
set /p sysven="System Vendor (Dell, ASUS, Lenovo, ASRock, MSI, etc) to assign: "
set /p sysprod="Vendor Product (Optiplex 745, Rog 8, Optiplex GX620, etc): "
echo.
echo Does "%vmID%" run in BIOS mode or EFI mode? If you're unsure, enter BIOS.
echo Warning! Enter EFI ONLY IF YOU'RE POSITIVE "%vmID%" runs in EFI mode.
set /p mode="Enter either EFI or BIOS: "
echo.
echo Ready to modify System Information for vBox VM "%vmID%" in "%mode%" mode.
echo.
echo System info for VM "%vmID%" will be changed to "%sysven% %sysprod%"
echo.
echo Warning! Before continuing, please shut down any/all VirtualBox VMs!
echo You have been warned!
pause
goto ModifyVM%mode%

:exit
start VirtualBox.exe
exit

:ModifyVMbios
cls
echo VirtualBox VM System Information Changer by JayMontana36
echo.
echo Closing any and all VirtualBox VM Windows...
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe
echo.
echo Modifying System Information for vBox "%vmID%" in BIOS Mode.
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemProduct" "%sysprod%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVersion" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSKU" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemFamily" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo ...
echo Modifying BIOS Information for vBox "%vmID%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVersion" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSReleaseDate" "9/9/2016"
echo ...
echo Modifying BaseBoard Information for vBox "%vmID%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardProduct" "%sysprod%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVersion" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardSerial" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardAssetTag" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardLocInChass" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/pcbios/0/Config/DmiBoardBoardType" "10"
echo ...
echo Complete!
echo.
echo Successfully modified vBox System Information for vBox VM "%vmID%" in BIOS Mode!
pause
goto end

:ModifyVMefi
cls
echo VirtualBox VM System Information Changer by JayMontana36
echo.
echo Closing any and all VirtualBox VM Windows...
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe
echo.
echo Modifying System Information for vBox "%vmID%" in EFI Mode.
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "%sysprod%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemSKU" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemFamily" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo ...
echo Modifying BIOS Information for vBox "%vmID%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSVersion" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBIOSReleaseDate" "9/9/2016"
echo ...
echo Modifying BaseBoard Information for vBox "%vmID%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardVendor" "%sysven%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "%sysprod%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardVersion" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardSerial" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardAssetTag" "string:%random%"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardLocInChass" "<empty>"
VBoxManage setextradata "%vmID%" "VBoxInternal/Devices/efi/0/Config/DmiBoardBoardType" "10"
echo ...
echo Complete!
echo.
echo Successfully modified vBox System Information for vBox VM "%vmID%" in EFI Mode!
pause
goto end

:vBoxNotFound
cls
echo Failed to start VirtualBox VM System Information Changer by JayMontana36:
echo VirtualBox was not found on this system in the default install location.
echo Please install/reinstall VirtualBox in the default install location, or create a symlink/shortcut from the default install location.
pause
exit

:end
cls
echo vBox VM System Information Modifier was created and maintained by JayMontana36;
echo vBox VM System Information Modifier was tested by JayMontana36 and I_Like_Yo.
echo.
echo Official Website: https://sites.google.com/site/jaymontana36jasen - Bookmark my website for easy access if you'd like,
echo as I will be updating it in the future with new scripts, content, and programs.
echo.
echo YouTube: https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA/videos - Please subscribe if you haven't already, as 
echo I'll be uploading Tutorials and other content in the future.
echo.
echo So what do we do now? You may modify another VM by typing "modifyvm", you may view my website by typing "site", you may open my YouTube channel by typing "yt", or exit with "exit" (or of course, type something wrong to exit)
echo.
set /p sel="%username%@%computername%>"
goto %sel%

:site
start https://sites.google.com/site/jaymontana36jasen
goto end

:yt
start https://www.youtube.com/channel/UCMbJVrfppFn5aAz5C50LoZA/videos
goto end
