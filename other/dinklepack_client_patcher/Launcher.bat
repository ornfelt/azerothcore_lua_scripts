@echo off
:beginning
SET NAME=Dinklepack Launcher v2.4.6
TITLE %NAME%
COLOR 0B
set mod=%1
set mainfolder=%CD%

IF NOT EXIST "%mainfolder%\_Tools\Music\music.on" (
  IF NOT EXIST "%mainfolder%\_Tools\Music\music.off" (
    echo music > "%mainfolder%\_Tools\Music\music.on"
  )
)
if exist "%mainfolder%\_Tools\Music\music.on" set music=ON
if exist "%mainfolder%\_Tools\Music\music.off" set music=OFF

REM --- Settings ---

REM AzerothCore files name
set wowbuild=12340

REM Default MySQL settings
set host=127.0.0.1
set port=3306
set user=acore
set pass=acore

set characters=acore_characters
set world=acore_world
set login=acore_auth

REM --- Settings ---
:menu
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/launcher_intro.mp3 >nul
cls
echo.
echo [-------------------------------------------------]
echo      ____  _       __   __     ____             __  
echo     / __ \(_)___  / /__/ /__  / __ \____  _____/ /__
echo    / / / / / __ \/ //_/ / _ \/ /_/ / __ `/ ___/ //_/
echo   / /_/ / / / / / ,( / /  __/ ____/ /_/ / /__/ ,(   
echo  /_____/_/_/ /_/_/\_/_/\___/_/    \__,_/\___/_/\_\  v13.0
echo   Dinkledork @ https://www.patreon.com/Dinklepack5
echo.
echo [----------------------MySQL----------------------]
echo  Host: %host%
echo  Port: %port%
echo  User: %user%
echo  Pass: %pass%
echo [----------------------Menu-----------------------]
echo.
echo  1 - Launch Server
echo  2 - Launch Client
echo.
echo  3 - Control Panel
echo.
echo  4 - Version Checker
echo  5 - Downloads\Updates
echo.
echo  6 - Create\Edit Accounts
echo  7 - Backup\Restore Databases
echo.
echo  8 - Tools
echo  9 - ReadMe
echo.
echo  10 - Music [%music%]
echo.
echo  11 - Donate
echo.
echo  12 - Close Launcher
echo.
set /P menu=Enter a number: 
if "%menu%"=="1" (goto servers_start)
if "%menu%"=="2" (goto client_start)
if "%menu%"=="3" (goto server_controls)
if "%menu%"=="4" (goto version_checker)
if "%menu%"=="5" (goto download_server)
if "%menu%"=="6" (goto account_tools)
if "%menu%"=="7" (goto backup_sql)
if "%menu%"=="8" (goto tools)
if "%menu%"=="9" (goto read_me)
if "%menu%"=="10" (goto music_switch)
if "%menu%"=="11" (goto donate)
if "%menu%"=="12" (goto close_launcher)
if "%menu%"=="pizza" (goto pizza)
goto menu

:servers_start
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_glue_enter_world_button.mp3 >nul
cls
echo.
start MySQL.bat
timeout /t 20
start authserver.exe
timeout /t 10
start worldserver.exe
goto menu

:client_start
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_glue_enter_world_button.mp3 >nul
cls
echo.
start _Client\wow.exe
goto menu

:server_controls
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_glue_enter_world_button.mp3 >nul
cls
echo.
start _Tools\ZCP.exe
goto server_controls_check

:server_controls_check
cls
echo ______________________________Zaxer's Control Panel v3.1______________________________
echo _________________________Made by Zaxer and Modded by Falmaril_________________________
echo.
echo The Control Panel is running...
echo.
echo You can easily run and autorestart the server by using the control panel.
echo You can configure it by clicking on the flags to open settings and specify .exe path.
echo You can make the database\servers autorestart on crash by ticking the "Restart" boxes.
echo You can hide the database and server windows by ticking the "Hide procceses" box.
echo.
timeout 30
goto exit

:version_checker
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_level_up.mp3
cls
echo _______________________________Dinklepack Version Checker______________________________
echo.
echo Here you can see and check your current server and client version number, to make sure
echo that you are up to date and have the latest server and client updates/version installed.
echo.
echo Please check here after each update, to confirm that it has been applied succesfully.
echo If the update is installed correctly, the version number below will update accordingly.
echo.
set /p current_server_version=<"%mainfolder%\version.txt"
echo Current Server Version: %current_server_version%
echo.
set /p current_client_version=<"_Client\version.txt"
echo Current Client Version: %current_server_version%
echo.
pause
goto menu

:download_server
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo _________________________________Downloads and Updates_________________________________
echo.
echo Here you can download the latest version of the Dinklepack launcher, repack and client.
echo.
echo Please INSTALL the repack and client on an SSD Hard Drive, if possible, to reduce errors.
echo.
echo 1 - Update Launcher
echo.
echo 2 - Download Client
echo.
echo 3 - Download Repack
echo.
echo 4 - Download Addons
echo.
echo 5 - Optional Downloads (N/A)
echo.
echo 6 - Return To Menu
echo.
set /P download_server=Enter a number:
if "%download_server%"=="1" (goto download_launcher)
if "%download_server%"=="2" (goto download_client)
if "%download_server%"=="3" (goto download_repack)
if "%download_server%"=="4" (goto install_addons)
if "%download_server%"=="5" (goto optional_downloads)
if "%download_server%"=="6" (goto menu)
goto menu


:download_launcher
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo ____________________________Downloading Dinklepack Launcher____________________________
echo.
echo Downloading latest Dinklepack Launcher... please wait...
echo.
del .\_Download\Launcher\Dinklepack_Launcher.rar >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Launcher\ -c "https://www.dropbox.com/scl/fi/yt4vcb96p81xv5bwewg31/Dinklepack_Launcher.rar?rlkey=h95qorciw1pqzzfqf2frpdnvq"
_Tools\rar.exe x .\_Download\Launcher\Dinklepack_Launcher.rar * .\_Download\Launcher\
del .\_Download\Launcher\Dinklepack_Launcher.rar >nul 2>&1
echo.
echo Dinklepack Server Launcher download done. The files are available in the _Download folder.
echo.
pause
goto install_launcher

:install_launcher
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ready_check.mp3 >nul
cls
echo _________________________Installing Dinklepack Server Launcher_________________________
echo.
echo You can easily update the Dinklepack Server Launcher by following the steps below.
echo.
echo 1. Step
echo Close the launcher.
echo.
echo 2. Step
echo To update the Dinklepack Launcher cut and paste the files in \_Download\Launcher
echo to the main folder of Dinklepack Repack i.e. where the auth- and worldserver.exe
echo are and select "replace the files in the destination".
echo.
echo 3. Step
echo Open the updated launcher to resume and proceed with downloading and installing 
echo the latest updates to the Dinklepack Repack and the Dinklepack Client.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
pause
goto download_server

:download_client
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo _________________________________Download/Update Client________________________________
echo.
echo Here you can download the latest base version of or update to the Dinklepack Client.
echo.
echo Please INSTALL the client (65GB) on an SSD Hard Drive as it reduces some client errors!
echo.
echo Please USE the Dropbox links first as they're intended to be used with the launcher and
echo mainly rely on unzipped files that have to be downloaded individually, for ease of use.
echo.
echo The MediaFire links are primarily intended as an alternative download option for when 
echo Dropbox is down due to the bandwidth limit being reached or as a second option for 
echo those who can't use Dropbox or prefer to use MediaFire (and this method) instead.
echo.
echo BEWARE that the MediaFire method requires double the amount of available space (130GB),
echo as the client files are zipped and have to be downloaded, extracted, and deleted first.
echo.
echo 1 - Download Client (Dropbox)
echo 2 - Update Client (Dropbox)
echo.
echo 3 - Download Client (MediaFire)
echo 4 - Update Client (MediaFire)
echo.
echo 5 - Return To Menu
echo.
set /P download_client=Enter a number:
if "%download_client%"=="1" (goto download_client_warning_dropbox)
if "%download_client%"=="2" (goto update_client_dropbox)
if "%download_client%"=="3" (goto download_client_warning_mediafire)
if "%download_client%"=="4" (goto update_client_mediafire)
if "%download_client%"=="5" (goto download_server)
goto download_server

:download_client_warning_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to download the Dinklepack Base Client. This is ONLY needed when setting up
echo the server for the first time or in case you need to reinstall the Dinklepack Client.
echo.
set /P download_client_warning_dropbox=Are you sure you want to download the Dinklepack Base Client? (Y\n)
if "%download_client_warning_dropbox%"=="n" (goto download_client)
if "%download_client_warning_dropbox%"=="y" (goto download_client_dropbox)

:download_client_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3 >nul
cls
echo __________________________Downloading Dinklepack Base Client____________________________
echo.
echo Here you can download the Dinklepack Base Client. It consists of two parts; 1. The Base
echo Client which consists of a zip file with all the original WoTLK client files and 2. The
echo Client Patches which contains all of the custom patches for the The Dinklepack Repack.
echo.
echo 1 - Download Part 1
echo 2 - Download Part 2
echo 3 - Download via Shalkith's Patcher
echo.
echo 4 - Delete Zip File
echo.
echo 5- Return To Menu
echo.
set /P download_client_dropbox=Enter a number:
if "%download_client_dropbox%"=="1" (goto download_client_part_1_dropbox)
if "%download_client_dropbox%"=="2" (goto download_client_part_2_dropbox)
if "%download_client_dropbox%"=="3" (goto download_client_shalkith)
if "%download_client_dropbox%"=="4" (goto delete_client_warning_dropbox)
if "%download_client_dropbox%"=="5" (goto download_client)

goto download_client

:download_client_part_1_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
cls
echo _______________________Downloading Dinklepack Base Client Part 1________________________
echo.
echo Downloading Dinklepack Base Client Part 1... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Base.7z >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ -c "https://www.dropbox.com/scl/fo/6bbvv0z65ku90y4bixqqc/h/Dinklepack_Client_Base.7z?rlkey=8ttfwaeatuizw1n9m1ubs5nmc"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
goto extract_client_part_1_dropbox

:extract_client_part_1_dropbox
cls
echo ________________________Extracting Dinklepack Base Client Part 1_________________________
echo.
echo Extracting Dinklepack Base Client... please wait...
echo.
_Tools\7za.exe x .\_Download\Client\ -o".\_Client"
echo.
echo Dinklepack Base Client extract done. The files are available in the _Client folder.
echo.
pause
goto download_client_part_2_dropbox

:delete_client_warning_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to delete the Dinklepack Base Client .zip file. You should ONLY do this
echo once you're done with extracting the Dinklepack Base Client to the _Client folder.
echo.
set /P delete_client_warning_dropbox=Are you sure you want to download the Dinklepack Base Client Zip Files? (Y\n)
if "%delete_client_warning_dropbox%"=="n" (goto download_client_dropbox)
if "%delete_client_warning_dropbox%"=="y" (goto delete_client_dropbox)

:delete_client_dropbox
cls
echo ________________________Deleting Dinklepack Base Client Zip Files________________________
echo.
echo Deleting Dinklepack Base Client Zip File... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Base.7z >nul 2>&1
rmdir /Q /S .\_Download\Client\ >nul 2>&1
echo.
echo Dinklepack Base Client Zip File deleted. Returning to "Downloading Dinklepack Base Client".
echo.
timeout 15
goto download_client_dropbox

:download_client_shalkith
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
_Tools\shalkith_patcher.exe
goto download_client

:download_client_part_2_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
cls
echo __________________________Downloading Dinklepack Client Patches__________________________
echo.
echo Here you can download the Dinklepack Client Patches. All you have to do is enter the no.
echo of the patch (1-23) and the launcher will download it into the "_Client\Data" directory.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
echo.
echo 1 - Download Patch-6
echo 2 - Download Patch-7
echo 3 - Download Patch-8
echo 4 - Download Patch-A
echo 5 - Download Patch-B
echo 6 - Download Patch-D
echo 7 - Download Patch-E
echo 8 - Download Patch-G
echo 9 - Download Patch-H
echo 10 - Download Patch-I
echo 11 - Download Patch-J
echo 12 - Download Patch-K
echo 13 - Download Patch-M
echo 14 - Download Patch-Q
echo 15 - Download Patch-R
echo 16 - Download Patch-S
echo 17 - Download Patch-T
echo 18 - Download Patch-U
echo 19 - Download Patch-V
echo 20 - Download Patch-W
echo 21 - Download Patch-X
echo 22 - Download Patch-Y
echo 23 - Download Patch-Z
echo.
echo 24 - Return To Menu
echo.
set /P download_client_part_2_dropbox=Enter a number:
if "%download_client_part_2_dropbox%"=="1" (goto download_client_dropbox1)
if "%download_client_part_2_dropbox%"=="2" (goto download_client_dropbox2)
if "%download_client_part_2_dropbox%"=="3" (goto download_client_dropbox3)
if "%download_client_part_2_dropbox%"=="4" (goto download_client_dropbox4)
if "%download_client_part_2_dropbox%"=="5" (goto download_client_dropbox5)
if "%download_client_part_2_dropbox%"=="6" (goto download_client_dropbox6)
if "%download_client_part_2_dropbox%"=="7" (goto download_client_dropbox7)
if "%download_client_part_2_dropbox%"=="8" (goto download_client_dropbox8)
if "%download_client_part_2_dropbox%"=="9" (goto download_client_dropbox9)
if "%download_client_part_2_dropbox%"=="10" (goto download_client_dropbox10)
if "%download_client_part_2_dropbox%"=="11" (goto download_client_dropbox11)
if "%download_client_part_2_dropbox%"=="12" (goto download_client_dropbox12)
if "%download_client_part_2_dropbox%"=="13" (goto download_client_dropbox13)
if "%download_client_part_2_dropbox%"=="14" (goto download_client_dropbox14)
if "%download_client_part_2_dropbox%"=="15" (goto download_client_dropbox15)
if "%download_client_part_2_dropbox%"=="16" (goto download_client_dropbox16)
if "%download_client_part_2_dropbox%"=="17" (goto download_client_dropbox17)
if "%download_client_part_2_dropbox%"=="18" (goto download_client_dropbox18)
if "%download_client_part_2_dropbox%"=="19" (goto download_client_dropbox19)
if "%download_client_part_2_dropbox%"=="20" (goto download_client_dropbox20)
if "%download_client_part_2_dropbox%"=="21" (goto download_client_dropbox21)
if "%download_client_part_2_dropbox%"=="22" (goto download_client_dropbox22)
if "%download_client_part_2_dropbox%"=="23" (goto download_client_dropbox23)
if "%download_client_part_2_dropbox%"=="24" (goto download_client)
goto download_client

:download_client_dropbox1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/tbc_intro_process.mp3 >nul
cls
echo __________________________Downloading Dinklepack Base Patch 1___________________________
echo.
echo Downloading Dinklepack Patch-6 and version.txt... please wait...
echo.
del .\_Client\Data\Patch-6.mpq >nul 2>&1
del .\_Client\version.txt >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-6.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\ -c "https://www.dropbox.com/scl/fi/xzbg3ae0tc90vstp5ywvk/version.txt?rlkey=k3z76lpf8bxio2sykjus3thk5"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox2

:download_client_dropbox2
cls
echo __________________________Downloading Dinklepack Base Patch 2___________________________
echo.
echo Downloading Dinklepack Patch-7... please wait...
echo.
del .\_Client\Data\Patch-7.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-7.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox3

:download_client_dropbox3
cls
echo __________________________Downloading Dinklepack Base Patch 3___________________________
echo.
echo Downloading Dinklepack Patch-8... please wait...
echo.
del .\_Client\Data\Patch-8.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-8.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox4

:download_client_dropbox4
cls
echo __________________________Downloading Dinklepack Base Patch 4___________________________
echo.
echo Downloading Dinklepack Patch-A... please wait...
echo.
del .\_Client\Data\Patch-A.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-A.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox5

:download_client_dropbox5
cls
echo __________________________Downloading Dinklepack Base Patch 5___________________________
echo.
echo Downloading Dinklepack Patch-B... please wait...
echo.
del .\_Client\Data\Patch-B.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-B.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox6

:download_client_dropbox6
cls
echo __________________________Downloading Dinklepack Base Patch 6___________________________
echo.
echo Downloading Dinklepack Patch-D... please wait...
echo.
del .\_Client\Data\Patch-D.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-D.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox7

:download_client_dropbox7
cls
echo __________________________Downloading Dinklepack Base Patch 7___________________________
echo.
echo Downloading Dinklepack Patch-E... please wait...
echo.
del .\_Client\Data\Patch-E.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-E.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox8

:download_client_dropbox8
cls
echo __________________________Downloading Dinklepack Base Patch 8___________________________
echo.
echo Downloading Dinklepack Patch-G... please wait...
echo.
del .\_Client\Data\Patch-G.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-G.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox9

:download_client_dropbox9
cls
echo __________________________Downloading Dinklepack Base Patch 9___________________________
echo.
echo Downloading Dinklepack Patch-H... please wait...
echo.
del .\_Client\Data\Patch-H.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-H.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox10

:download_client_dropbox10
cls
echo _________________________Downloading Dinklepack Base Patch 10___________________________
echo.
echo Downloading Dinklepack Patch-I... please wait...
echo.
del .\_Client\Data\Patch-I.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-I.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox11

:download_client_dropbox11
cls
echo _________________________Downloading Dinklepack Base Patch 11___________________________
echo.
echo Downloading Dinklepack Patch-J... please wait...
echo.
del .\_Client\Data\Patch-J.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-J.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox12

:download_client_dropbox12
cls
echo _________________________Downloading Dinklepack Base Patch 12___________________________
echo.
echo Downloading Dinklepack Patch-K... please wait...
echo.
del .\_Client\Data\Patch-K.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-K.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox13

:download_client_dropbox13
cls
echo _________________________Downloading Dinklepack Base Patch 13___________________________
echo.
echo Downloading Dinklepack Patch-M... please wait...
echo.
del .\_Client\Data\Patch-M.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-M.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox14

:download_client_dropbox14
cls
echo _________________________Downloading Dinklepack Base Patch 14___________________________
echo.
echo Downloading Dinklepack Patch-Q... please wait...
echo.
del .\_Client\Data\Patch-Q.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-Q.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox15

:download_client_dropbox15
cls
echo _________________________Downloading Dinklepack Base Patch 15___________________________
echo.
echo Downloading Dinklepack Patch-R... please wait...
echo.
del .\_Client\Data\Patch-R.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-R.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox16

:download_client_dropbox16
cls
echo _________________________Downloading Dinklepack Base Patch 16___________________________
echo.
echo Downloading Dinklepack Patch-S... please wait...
echo.
del .\_Client\Data\Patch-S.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-S.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
goto download_client_dropbox17

:download_client_dropbox17
cls
echo _________________________Downloading Dinklepack Base Patch 17___________________________
echo.
echo Downloading Dinklepack Patch-T... please wait...
echo.
del .\_Client\Data\Patch-T.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-T.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox18

:download_client_dropbox18
cls
echo _________________________Downloading Dinklepack Base Patch 18___________________________
echo.
echo Downloading Dinklepack Patch-U... please wait...
echo.
del .\_Client\Data\Patch-U.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-U.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox19

:download_client_dropbox19
cls
echo _________________________Downloading Dinklepack Base Patch 19___________________________
echo.
echo Downloading Dinklepack Patch-V... please wait...
echo.
del .\_Client\Data\Patch-V.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-V.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox20

:download_client_dropbox20
cls
echo _________________________Downloading Dinklepack Base Patch 20___________________________
echo.
echo Downloading Dinklepack Patch-W... please wait...
echo.
del .\_Client\Data\Patch-W.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-W.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox21

:download_client_dropbox21
cls
echo _________________________Downloading Dinklepack Base Patch 21___________________________
echo.
echo Downloading Dinklepack Patch-X... please wait...
echo.
del .\_Client\Data\Patch-X.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-X.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox22

:download_client_dropbox22
cls
echo _________________________Downloading Dinklepack Base Patch 22___________________________
echo.
echo Downloading Dinklepack Patch-Y... please wait...
echo.
del .\_Client\Data\Patch-Y.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/Patch-Y.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto download_client_dropbox23

:download_client_dropbox23
cls
echo _________________________Downloading Dinklepack Base Patch 23___________________________
echo.
echo Downloading Dinklepack Patch-Z... please wait...
echo.
del .\_Client\Data\Patch-Z.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/scl/fo/r8t7fje9j02nr2mqlki00/h/patch-Z.mpq?rlkey=09m2mcbwvejsjyn42nz9zqx63"
echo.
echo Downloading done. The files are available in the Data folder inside the _Client folder.
echo.
pause
goto install_client_dropbox

:install_client_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_ready.mp3 >nul
cls
echo ___________________________Installing Dinklepack Base Client____________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Base Client.
echo.
echo The files are availble in the _Client folder. An image should apear next. Please check
echo that the contents and structure of the _Client\Data folder is identical to the image.
echo.
echo If the contents and structure in your _Client\Data folder doesn't look like the one'
echo shown in the image file, then please retry until said folder and image look identical.
echo.
pause
goto client_base_image_dropbox

:client_base_image_dropbox
cls
echo.
cd .\_ReadMe
start Client_Base.png
goto download_client_dropbox

:update_client_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3 >nul
cls
echo __________________________Downloading Dinklepack Client Update__________________________
echo.
echo Here you can download the Dinklepack Client Update. All you have to do is enter the no.
echo of the patch (1-10) and the launcher will download it into the "_Client\Data" directory.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
echo.
echo Please remember to check the version no. by using the version checker in the main menu.
echo.
echo 1 - Download Patch-8
echo 2 - Download Patch-D
echo 3 - Download Patch-H
echo 4 - Download Patch-I
echo 5 - Download Patch-M
echo 6 - Download Patch-S
echo 7 - Download Patch-U
echo 8 - Download Patch-W
echo 9 - Download Patch-Y
echo 10 - Optional Patch-I
echo.
echo 11 - Return To Menu
echo.
set /P update_client_dropbox=Enter a number:
if "%update_client_dropbox%"=="1" (goto update_client_dropbox1)
if "%update_client_dropbox%"=="2" (goto update_client_dropbox2)
if "%update_client_dropbox%"=="3" (goto update_client_dropbox3)
if "%update_client_dropbox%"=="4" (goto update_client_dropbox4)
if "%update_client_dropbox%"=="5" (goto update_client_dropbox5)
if "%update_client_dropbox%"=="6" (goto update_client_dropbox6)
if "%update_client_dropbox%"=="7" (goto update_client_dropbox7)
if "%update_client_dropbox%"=="8" (goto update_client_dropbox8)
if "%update_client_dropbox%"=="9" (goto update_client_dropbox9)
if "%update_client_dropbox%"=="10" (goto update_client_dropbox10)
if "%update_client_dropbox%"=="11" (goto download_client)
goto download_client

:update_client_dropbox1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
cls
echo ______________________Downloading Dinklepack Client Update Part 1_______________________
echo.
echo Downloading Dinklepack Patch-8, version.txt and WoW.exe... please wait...
echo.
del .\_Client\Data\Patch-8.mpq >nul 2>&1
del .\_Client\version.txt >nul 2>&1
del .\_Download\Updates\Client\WOWEXE_UPDATE.zip >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AAC_-aNGG-swSXJZ-uFg1M46a/patch-8.mpq"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\ -c "https://www.dropbox.com/scl/fi/j6o5pw3bm45fihotqgeh2/version.txt?rlkey=27iys2d995qgdk03tbt4p6nvc"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACW_E9VbIOnJJ7ffAmQ2mDca/WOWEXE_UPDATE.zip"
_Tools\7za.exe x .\_Download\Updates\Client\ -o".\_Client"
del .\_Download\Updates\Client\WOWEXE_UPDATE.zip >nul 2>&1
rmdir /Q /S .\_Download\Updates >nul 2>&1
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox2

:update_client_dropbox2
cls
echo ______________________Downloading Dinklepack Client Update Part 2_______________________
echo.
echo Downloading Dinklepack Patch-D... please wait...
echo.
del .\_Client\Data\Patch-D.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACxknWGv-uZECqyn2Pf7KXAa/Patch-D.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox3

:update_client_dropbox3
cls
echo ______________________Downloading Dinklepack Client Update Part 3_______________________
echo.
echo Downloading Dinklepack Patch-H... please wait...
echo.
del .\_Client\Data\Patch-H.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACjkydKYg5In11ml1b8IHELa/patch-H.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox4

:update_client_dropbox4
cls
echo ______________________Downloading Dinklepack Client Update Part 4_______________________
echo.
echo Downloading Dinklepack Patch-I... please wait...
echo.
del .\_Client\Data\Patch-I.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AAC5QFsuZAa32FAg9seo8xUOa/Patch-I.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox5

:update_client_dropbox5
cls
echo ______________________Downloading Dinklepack Client Update Part 5_______________________
echo.
echo Downloading Dinklepack Patch-M... please wait...
echo.
del .\_Client\Data\Patch-M.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AAAYSMiyd9Y5H-VpzDWd9-b8a/patch-M.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox6

:update_client_dropbox6
cls
echo ______________________Downloading Dinklepack Client Update Part 6_______________________
echo.
echo Downloading Dinklepack Patch-S... please wait...
echo.
del .\_Client\Data\Patch-S.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACNyDRSs2uJmZou6Z4Pt5Loa/Patch-S.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox7

:update_client_dropbox7
cls
echo ______________________Downloading Dinklepack Client Update Part 7_______________________
echo.
echo Downloading Dinklepack Patch-U... please wait...
echo.
del .\_Client\Data\Patch-U.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AABj0VDK0ZIOHCQrl6-TvBuNa/Patch-U.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox8

:update_client_dropbox8
cls
echo ______________________Downloading Dinklepack Client Update Part 8_______________________
echo.
echo Downloading Dinklepack Patch-W... please wait...
echo.
del .\_Client\Data\Patch-W.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACrLaHLmpvi3L_uJjbR-ICTa/Patch-W.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox9

:update_client_dropbox9
cls
echo ______________________Downloading Dinklepack Client Update Part 9_______________________
echo.
echo Downloading Dinklepack Patch-Y... please wait...
echo.
del .\_Client\Data\Patch-Y.mpq >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AACQwlWE-KD-n3eN_ePL6NdIa/Patch-Y.mpq"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto update_client_dropbox10

:update_client_dropbox10
cls
echo ______________________Downloading Dinklepack Client Update Part 10_______________________
echo.
echo Downloading Dinklepack Optional High Elf and Blood Elf Eye Colors... please wait...
echo.
del .\_Client\Data\OptionalEyeglow-Helf-and-Belf.zip >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\Data\ -c "https://www.dropbox.com/sh/7wto7lnj635qjws/AADE5iGsI2y6E8d3olxb_qwOa/OptionalEyeglow-Helf-and-Belf.zip"
echo.
echo Downloading done. The files will be available in the Data folder inside the _Client folder.
echo.
pause
goto install_client_update_dropbox

:install_client_update_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_ready.mp3 >nul
cls
echo __________________________Installing Dinklepack Client Update____________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Client Update.
echo.
echo The files are availble in the _Client folder. An image should apear next. Please check
echo that the contents and structure of the _Client\Data folder is identical to the image.
echo.
echo If the contents and structure in your _Client\Data folder doesn't look like the one'
echo shown in the image file, then please retry until said folder and image look identical.
echo.
pause
goto client_update_image_dropbox

:client_update_image_dropbox
cls
echo.
cd .\_ReadMe
start Client_Update.png
goto update_client_dropbox

:download_client_warning_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to download the Dinklepack Base Client. This is ONLY needed when setting up
echo the server for the first time or in case you need to reinstall the Dinklepack Client.
echo.
set /P download_client_warning_mediafire=Are you sure you want to download the Dinklepack Base Client? (Y\n)
if "%download_client_warning_mediafire%"=="n" (goto download_client)
if "%download_client_warning_mediafire%"=="y" (goto download_client_mediafire)

:download_client_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3
cls
echo __________________________Downloading Dinklepack Base Client____________________________
echo.
echo Here you can download the Dinklepack Base Client. 
echo.
echo 1 - Download Part 1
echo 2 - Download Part 2
echo 3 - Download Part 3
echo 4 - Download Part 4
echo 5 - Download Part 5
echo 6 - Download Part 6
echo 7 - Download Part 7
echo 8 - Download Part 8
echo 9 - Download Part 9
echo 10 - Download Part 10
echo 11 - Download Part 11
echo 12 - Download Part 12
echo 13 - Download Part 13
echo.
echo 14 - Extract Client
echo.
echo 15 - Delete Zip Files
echo.
echo 16 - Return To Menu
echo.
set /P download_client_mediafire=Enter a number:
if "%download_client_mediafire%"=="1" (goto download_client_mediafire1)
if "%download_client_mediafire%"=="2" (goto download_client_mediafire2)
if "%download_client_mediafire%"=="3" (goto download_client_mediafire3)
if "%download_client_mediafire%"=="4" (goto download_client_mediafire4)
if "%download_client_mediafire%"=="5" (goto download_client_mediafire5)
if "%download_client_mediafire%"=="6" (goto download_client_mediafire6)
if "%download_client_mediafire%"=="7" (goto download_client_mediafire7)
if "%download_client_mediafire%"=="8" (goto download_client_mediafire8)
if "%download_client_mediafire%"=="9" (goto download_client_mediafire9)
if "%download_client_mediafire%"=="10" (goto download_client_mediafire10)
if "%download_client_mediafire%"=="11" (goto download_client_mediafire11)
if "%download_client_mediafire%"=="12" (goto download_client_mediafire12)
if "%download_client_mediafire%"=="13" (goto download_client_mediafire13)
if "%download_client_mediafire%"=="14" (goto extract_client_mediafire)
if "%download_client_mediafire%"=="15" (goto delete_client_warning_mediafire)
if "%download_client_mediafire%"=="16" (goto download_client)
goto download_client

:download_client_mediafire1
cls
echo _______________________Downloading Dinklepack Base Client Part 1________________________
echo.
echo Downloading Dinklepack Base Client Part 1... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.001 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/y7w48dh7rzks7qc/Dinklepack_Client.7z.001/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire2

:download_client_mediafire2
cls
echo _______________________Downloading Dinklepack Base Client Part 2________________________
echo.
echo Downloading Dinklepack Base Client Part 2... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.002 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/px4eml9yj9s7mnn/Dinklepack_Client.7z.002/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire3

:download_client_mediafire3
cls
echo _______________________Downloading Dinklepack Base Client Part 3________________________
echo.
echo Downloading Dinklepack Base Client Part 3... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.003 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/u92v170d5mnvmgc/Dinklepack_Client.7z.003/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire4

:download_client_mediafire4
cls
echo _______________________Downloading Dinklepack Base Client Part 4________________________
echo.
echo Downloading Dinklepack Base Client Part 4... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.004 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/0dy72l5w7c1yk82/Dinklepack_Client.7z.004/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire5

:download_client_mediafire5
cls
echo _______________________Downloading Dinklepack Base Client Part 5________________________
echo.
echo Downloading Dinklepack Base Client Part 5... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.005 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/3yxoa51m7v1wisr/Dinklepack_Client.7z.005/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire6

:download_client_mediafire6
cls
echo _______________________Downloading Dinklepack Base Client Part 6________________________
echo.
echo Downloading Dinklepack Base Client Part 6... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.006 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/sc8yz96i43d3iz4/Dinklepack_Client.7z.006/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire7

:download_client_mediafire7
cls
echo _______________________Downloading Dinklepack Base Client Part 7________________________
echo.
echo Downloading Dinklepack Base Client Part 7... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.007 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/nxh65eam93mmlgo/Dinklepack_Client.7z.007/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire8

:download_client_mediafire8
cls
echo _______________________Downloading Dinklepack Base Client Part 8________________________
echo.
echo Downloading Dinklepack Base Client Part 8... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.008 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/6xl0rno0cy82zwk/Dinklepack_Client.7z.008/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire9

:download_client_mediafire9
cls
echo _______________________Downloading Dinklepack Base Client Part 9________________________
echo.
echo Downloading Dinklepack Base Client Part 9... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.009 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/m5azrygjca0tys4/Dinklepack_Client.7z.009/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire10

:download_client_mediafire10
cls
echo _______________________Downloading Dinklepack Base Client Part 10________________________
echo.
echo Downloading Dinklepack Base Client Part 10... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.010 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/21ydj0nz3nvh268/Dinklepack_Client.7z.010/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire11

:download_client_mediafire11
cls
echo _______________________Downloading Dinklepack Base Client Part 11________________________
echo.
echo Downloading Dinklepack Base Client Part 11... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.011 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/bpbt9yenml3rohf/Dinklepack_Client.7z.011/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire12

:download_client_mediafire12
cls
echo _______________________Downloading Dinklepack Base Client Part 12________________________
echo.
echo Downloading Dinklepack Base Client Part 12... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.012 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/7nnvdhha938k0eu/Dinklepack_Client.7z.012/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto download_client_mediafire13

:download_client_mediafire13
cls
echo _______________________Downloading Dinklepack Base Client Part 13________________________
echo.
echo Downloading Dinklepack Base Client Part 13... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.013 >nul 2>&1
_Tools\wget.exe --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Client\ https://www.mediafire.com/file_premium/1xyruyz0kr11a9v/Dinklepack_Client.7z.013/file
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto extract_client_mediafire


:extract_client_mediafire
cls
echo __________________________Extracting Dinklepack Base Client____________________________
echo.
echo Extracting Dinklepack Base Client... please wait...
echo.
_Tools\7za.exe x .\_Download\Client\ -o".\_Client"
echo.
echo Dinklepack Base Client extract done. The files are available in the _Client folder.
echo.
pause
goto install_client_mediafire

:install_client_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_ready.mp3 >nul
cls
echo ___________________________Installing Dinklepack Base Client____________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Base Client.
echo.
echo The files are availble in the _Client folder. An image should apear next. Please check
echo that the contents and structure of the _Client\Data folder is identical to the image.
echo.
echo If the contents and structure in your _Client\Data folder doesn't look like the one'
echo shown in the image file, then please retry until said folder and image look identical.
echo.
pause
goto client_base_image_mediafire

:client_base_image_mediafire
cls
echo.
cd .\_ReadMe
start Client_Base.png
goto download_client_mediafire

:delete_client_warning_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to delete Dinklepack Base Client .zip files. You should ONLY do this once 
echo you're done with downloadgin, extracting and installing the Dinklepack Base Client.
echo.
set /P delete_client_warning_mediafire=Are you sure you want to download the Dinklepack Base Client Zip Files? (Y\n)
if "%delete_client_warning_mediafire%"=="n" (goto download_client_mediafire)
if "%delete_client_warning_mediafire%"=="y" (goto delete_client_mediafire)

:delete_client_mediafire
cls
echo ________________________Deleting Dinklepack Base Client Zip Files________________________
echo.
echo Deleting Dinklepack Base Client Zip Files... please wait...
echo.
del .\_Download\Client\Dinklepack_Client.7z.001 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.002 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.003 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.004 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.005 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.006 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.007 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.008 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.009 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.010 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.011 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.012 >nul 2>&1
del .\_Download\Client\Dinklepack_Client.7z.013 >nul 2>&1
rmdir /Q /S .\_Download\Client\ >nul 2>&1
echo.
echo Dinklepack Base Client Zip Files deleted. Returning to "Downloading Dinklepack Base Client".
echo.
timeout 15
goto download_client_mediafire

:update_client_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3 >nul
cls
echo __________________________Downloading Dinklepack Client Update__________________________
echo.
echo Here you can download the Dinklepack Client Update. 
echo.
echo Please remember to check the version no. by using the version checker in the main menu.
echo.
echo 1 - Download Part 1
echo 2 - Download Part 2
echo 3 - Download Part 3
echo 4 - Download Part 4
echo 5 - Download Part 5
echo.
echo 6 - Extract Client
echo.
echo 7 - Delete Zip Files
echo.
echo 8 - Return To Menu
echo.
set /P update_client_mediafire=Enter a number:
if "%update_client_mediafire%"=="1" (goto update_client_mediafire1)
if "%update_client_mediafire%"=="2" (goto update_client_mediafire2)
if "%update_client_mediafire%"=="3" (goto update_client_mediafire3)
if "%update_client_mediafire%"=="4" (goto update_client_mediafire4)
if "%update_client_mediafire%"=="5" (goto update_client_mediafire5)
if "%update_client_mediafire%"=="6" (goto extract_update_mediafire)
if "%update_client_mediafire%"=="7" (goto delete_update_warning_mediafire)
if "%update_client_mediafire%"=="8" (goto download_client)
goto download_client


:update_client_mediafire1
cls
echo ______________________Downloading Dinklepack Client Update Part 1________________________
echo.
echo Downloading Dinklepack Client Update Part 1... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Update.7z.001 >nul 2>&1
del .\_Client\version.txt >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ "https://www.mediafire.com/file_premium/lqfyzjnsz2ytakj/Dinklepack_Client_Update.7z.001/file"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Client\ -c "https://www.dropbox.com/scl/fi/j6o5pw3bm45fihotqgeh2/version.txt?rlkey=27iys2d995qgdk03tbt4p6nvc"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto update_client_mediafire2

:update_client_mediafire2
cls
echo ______________________Downloading Dinklepack Client Update Part 2________________________
echo.
echo Downloading Dinklepack Client Update Part 2... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Update.7z.002 >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ "https://www.mediafire.com/file_premium/2au21g9xy4ut2ig/Dinklepack_Client_Update.7z.002/file"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto update_client_mediafire3

:update_client_mediafire3
cls
echo ______________________Downloading Dinklepack Client Update Part 3________________________
echo.
echo Downloading Dinklepack Client Update Part 3... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Update.7z.003 >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ "https://www.mediafire.com/file_premium/jjqe1xmy38gwxq8/Dinklepack_Client_Update.7z.003/file"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto update_client_mediafire4

:update_client_mediafire4
cls
echo ______________________Downloading Dinklepack Client Update Part 4________________________
echo.
echo Downloading Dinklepack Client Update Part 4... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Update.7z.004 >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ "https://www.mediafire.com/file_premium/wcmvtl6fkp25j87/Dinklepack_Client_Update.7z.004/file"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto update_client_mediafire4

:update_client_mediafire5
cls
echo ______________________Downloading Dinklepack Client Update Part 5________________________
echo.
echo Downloading Dinklepack Client Update Part 5... please wait...
echo.
del .\_Download\Client\Dinklepack_Client_Update.7z.005 >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Client\ "https://www.mediafire.com/file_premium/qrb7r2xmgis803j/Dinklepack_Client_Update.7z.005/file"
echo.
echo Downloading done. The files are available in the _Download folder.
echo.
pause
goto extract_update_mediafire

:extract_update_mediafire
cls
echo __________________________Extracting Dinklepack Client Update____________________________
echo.
echo Extracting Dinklepack Client Update... please wait...
echo.
_Tools\7za.exe x .\_Download\Updates\Client\ -o".\_Client"
echo.
echo Dinklepack Base Client extract done. The files are available in the _Client folder.
echo.
pause
goto install_client_update_mediafire

:install_client_update_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_ready.mp3 >nul
cls
echo __________________________Installing Dinklepack Client Update____________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Client Update.
echo.
echo The files are availble in the _Client folder. An image should apear next. Please check
echo that the contents and structure of the _Client\Data folder is identical to the image.
echo.
echo If the contents and structure in your _Client\Data folder doesn't look like the one'
echo shown in the image file, then please retry until said folder and image look identical.
echo.
pause
goto client_update_image_mediafire

:client_update_image_mediafire
cls
echo.
cd .\_ReadMe
start Client_Update.png
goto update_client_mediafire

:delete_update_warning_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to delete Dinklepack Client Update .zip files. You should ONLY do this once 
echo you're done with downloadgin, extracting and installing the Dinklepack Client Update.
echo.
set /P delete_update_warning_mediafire=Are you sure you want to download the Dinklepack Client Update Zip Files? (Y\n)
if "%delete_update_warning_mediafire%"=="n" (goto update_client_mediafire)
if "%delete_update_warning_mediafire%"=="y" (goto delete_update_mediafire)

:delete_update_mediafire
cls
echo ________________________Deleting Dinklepack Client Update Zip Files________________________
echo.
echo Deleting Dinklepack Client Update Zip Files... please wait...
echo.
del .\_Download\Updates\Client\Dinklepack_Client_Update.7z.001 >nul 2>&1
del .\_Download\Updates\Client\Dinklepack_Client_Update.7z.002 >nul 2>&1
del .\_Download\Updates\Client\Dinklepack_Client_Update.7z.003 >nul 2>&1
del .\_Download\Updates\Client\Dinklepack_Client_Update.7z.004 >nul 2>&1
del .\_Download\Updates\Client\Dinklepack_Client_Update.7z.005 >nul 2>&1
rmdir /Q /S .\_Download\Updates\Client\ >nul 2>&1
echo.
echo Dinklepack Client Update Zip Files deleted.
echo.
timeout 15
goto update_client_mediafire

:download_repack
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo _________________________________Download/Update Repack________________________________
echo.
echo Here you can download the latest base version of or update to the Dinklepack Repack.
echo.
echo Please INSTALL the repack on an SSD Hard Drive as it reduces a lot of common errors!
echo.
echo Please USE the Dropbox links first as they're intended to be used with the launcher.
echo.
echo The MediaFire links are primarily intended as a alternative download option for when 
echo Dropbox is down due to the bandwidth limit being reached or as a second option for 
echo those who can't use the Dropbox links or prefer to use the MediaFire links instead.
echo.
echo 1 - Download Repack (Dropbox)
echo 2 - Update Repack (Dropbox)
echo.
echo 3 - Download Repack (MediaFire)
echo 4 - Update Repack (MediaFire)
echo.
echo 5 - Return To Menu
echo.
set /P download_repack=Enter a number:
if "%download_repack%"=="1" (goto download_repack_warning_dropbox)
if "%download_repack%"=="2" (goto update_repack_dropbox)
if "%download_repack%"=="3" (goto download_repack_warning_mediafire)
if "%download_repack%"=="4" (goto update_repack_mediafire)
if "%download_repack%"=="5" (goto download_server)
goto download_server

:download_repack_warning_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to download the Dinklepack Base Repack. This is ONLY needed when setting up
echo the server for the first time or in case you need to reinstall the Dinklepack Repack.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
echo.
set /P download_repack_warning_dropbox=Are you sure you want to download the Dinklepack Base Repack? (Y\n)
if "%download_repack_warning_dropbox%"=="n" (goto download_repack)
if "%download_repack_warning_dropbox%"=="y" (goto download_repack_dropbox)

:download_repack_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_long.mp3 >nul
cls
echo ___________________________Downloading Dinklepack Base Repack___________________________
echo.
echo Downloading Dinklepack Base Repack... please wait...
echo.
del .\_Download\Repack\Dinklepack_Repack.zip >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix="%mainfolder%" -N "https://www.dropbox.com/scl/fi/xzbg3ae0tc90vstp5ywvk/version.txt?rlkey=k3z76lpf8bxio2sykjus3thk5"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Repack\ -c "https://www.dropbox.com/sh/9dcx8ja1bgekp4j/AAAQXZeS0NusDQ0OwmQI1vw1a"
_Tools\7za.exe x .\_Download\Repack\ -o".\_Download\Repack\"
echo.
echo Dinklepack Base Repack download done. The zip file is available in the _Download folder.
echo.
pause
goto extract_repack_dropbox

:extract_repack_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_process.mp3 >nul
cls
echo __________________________Extracting Dinklepack Base Repack____________________________
echo.
echo Extracting Dinklepack Base Repack... please wait...
echo.
_Tools\7za.exe x .\_Download\Repack\ -o"%mainfolder%"
del .\_Download\Repack\Dinklepack_Repack.7z >nul 2>&1
rmdir /Q /S .\_Download\Repack >nul 2>&1
echo.
echo Dinklepack Base Repack extract done. The files have been extracted to the main folder.
echo.
pause
goto install_repack_dropbox

:install_repack_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_ready.mp3 >nul
cls
echo ___________________________Installing Dinklepack Base Repack___________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Base Repack.
echo.
echo The files are availble in the main folder. An image should apear next. Please check
echo that the contents and structure of your main folder is identical to the image.
echo.
echo If the contents and structure in your main folder doesn't look like the one that is
echo shown in the image file, then please retry until said folder and image look identical.
echo.
echo DON'T FORGET to run the server, at least ONCE before continuing with the repack update.
echo To do so return to the main menu, launch it, let it finish setting up and close it again.
echo.
pause
goto repack_base_image_dropbox

:repack_base_image_dropbox
cls
echo.
cd .\_ReadMe
start Repack_Base.png
goto download_repack

:update_repack_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3 >nul
cls
echo __________________________Installing Dinklepack Repack Update__________________________
echo.
echo To install the update, enter A when asked if you want to replace the existing files.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
echo.
echo Please remember to check the version no. by using the version checker in the main menu.
echo.
echo DON'T FORGET to run the server, at least ONCE before continuing with the repack update.
echo To do so return to the main menu, launch it, let it finish setting up and close it again.
echo.
pause
goto update_repack_dropbox1

:update_repack_dropbox1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
cls
echo _________________________Downloading Dinklepack Repack Update__________________________
echo.
echo Downloading latest Dinklepack Repack Update... please wait...
echo.
del .\configs\modules\mod_ahbot.conf >nul 2>&1
del .\configs\modules\mod_ahbot.conf.dist >nul 2>&1
rmdir /Q /S .\Data\data\maps >nul 2>&1
rmdir /Q /S .\Data\data\mmaps >nul 2>&1
rmdir /Q /S .\Data\data\vmaps >nul 2>&1
rmdir /Q /S .\Data\data\sql\custom_bak >nul 2>&1
mkdir .\Data\data\sql\custom_bak >nul 2>&1
copy .\Data\data\sql\custom  .\Data\data\sql\custom_bak >nul 2>&1
rmdir /Q /S .\Data\data\sql\custom >nul 2>&1
rmdir /Q /S .\lua_scripts_bak >nul 2>&1
mkdir .\lua_scripts_bak >nul 2>&1
copy .\lua_scripts  .\lua_scripts_bak >nul 2>&1
rmdir /Q /S .\lua_scripts >nul 2>&1
del .\_Download\Updates\Repack\Dinklepack_Repack_Update.zip >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix="%mainfolder%" -N "https://www.dropbox.com/scl/fi/j6o5pw3bm45fihotqgeh2/version.txt?rlkey=27iys2d995qgdk03tbt4p6nvc"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Repack\ -c "https://www.dropbox.com/scl/fo/79qod7wkz3prty3s66j1l/h?rlkey=p9umihbr5d5l8zk4ztimb3qow"
_Tools\7za.exe x .\_Download\Updates\Repack\ -o".\_Download\Updates\Repack\"
echo.
echo Dinklepack Repack Update download done. The zip file is available in the _Download folder.
echo.
pause
goto extract_repack_update_dropbox

:extract_repack_update_dropbox
cls
echo _________________________Extracting Dinklepack Repack Update____________________________
echo.
echo Extracting Dinklepack Repack Update... please wait...
echo.
_Tools\7za.exe x .\_Download\Updates\Repack\ -o"%mainfolder%"
del .\_Download\Updates\Repack\Dinklepack_Repack_Update.7z >nul 2>&1
rmdir /Q /S .\_Download\Updates >nul 2>&1
echo.
echo Dinklepack Repack Update extract done. The files have been extracted to the main folder.
echo.
pause
goto install_repack_update_dropbox

:install_repack_update_dropbox
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_ready.mp3 >nul
cls
echo __________________________Installing Dinklepack Repack Update___________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Repack Update.
echo.
echo The files are availble in the main folder. An image should apear next. Please check
echo that the contents and structure of your main folder is identical to the image.
echo.
echo If the contents and structure in your main folder doesn't look like the one that is
echo shown in the image file, then please retry until said folder and image look identical.
echo.
echo Please, ALWAYS remember to CHECK the #d-updates-sever [link below] on Discord for any
echo additions, changes or updates to the worldserver config file, in particular.
echo.
echo Link to Discord; https://discord.com/channels/857134283130011649/1104573154321498234
echo.
pause
goto repack_update_image_dropbox

:repack_update_image_dropbox
cls
echo.
cd .\_ReadMe
start Repack_Update.png
goto download_repack

:download_repack_warning_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
echo ________________________________________WARNING_________________________________________
echo.
echo You're about to download the Dinklepack Base Repack. This is ONLY needed when setting up
echo the server for the first time or in case you need to reinstall the Dinklepack Repack.
echo.
set /P download_repack_warning_mediafire=Are you sure you want to download the Dinklepack Base Repack? (Y\n)
if "%download_repack_warning_mediafire%"=="n" (goto download_repack)
if "%download_repack_warning_mediafire%"=="y" (goto download_repack_mediafire)

:download_repack_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_long.mp3 >nul
cls
echo ___________________________Downloading Dinklepack Base Repack___________________________
echo.
echo Downloading Dinklepack Base Repack... please wait...
echo.
del .\_Download\Updates\Repack\Dinklepack_Repack.7z >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix="%mainfolder%" -N "https://www.dropbox.com/scl/fi/xzbg3ae0tc90vstp5ywvk/version.txt?rlkey=k3z76lpf8bxio2sykjus3thk5"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Repack\ "https://www.mediafire.com/file_premium/fcr0ftqlst41suz/Dinklepack_Repack.7z/file"
echo.
echo Dinklepack Base Repack download done. The zip file is available in the _Download folder.
echo.
pause
goto extract_repack_mediafire

:extract_repack_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_process.mp3 >nul
cls
echo __________________________Extracting Dinklepack Base Repack____________________________
echo.
echo Extracting Dinklepack Base Repack... please wait...
echo.
_Tools\7za.exe x .\_Download\Repack\ -o"%mainfolder%"
del .\_Download\Repack\Dinklepack_Repack.7z >nul 2>&1
rmdir /Q /S .\_Download\Repack >nul 2>&1
echo.
echo Dinklepack Base Repack extract done. The files have been extracted to the main folder.
echo.
pause
goto install_repack_mediafire

:install_repack_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_ready.mp3 >nul
cls
echo ___________________________Installing Dinklepack Base Repack___________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Base Repack.
echo.
echo The files are availble in the main folder. An image should apear next. Please check
echo that the contents and structure of your main folder is identical to the image.
echo.
echo If the contents and structure in your main folder doesn't look like the one that is
echo shown in the image file, then please retry until said folder and image look identical.
echo.
echo DON'T FORGET to run the server, at least ONCE before continuing with the repack update.
echo To do so return to the main menu, launch it, let it finish setting up and close it again.
echo.
pause
goto repack_base_image_mediafire

:repack_base_image_mediafire
cls
echo.
cd .\_ReadMe
start Repack_Base.png
goto download_repack

:update_repack_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_long.mp3 >nul
cls
echo __________________________Installing Dinklepack Repack Update__________________________
echo.
echo To install the update, enter A when asked if you want to replace the existing files.
echo.
echo Please remember to check the version no. by using the version checker in the main menu.
echo.
echo DON'T FORGET to run the server, at least ONCE before continuing with the repack update.
echo To do so return to the main menu, launch it, let it finish setting up and close it again.
echo.
pause
goto update_repack_mediafire1

:update_repack_mediafire1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wotlk_intro_process.mp3 >nul
cls
echo _________________________Downloading Dinklepack Repack Update__________________________
echo.
echo Downloading latest Dinklepack Repack Update... please wait...
echo.
del .\configs\modules\mod_ahbot.conf >nul 2>&1
del .\configs\modules\mod_ahbot.conf.dist >nul 2>&1
rmdir /Q /S .\Data\data\maps >nul 2>&1
rmdir /Q /S .\Data\data\mmaps >nul 2>&1
rmdir /Q /S .\Data\data\vmaps >nul 2>&1
rmdir /Q /S .\Data\data\sql\custom_bak >nul 2>&1
mkdir .\Data\data\sql\custom_bak >nul 2>&1
copy .\Data\data\sql\custom  .\Data\data\sql\custom_bak >nul 2>&1
rmdir /Q /S .\Data\data\sql\custom >nul 2>&1
rmdir /Q /S .\lua_scripts_bak >nul 2>&1
mkdir .\lua_scripts_bak >nul 2>&1
copy .\lua_scripts  .\lua_scripts_bak >nul 2>&1
rmdir /Q /S .\lua_scripts >nul 2>&1
del .\_Download\Updates\Repack\Dinklepack_Repack_Update.7z >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix="%mainfolder%" -N "https://www.dropbox.com/scl/fi/j6o5pw3bm45fihotqgeh2/version.txt?rlkey=27iys2d995qgdk03tbt4p6nvc"
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Updates\Repack\ "https://www.mediafire.com/file_premium/jxmndpwwj3r9rmi/Dinklepack_Repack_Update.7z/file"
echo.
echo Dinklepack Repack Update download done. The zip file is available in the _Download folder.
echo.
pause
goto extract_repack_update_mediafire

:extract_repack_update_mediafire
cls
echo _________________________Extracting Dinklepack Repack Update____________________________
echo.
echo Extracting Dinklepack Repack Update... please wait...
echo.
_Tools\7za.exe x .\_Download\Updates\Repack\ -o"%mainfolder%"
del .\_Download\Updates\Repack\Dinklepack_Repack_Update.7z >nul 2>&1
rmdir /Q /S .\_Download\Updates >nul 2>&1
echo.
echo Dinklepack Repack Update extract done. The files have been extracted to the main folder.
echo.
pause
goto install_repack_update_mediafire

:install_repack_update_mediafire
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/vanilla_intro_ready.mp3 >nul
cls
echo __________________________Installing Dinklepack Repack Update___________________________
echo.
echo You've succesfully downloaded, extracted and installed the Dinklepack Repack Update.
echo.
echo The files are availble in the main folder. An image should apear next. Please check
echo that the contents and structure of your main folder is identical to the image.
echo.
echo If the contents and structure in your main folder doesn't look like the one that is
echo shown in the image file, then please retry until said folder and image look identical.
echo.
echo Please, ALWAYS remember to CHECK the #d-updates-sever [link below] on Discord for any
echo additions, changes or updates to the worldserver config file, in particular.
echo.
echo Link to Discord; https://discord.com/channels/857134283130011649/1104573154321498234
echo.
pause
goto repack_update_image_mediafire

:repack_update_image_mediafire
cls
echo.
cd .\_ReadMe
start Repack_Update.png
goto download_repack

:install_addons
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ______________________________Installing Dinklepack Addons_____________________________
echo.
echo Here you can easily download/install some recommended addons for the Dinklepack Repack.
echo.
echo If you get any "unspecified" files when downloading, then try again after 24 hours, as 
echo the links get disabled for 24 hours by Dropbox when they reach a certain unknown limit.
echo.
echo If it still doesn't work, after waiting, then something on your PC is preventing the 
echo launcher from downloading the files and I can't do anything about that, unfortunately.
echo.
echo Selecting (Y)es will install the following addons into the _Client/Interface/AddOns folder.
echo.
echo 1. AtlasLoot. 2. IconSwapper. 3. ncBiggerMacros. 4. NetherBot. 5. NPCBotInventory.
echo 6. pfQuest-wotlk 7. Questie-WotLK. 8. ZygorGuidesViewer. 9. wow-voiceover. 10. AC-Admin.
echo.
set /P install_addons=Are you sure you want to install the Dinklepack Addons? (Y\n)
if "%install_addons%"=="n" (goto download_server)
if "%install_addons%"=="y" (goto install_addons1)

:install_addons1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo _____________________________Downloading Dinklepack Addons_____________________________
echo.
echo Downloading and extracting Dinklepack Addons... please wait...
echo.
del .\_Download\AddOns\Dinklepack_AddOns.rar >nul 2>&1
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\AddOns\ -c "https://www.dropbox.com/scl/fi/s4q6hibn5ebzkhaj7t1wo/Dinklepack_AddOns.rar?rlkey=oq331kmfdxx3u8bbw65qkme9v"
_Tools\rar.exe x .\_Download\AddOns\Dinklepack_AddOns.rar * .\_Client\Interface\AddOns\
del .\_Download\AddOns\Dinklepack_AddOns.rar >nul 2>&1
rmdir /Q /S .\_Download\AddOns >nul 2>&1
echo.
echo Done! The files are available in the AddOns folder inside the _Client\Interface folder.
echo.
pause
goto download_server

:optional_downloads
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo __________________________________Optional Downloads____________________________________
echo.
echo Here you can find and download various optional client and repack edits, mods and patches.
echo.
echo 1 - Falmaril's High Elf Model Swap (N/A)
echo.
echo 2 - Return To Menu
echo.
set /P optional_downloads=Enter a number:
if "%optional_downloads%"=="1" (goto download_server)
if "%optional_downloads%"=="2" (goto download_server)

:highborne_mod
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ____________________________Falmaril's High Elf Model Swap_____________________________
echo.
echo The High Elf Race in the Dinklepack Client/Repack uses the Blood Elf model by standard.
echo This model swap mod changes the High Elf Race to use the Nightborne model instead. 
echo.
echo 1 - Download
echo.
echo 2 - Return To Menu
echo.
set /P highborne_mod=Enter a number:
if "%highborne_mod%"=="1" (goto highborne_download)
if "%highborne_mod%"=="2" (goto optional_downloads)

:highborne_download
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ______________________Downloading Falmaril's High Elf Model Swap_______________________
echo.
echo Downloading Falmaril's High Elf Model Swap... please wait...
echo.
_Tools\wget.exe -k --no-check-certificate --show-progress --content-disposition --directory-prefix=.\_Download\Optional\ -c "https://www.dropbox.com/scl/fi/e4myqrzwp9uw1f9bdelea/Dinklepack_High_Elf_Models.rar?rlkey=qz8wbgwmr7pqie7dqieosdeoq"
_Tools\rar.exe x .\_Download\Optional\Dinklepack_High_Elf_Models.rar * .\_Download\Optional\
del .\_Download\Optional\Dinklepack_High_Elf_Models.rar
echo.
echo Falmaril's High Elf Model Swap download done. 
echo The files are available in the _Download folder.
echo.
pause
goto highborne_install

:highborne_install
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ______________________Installing Falmaril's High Elf Model Swap________________________
echo.
echo You can easily install Falmaril's High Elf Model Swap by following the steps below:
echo.
echo 1. Step
echo Go to \_Download\Optional\Dinklepack_High_Elf_Models\Falmaril's Highborne Model
echo.
echo 2. Step
echo Copy and paste the files in \Place in AzerothCore... to \Data\dbc in the main folder
echo of your Dinklepack Repack i.e. where the auth- and worldserver.exe are and select 
echo "replace the files in the destination".
echo.
echo 3. Step
echo Copy and paste the files in \Place in World of Warcraft... to \Data in the main folder
echo to the main folder of your World of Warcraft folder i.e. where the wow.exe is.
echo and select "replace the files in the destination".
echo.
echo 4. Step
echo Start the SQL server and double-click on the SQL file in \Start SQL server... or run
echo heidisql.exe in _Tools and select the acore_world (db) on the right side, then click on
echo "File" in the right upper corner and then on "Run SQL file" in the drop down menu. Find
echo the "Higborne.sql" file in \Start SQL server... and click on open to run it in HeidiSQL.
echo.
echo 5. Step
echo Done! If you followed the steps above correctly, then you should successfully have
echo installed Falmaril's High Elf Model Swap.
echo.
echo P.S. 
echo If you want to revert back to Dinkledork's High Elf model, simply follow the same steps
echo above, but with the files in ...\Dinklepack_High_Elf_Models\Dinkledork's Highblood Model.
echo.
pause
goto optional_downloads


:account_tools
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ________________________________Create\Edit Accounts _________________________________
echo.
echo Here you can easily learn how to create an account and how to add and remove them
echo in "_Client\Interface\loginui.lua", which controls the Client Auto-Login function.
echo.
echo 1 - Create Account
echo 2 - Edit Auto-Login
echo.
echo 3 - Return To Menu
echo.
set /P account_tools=Enter a number:
if "%account_tools%"=="1" (goto create_account)
if "%account_tools%"=="2" (goto loginui_lua)
if "%account_tools%"=="3" (goto menu)

:create_account
cls
echo _______________________________How To Create An Account_______________________________
echo.
echo All commands should be typed in the worldserver.exe\world console.
echo.
echo To create a new account type: .account create username password
echo.
echo To change a password type: .account set password username oldpass newpass
echo.
echo To change account permissions type: .account set gmlevel username rank realmid
echo.
echo To delete an account type: .account delete username
echo.
echo Beware that the worldserver.exe\world console won't appear if using Zaxer's Control 
echo Panel with "Hide procceses" on, so make sure to untick it or use "Start The Servers".
echo.
pause
goto account_tools

:loginui_lua
cls
echo.
start _Client\Interface\loginui.lua
goto account_tools

:backup_sql
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo __________________________________Backup SQL-Database_________________________________
echo.
echo Here you can export or import your account, characters and world SQL-databases.
echo.
echo You can create a backup of the abovementioned databases by choosing "export...". This
echo creates a SQL-dump\backup of "named" database in the Backup folder. Which you can
echo then import back into "named" database in the SQL-server by choosing "import...".
echo.
echo Please start by launching MySQL and make sure that it is running properly or else
echo you won't be able to export or import anything at all. To launch it, enter 1.
echo.
echo 1 - Launch MySQL
echo.
echo 2 - Export Accounts\Characters
echo 3 - Import Accounts\Characters
echo.
echo 4 - Export World
echo 5 - Import World
echo.
echo 6 - Launch HeidiSQL
echo.
echo 7 - Return To Menu
echo.
set /P backup_sql=Enter a number:
if "%backup_sql%"=="1" (goto launch_mysql)
if "%backup_sql%"=="2" (goto export_char)
if "%backup_sql%"=="3" (goto import_char)
if "%backup_sql%"=="4" (goto export_world)
if "%backup_sql%"=="5" (goto import_world)
if "%backup_sql%"=="6" (goto run_heidisql)
if "%backup_sql%"=="7" (goto menu)
goto menu

:launch_mysql
cls
echo.
start MySQL.bat
goto backup_sql

:export_char
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
set /P export_char=Are you sure you want to export the account\character database? (Y\n)
if "%export_char%"=="n" (goto backup_sql)
if "%export_char%"=="y" (goto export_char_1)

:export_char_1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo Exporting account database... please wait...
echo.
_Tools\mysqldump.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% acore_auth > _Backup\acore_auth.sql
echo.
echo Exporting character database... please wait...
echo.
_Tools\mysqldump.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% acore_characters > _Backup\acore_characters.sql
echo.
echo Account\character database export done.
echo The backup files are available in the _Backup folder.
echo.
pause
goto backup_sql

:import_char
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
set /P import_char=Are you sure you want to import the account\character database backup? (Y\n)
if "%import_char%"=="n" (goto backup_sql)
if "%import_char%"=="y" (goto import_char_1)

:import_char_1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo Importing account database backup... please wait...
echo.
_Tools\mysql.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% --database=acore_auth < _Backup\acore_auth.sql
echo.
echo Importing character database backup... please wait...
echo.
_Tools\mysql.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% --database=acore_characters < _Backup\acore_characters.sql
echo.
echo Account\character database import done.
echo.
pause
goto backup_sql

:export_world
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
cls
set /P export_world=Are you sure you want to export the world database? (Y\n)
if "%export_world%"=="n" (goto backup_sql)
if "%export_world%"=="y" (goto export_world_1)

:export_world_1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo Exporting world database... please wait...
echo.
_Tools\mysqldump.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% acore_world > _Backup\acore_world.sql
echo.
echo World database export done.
echo The backup file is available in the _Backup folder.
echo.
pause
goto backup_sql

:import_world
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_raid_warning.mp3 >nul
set /P import_world=Are you sure you want to import the world database backup? (Y\n)
if "%import_world%"=="n" (goto backup_sql)
if "%import_world%"=="y" (goto import_world_1)

:import_world_1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ardenweald_groveofawakening_portal.mp3 >nul
cls
echo Importing world database backup... please wait...
echo.
_Tools\mysql.exe --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% --database=acore_world < _Backup\acore_world.sql
echo.
echo World database import done.
echo.
pause
goto backup_sql

:run_heidisql
echo.
cd .\_Tools\HeidiSQL
start heidisql.exe
goto backup_sql

:tools
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo _________________________________Dinkledork's Toolbox_________________________________
echo.
echo Here you can find an assorment of useful links, commands, macros, guides and tools. 
echo More "tools" may be added in the future and if you have any suggestions please DM them
echo to me, Falmaril - or post them in the #d-launcher [link below] on Discord. Thanks!
echo.
echo Link to Discord; https://discord.com/channels/857134283130011649/1179113802831249418
echo.
echo 1 - Database
echo.
echo 2 - GM Commands
echo.
echo 3 - NPC Bot Macros
echo.
echo 4 - Model Viewer
echo.
echo 5 - Play With Friends
echo.
echo 6 - Change Server Address
echo.
echo 7 - Return To Menu
echo.
set /P tools=Enter a number:
if "%tools%"=="1" (goto database)
if "%tools%"=="2" (goto gm_commands)
if "%tools%"=="3" (goto npc_macros)
if "%tools%"=="4" (goto model_viewer)
if "%tools%"=="5" (goto zero_tier)
if "%tools%"=="6" (goto ip_changer)
if "%tools%"=="7" (goto menu)
goto menu

:database
start https://wow.tanados.com/database/

:gm_commands
echo.
cd .\_ReadMe
start GM_Commands.rtf
goto tools

:npc_macros
echo.
cd .\_ReadMe
start NPCBot_Macros.rtf
goto tools

:model_viewer
echo.
cd .\_Tools\Model_Viewer
start wowmodelview.exe
goto tools

:zero_tier
echo.
cd .\_ReadMe
start ZeroTier.rtf
goto tools

:ip_changer
cls
echo.
start MySQL.bat
goto ip_changer1

:ip_changer1
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ready_check.mp3 >nul
cls
echo __________________________Dinklepack Server Address Changer___________________________
echo.
echo Here you can easily see and change your current server IP from Local to LAN, to a VPN.
echo Simply write the IP-adress, that you wish to use, below and hit enter to change to it.
echo.
echo MAKE SURE that MySQL is running or you won't be able to change the current server IP.
echo.
set /p current_ip=<"%mainfolder%\address.txt"
echo Current Server IP address: %current_ip%
echo.
set /P setip=Enter the new Server IP address: 
echo %setip%>"%mainfolder%\address.txt"
set realmlist_address=REPLACE INTO `realmlist` VALUES ('1', 'Dinklepack', '%setip%', '127.0.0.1', '255.255.255.0', 8085, 1, 0, 1, 0, 0, 12340);
echo.
echo Saving the new Server IP address...
echo.
ping -n 2 127.0.0.1>nul
echo %realmlist_address%>"%mainfolder%\Data\data\sql\base\db_auth\realmlist.sql"
echo.
echo Importing the new Server IP address into the SQL-database...
echo.
ping -n 2 127.0.0.1>nul
"%mainfolder%\_Tools\mysql.exe" --default-character-set=utf8 -u %user% --password=%pass% -h %host% --port=%port% acore_auth < "%mainfolder%\Data\data\sql\base\db_auth\realmlist.sql"
echo.
echo Server IP address successfully changed. The launcher will now open realmlist.wtf.
echo Replace the "127.0.0.1" after "set realmlist" with your "new" server IP and save.
echo.
pause
goto realmlist

:realmlist
echo.
cd .\_Client\Data\enUS
start realmlist.wtf.txt
goto menu

:read_me
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ___________________________Dinklepack Server Launcher v2.4____________________________
echo _______________________Made by Falmaril for Dinkledork's Repack_______________________
echo.
echo This launcher simplifies launching Dinkledork's AzerothCore Repack.
echo.
echo The first option starts MySQL.bat, authserver.exe and worldserver.exe.
echo.
echo The second option launches a modified version (by me) of Zaxer's Control Panel v3.1.
echo Which can run the abovementioned .bat and .exe files without them taking up space
echo in the taskbar. It can also autorestart the database and server on crashes.
echo.
echo The third option provides an easy way to download and update to the latest version
echo of the Dinklepack launcher, repack and client.
echo.
echo The fourth option simply explains how to create an account and make it an gm account.
echo.
echo The fifth option provides an easy way to export and import backups of the 
echo acroe_auth, acore_characters and acore_world SQL-databases. It also contains an option
echo to launch HeidiSQL for viewing\editing these databases - for those who know how to.
echo.
echo The sixth option takes you to Dinkledork's Toolbox which houses an array of different
echo and useful tools, commands and macros.
echo.
echo The seventh option, well you selected it and it brought you here, so guess what, it
echo takes you to this read me section.
echo.
echo The eight option simlpy turns the music/sounds on and off. Pretty self-explanatory.
echo.
echo Lastly, for a more aesthetically pleasing launcher make a shortcut and use the
echo AzerothCore.ico file in the _Tools folder.
echo.
echo 1 - Update Instructions
echo.
echo 2 - Changelog
echo.
echo 3 - Bug Reporting
echo.
echo 4 - Return To Menu
echo.
set /P read_me=Enter a number:
if "%read_me%"=="1" (goto update_instructions)
if "%read_me%"=="2" (goto changelog)
if "%read_me%"=="3" (goto bug_reporting)
if "%read_me%"=="4" (goto menu)
goto menu

:update_instructions
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo _______________________________!DOWNLOAD INSTRUCTIONS!________________________________
echo.
echo ATTENTION! These instructions ONLY apply if you choose to download and install the
echo Dinklepack Repack and Client MANUALLY through the links provided in the Discord. If
echo you use the launcher then follow the instructions given after each download/extract.
echo.
echo Always back up your custom content prior to updates. To ensure a smooth installation, 
echo please follow the steps below:
echo.
echo 1. Navigate to the following directory: Data - data - sql - custom - db_world 
echo 2. Delete all files and folders inside the 'db_world' directory.
echo 3. Extract this update to main Dinklepack directory, hit yes to overwrite, 
echo.   and run the server.
echo.
echo If you are brand new and have *just* downloaded from the main page:
echo.
echo 1. Run the 'worldserver' once before installing this update.
echo 2. Shut the server down.
echo 3. Navigate to the following directory: Data - data - sql - custom - db_world 
echo 4. Delete all files and folders inside the 'db_world' directory.
echo 5. Extract this update to main Dinklepack directory, hit yes to overwrite, 
echo    and run the server.
echo.
echo If you haven't used the server for a long time and have not yet updated to v9.0:
echo.
echo 1. Install version 9.0 and run world server once.
echo 2. Shut server down.
echo 3. Delete the files in Data - data - sql - custom - db_world 
echo 4. Extract this update to main Dinklepack directory and run the server.
echo.
echo For more explination please go to the Discord link below:
echo.
echo https:\\discord.com\channels\857134283130011649\1078330818918891611\1125651016260530186
echo.
echo Alternatively you can just use the 3. Downloads\Updates in the main menu of this launcher.
echo.
pause
goto read_me

:changelog
echo.
cd .\_ReadMe
start Changelog.rtf
goto read_me

:bug_reporting
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_achievement_menu_open.mp3 >nul
cls
echo ____________________________________Bug Reporting_____________________________________
echo.
echo For bug reporting please join the Discord link below:
echo.
echo https:\\discord.com\channels\857134283130011649\1104674600975085568
echo.
pause
goto read_me

:music_switch
if exist "%mainfolder%\_Tools\Music\music.on" goto music_off
if exist "%mainfolder%\_Tools\Music\music.off" goto music_on

:music_off
taskkill /f /im cmdmp3win.exe
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/wow_ig_main_menu_open.mp3 >nul
cls
del "%mainfolder%\_Tools\Music\music.on"
echo music > "%mainfolder%\_Tools\Music\music.off"
goto beginning

:music_on
if exist "%mainfolder%\_Tools\Music\music.off" start _Tools/cmdmp3win.exe _Tools/Music/wow_ig_main_menu_open.mp3 >nul
cls
del "%mainfolder%\_Tools\Music\music.off"
echo music > "%mainfolder%\_Tools\Music\music.on"
goto beginning

:close_launcher
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/launcher_outro.mp3 >nul
exit

:donate
start https://www.patreon.com/Dinklepack5

:pizza
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/dial_up_modem.mp3 >nul
cls
echo __________________________Pizza Hut Online Ordering Service___________________________
echo.
echo Initiating Pizza Hut Online Ordering Service Module... Please standy...
echo.                              
echo                                    ....:~iSSSSSJ7.                                     
echo                                .7JJJP5555P5555555#^                                     
echo                              .SGG5555Y55YYYYYYYYYPY.                                    
echo                             ~GG5YYYYYYYYYYYYYYYYYYPYi~:                                 
echo                         .^~7GPYYYYYYYYYYYYYYYYYYYYY5PPPYYY7^.                           
echo                     :~S5PP555YYYYYYYYYYYYYYYYYYYYYYYYYY555PPPS~:                        
echo                 :SY5PPP5YYYYYYYYY5555555555555555555555555555PPPP7                      
echo             .7JYPGPP55555P5555555YJJYYYYYYYYYYYYYYYYYYYYYYYYPPPP5J                      
echo             7PYYYYiiiiiiii:::::.::ii                        .::.                        
echo                                 ~GQ@#.                                                   
echo                   ~PPGGPPS.   7@@@G^      :SSSJPPPG7  ::7S777S:                         
echo                  P@@@Q#@@@#^  ~GS7~^^^^7SSi##BBQ@@@77GQQ#Q@@@@i                         
echo                 :#@@G. i@@@~ :P@S~GGB@@@@#. .~JQQ5:~Q@@#GQ@@@@S                         
echo                ^Q@@@i ~B@QG^^#@G:  ^P@@B7.^G#@@5i~^P@@@@@GJYGGP.                        
echo               .B@@@BSP#QY^ ~Q@i  .5@@B7   GQQ#GPGGGPi777^                               
echo               Y@@@G~7i:.  :#@Q ^J#@@@Q#GPPJSYGG#S    :i:                                
echo              i@@Qi        :7YJ ~555Y555Si7iiii7^    i#@5.:^7~                           
echo             .B@Q~           75J   .5Y.         ~SSSY@@@@QPJi:                           
echo             .Q@5           7@@@~  i@S ~JJ^  :P5SBB@@Q7^~^                               
echo              SJ.          ^Q@B~  ^P@B7#@@7 S#@#. ~Q@B                                   
echo                       :~75Q@@PYYPQ@@Y:Q@@GGGB@@S J@#~                                   
echo                     ~B@@@@@@@QGG@@@S  YB7~. ^B@S J@S                                    
echo                     .^iS@@@@Y. .Q@G.  .:     .:. ^i.                                    
echo                        :@@J~.  .YY.                                                     
echo                       iG@Y                                                              
echo                      .JJ^                                                               
echo.
timeout 30
goto error

:error
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/error.mp3 >nul
cls
echo ________________________________________ERROR_________________________________________
echo.
echo Couldn't connect to the server... Please check you internet connection and try again...
echo.
echo                                       7JJJJJJJJ7                                             
echo                                   ^7777YPPPPPPPP57777^                                        
echo                                ^~JBGGB^          :GGGBY~~                                      
echo                             .:^G#7                   i#B^:.                                   
echo                           ..i#B:                      .GQ7..                                 
echo                           5Q5..                        ..YQP                                 
echo                          P@P     SBBBB~       :BBBBJ     Y@B                                 
echo                         :PP7~^    Y@@@@i        ^@@@@5     ^~7PP^                              
echo                        :@@~      ^S777:        .7777~       ^@@~                              
echo                        :Q@i                                ^Q@~                              
echo                        :@@~           ~77777777i           ^@@~                              
echo                        :GG7~^       ~~5BGGGGGGBP~~.      :~iGG^                              
echo                          P@P    .:~B#~         :B#i:.    Y@B                                 
echo                           5@5..  SQG.           . 5QY ..YQG                                 
echo                           ..i#B: .:.              .:. .GQS..                                 
echo                             .^^P#7                   ~#G~^.                                   
echo                                ~iJGGGG^         :GGGGYii                                      
echo                                  ^SSSSY55555555YSSSS~                                        
echo                                       7YYYYYYYYS        
echo.
pause
goto menu

:exit
if exist "%mainfolder%\_Tools\Music\music.on" start _Tools/cmdmp3win.exe _Tools/Music/launcher_outro.mp3 >nul
exit