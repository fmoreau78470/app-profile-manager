@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: -----------------------------------------------------------------------------
:: CONFIGURATION DES DOSSIERS ET REGISTRE
:: -----------------------------------------------------------------------------
set "PROFILES_DIR=%USERPROFILE%\Documents\APP_Profiles"
set "REG_KEY=HKCU\Software\JavaSoft\Prefs\astropixelprocessor"
set "LAST_CHARGED_FILE=%PROFILES_DIR%\.last_loaded"
set "LANG_FILE=%PROFILES_DIR%\.language"
set "APP_EXE=AstroPixelProcessor.exe"

:: Detection du chemin d'installation de APP
set "APP_PATH="
if exist "C:\Program Files\AstroPixelProcessor\AstroPixelProcessor.exe" (
    set "APP_PATH=C:\Program Files\AstroPixelProcessor\AstroPixelProcessor.exe"
) else if exist "C:\Program Files (x86)\AstroPixelProcessor\AstroPixelProcessor.exe" (
    set "APP_PATH=C:\Program Files (x86)\AstroPixelProcessor\AstroPixelProcessor.exe"
)

if not exist "%PROFILES_DIR%" mkdir "%PROFILES_DIR%"

:: -----------------------------------------------------------------------------
:: GESTION DE LA LANGUE
:: -----------------------------------------------------------------------------
if not exist "%LANG_FILE%" (
    cls
    echo ==========================================
    echo    LANGUAGE SELECTION / CHOIX DE LANGUE
    echo ==========================================
    echo  1] Francais
    echo  2] English
    echo ==========================================
    set /p "LANG_CHOICE=Choice / Choix [1-2] : "
    if "!LANG_CHOICE!"=="2" (
        echo EN> "%LANG_FILE%"
    ) else (
        echo FR> "%LANG_FILE%"
    )
)

set /p CURRENT_LANG=<"%LANG_FILE%"

:: Dictionnaires de textes
if "%CURRENT_LANG%"=="EN" (
    set "TXT_TITLE=APP PROFILE MANAGER - Windows"
    set "TXT_ACTIVE=Active profile loaded"
    set "TXT_NONE=None"
    set "TXT_M1=1] Launch APP - current configuration"
    set "TXT_M2=2] Save current configuration"
    set "TXT_M3=3] Select a configuration"
    set "TXT_M4=4] Select a configuration AND launch APP"
    set "TXT_M5=5] Delete a saved configuration"
    set "TXT_M6=6] Switch language - FR/EN"
    set "TXT_M7=7] Quit"
    set "TXT_CHOICE=Your choice [1-7] : "
    set "TXT_LAUNCHING=Launching Astro Pixel Processor..."
    set "TXT_APP_OPEN=APP is currently running! Please close it first."
    set "TXT_ENTER_NAME=Enter profile name - ex: LRGB_Default : "
    set "TXT_INVALID_NAME=Invalid name."
    set "TXT_EXISTS=Profile already exists. Overwrite? [y/N] : "
    set "TXT_SAVED=Configuration saved as"
    set "TXT_SELECT_PROMPT=Select a profile number : "
    set "TXT_NO_PROFILES=No saved profiles found."
    set "TXT_APPLIED=Profile applied successfully!"
    set "TXT_CONFIRM_DEL=Delete profile permanently? [y/N] : "
    set "TXT_DELETED=Profile deleted."
    set "TXT_NOT_FOUND=AstroPixelProcessor.exe was not found in Program Files!"
    set "TXT_BYE=Goodbye!"
) else (
    set "TXT_TITLE=GESTIONNAIRE DE PROFILS - APP Windows"
    set "TXT_ACTIVE=Profil actif charge"
    set "TXT_NONE=Aucun"
    set "TXT_M1=1] Lancer APP - configuration actuelle"
    set "TXT_M2=2] Sauvegarder la configuration actuelle"
    set "TXT_M3=3] Choisir une configuration"
    set "TXT_M4=4] Choisir une configuration ET lancer APP"
    set "TXT_M5=5] Supprimer une configuration enregistree"
    set "TXT_M6=6] Changer de langue - FR/EN"
    set "TXT_M7=7] Quitter"
    set "TXT_CHOICE=Ton choix [1-7] : "
    set "TXT_LAUNCHING=Lancement d Astro Pixel Processor..."
    set "TXT_APP_OPEN=APP est ouvert ! Veuillez le fermer d abord."
    set "TXT_ENTER_NAME=Entre le nom du profil - ex: LRGB_Default : "
    set "TXT_INVALID_NAME=Nom invalide."
    set "TXT_EXISTS=Le profil existe deja. L ecraser ? [o/N] : "
    set "TXT_SAVED=Configuration enregistree sous"
    set "TXT_SELECT_PROMPT=Choisis un numero de profil : "
    set "TXT_NO_PROFILES=Aucun profil enregistre."
    set "TXT_APPLIED=Profil applique avec succes !"
    set "TXT_CONFIRM_DEL=Supprimer definitivement le profil ? [o/N] : "
    set "TXT_DELETED=Profil supprime."
    set "TXT_NOT_FOUND=AstroPixelProcessor.exe est introuvable dans Program Files !"
    set "TXT_BYE=Au revoir !"
)

:: -----------------------------------------------------------------------------
:: MENU PRINCIPAL
:: -----------------------------------------------------------------------------
:MAIN_MENU
cls
set "LAST_PROFILE=%TXT_NONE%"
if exist "%LAST_CHARGED_FILE%" set /p LAST_PROFILE=<"%LAST_CHARGED_FILE%"

echo ==========================================
echo    %TXT_TITLE%
echo    %TXT_ACTIVE% : [%LAST_PROFILE%]
echo ==========================================
echo  %TXT_M1%
echo  %TXT_M2%
echo  %TXT_M3%
echo  %TXT_M4%
echo  %TXT_M5%
echo  %TXT_M6%
echo  %TXT_M7%
echo ==========================================
set /p "MENU_CHOICE=%TXT_CHOICE%"

if "%MENU_CHOICE%"=="1" goto LAUNCH_APP
if "%MENU_CHOICE%"=="2" goto SAVE_CONFIG
if "%MENU_CHOICE%"=="3" (
    call :SELECT_CONFIG
    pause
    goto MAIN_MENU
)
if "%MENU_CHOICE%"=="4" (
    call :SELECT_CONFIG
    if "!APPLIED!"=="1" goto LAUNCH_APP
    pause
    goto MAIN_MENU
)
if "%MENU_CHOICE%"=="5" goto DELETE_CONFIG
if "%MENU_CHOICE%"=="6" goto SWITCH_LANG
if "%MENU_CHOICE%"=="7" exit

goto MAIN_MENU

:: -----------------------------------------------------------------------------
:: FONCTIONS ET ACTIONS
:: -----------------------------------------------------------------------------

:LAUNCH_APP
echo.
if defined APP_PATH (
    echo %TXT_LAUNCHING%
    start "" "%APP_PATH%"
    exit
) else (
    echo %TXT_NOT_FOUND%
    pause
    goto MAIN_MENU
)

:SAVE_CONFIG
echo.
tasklist /FI "IMAGENAME eq %APP_EXE%" 2>NUL | find /I /N "%APP_EXE%">NUL
if "%ERRORLEVEL%"=="0" (
    echo %TXT_APP_OPEN%
    pause
    goto MAIN_MENU
)

set /p "PROFILE_NAME=%TXT_ENTER_NAME%"
if "%PROFILE_NAME%"=="" (
    echo %TXT_INVALID_NAME%
    pause
    goto MAIN_MENU
)

set "TARGET=%PROFILES_DIR%\%PROFILE_NAME%.reg"

if exist "%TARGET%" (
    set /p "CONFIRM=%TXT_EXISTS%"
    if /I not "!CONFIRM!"=="o" if /I not "!CONFIRM!"=="y" goto MAIN_MENU
)

reg export "%REG_KEY%" "%TARGET%" /y >nul 2>&1
echo %TXT_SAVED% : %PROFILE_NAME%.reg
pause
goto MAIN_MENU

:SELECT_CONFIG
set "APPLIED=0"
echo.
tasklist /FI "IMAGENAME eq %APP_EXE%" 2>NUL | find /I /N "%APP_EXE%">NUL
if "%ERRORLEVEL%"=="0" (
    echo %TXT_APP_OPEN%
    exit /b
)

set "count=0"
for %%F in ("%PROFILES_DIR%\*.reg") do (
    set /a count+=1
    set "file_!count!=%%~nF"
    set "fullpath_!count!=%%F"
)

if %count%==0 (
    echo %TXT_NO_PROFILES%
    exit /b
)

echo --- Profiles ---
for /l %%I in (1,1,%count%) do (
    echo  [%%I] !file_%%I!
)
echo ----------------

set /p "CHOICE=%TXT_SELECT_PROMPT%"
if not defined file_%CHOICE% (
    echo %TXT_INVALID_NAME%
    exit /b
)

reg import "!fullpath_%CHOICE%!" >nul 2>&1
echo !file_%CHOICE%!> "%LAST_CHARGED_FILE%"
echo %TXT_APPLIED%
set "APPLIED=1"
exit /b

:DELETE_CONFIG
echo.
set "count=0"
for %%F in ("%PROFILES_DIR%\*.reg") do (
    set /a count+=1
    set "file_!count!=%%~nF"
    set "fullpath_!count!=%%F"
)

if %count%==0 (
    echo %TXT_NO_PROFILES%
    pause
    goto MAIN_MENU
)

echo --- Profiles ---
for /l %%I in (1,1,%count%) do (
    echo  [%%I] !file_%%I!
)
echo ----------------

set /p "CHOICE=%TXT_SELECT_PROMPT%"
if not defined file_%CHOICE% (
    echo %TXT_INVALID_NAME%
    pause
    goto MAIN_MENU
)

set "SURE=0"
set /p "CONFIRM=%TXT_CONFIRM_DEL%"
if /I "!CONFIRM!"=="o" set "SURE=1"
if /I "!CONFIRM!"=="y" set "SURE=1"

if "%SURE%"=="1" (
    del /f /q "!fullpath_%CHOICE%!"
    echo %TXT_DELETED%
    if exist "%LAST_CHARGED_FILE%" (
        set /p LAST_NAME=<"%LAST_CHARGED_FILE%"
        if "!LAST_NAME!"=="!file_%CHOICE%!" del /f /q "%LAST_CHARGED_FILE%"
    )
)
pause
goto MAIN_MENU

:SWITCH_LANG
if exist "%LANG_FILE%" del /f /q "%LANG_FILE%"
call "%~f0"
exit