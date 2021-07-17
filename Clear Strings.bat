::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
title
mode 55,3
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:AdminRequest
    IF "PROCESSOR_ARCHITECTURE" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

)

if '%errorlevel%' NEQ '0' (
color 0E
mode 49,3
echo.
title 
call :ColorText 0F "[" && call :ColorText 44 "-" && call :ColorText 07 "]" && call :ColorText 07 " Requesting admin permission..."
    goto GetAdmin
) else ( goto FAdmin )

:GetAdmin
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""09
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "temp\getadmin.vbs"
    exit \B

:FAdmin
    pushd "%CD%"
    CD /D "%~dp0"
goto Quest1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quest1
title 
echo. 
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Do you want to clear some directories? (y/n)
choice /c yn /n
if %errorlevel%==1 goto Directories
if %errorlevel%==2 goto Quest2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quest2
echo. 
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Do you want to clear some reg keys? (y/n)
choice /c yn /n
if %errorlevel%==1 goto Regedit
if %errorlevel%==2 goto Quest3

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quest3
echo.
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Do you want to crash some processes? (y/n)
choice /c yn /n
if %errorlevel%==1 goto Crash
if %errorlevel%==2 goto Quest4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quest4
cls
echo.
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Do you want to change your pc time? (y/n)
choice /c yn /n
if %errorlevel%==1 goto Time
if %errorlevel%==2 goto Quest5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Quest5
echo.
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Do you want to Self Delete? (y/n)
choice /c yn /n
if %errorlevel%==1 goto SelfDelete
if %errorlevel%==2 exit

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Directories
del /q/f/s C:\Users\%username%\Recent\*
del /q/f/s C:\Windows\Temp\* >nul
del /q/f/s %temp%\* >nul
del /q/f/s C:\Windows\Prefetch\* >nul
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  Recent has been successfully cleared.
timeout /t 2 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  Temp has been successfully cleared.
timeout /t 2 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  Prefetch has been successfully cleared.
timeout /t 3 >nul
cls
goto Quest2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Regedit
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Persisted" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\ShellNoRoam\MUICache" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f >nul
reg delete "HKEY_CURRENT_USER\Software\WinRAR\ArcHistory" /f >nul
echo.
call :ColorText 0F "["
call :ColorText 66 "-"
call :ColorText 0F "]"
echo  Clearing reg keys.
timeout /t 5 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  Reg keys has been successfully cleared.
timeout /t 3 >nul
cls
goto Quest3

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Crash
sc stop pcasvc >nul
sc stop dps >nul
taskkill /f /im searchindexer.exe >nul
sc stop dnscache >nul
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  DPS has been successfully crashed.
timeout /t 3 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  PcaSvc has been sucessfully crashed.
timeout /t 3 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  SearchIndexer has been successfully crashed.
timeout /t 3 >nul
cls
echo.
call :ColorText 0F "["
call :ColorText AA "-"
call :ColorText 0F "]"
echo  DNSCache has been successfully crashed.
timeout /t 3 >nul
cls
goto Quest4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Time
cls
time
goto Quest5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SelfDelete
echo.
call :ColorText 0F "["
call :ColorText 44 "-"
call :ColorText 0F "]"
echo  Self Deleting...
timeout /t 3 >nul
start /b "" cmd /c del "%~f0"&exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

goto :Beginoffile
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
:Beginoffile

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
