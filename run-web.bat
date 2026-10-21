@echo off
setlocal enabledelayedexpansion
title thrift - Web Server

echo ========================================================
echo   thrift -- The Campus Exchange Web Server
echo   Launching Web Application on port 8080...
echo ========================================================

:: Detect Java Runtime
set JAVA_CMD=java
where java >nul 2>nul
if %errorlevel% neq 0 (
    if defined JAVA_HOME (
        set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
    ) else if exist "C:\Program Files\Java\jdk-27.0.1\bin\java.exe" (
        set "JAVA_CMD=C:\Program Files\Java\jdk-27.0.1\bin\java.exe"
    ) else if exist "C:\Program Files\Java\latest\bin\java.exe" (
        set "JAVA_CMD=C:\Program Files\Java\latest\bin\java.exe"
    ) else (
        echo [ERROR] java was not found on PATH or in standard Java directories.
        pause
        exit /b 1
    )
)

:: Check if compiled classes exist
if not exist "bin\web\WebServer.class" (
    echo [INFO] Web server not compiled yet. Running compile.bat...
    call compile.bat
)

:: Run Web Server
"!JAVA_CMD!" -cp "bin;lib\*" web.WebServer

if %errorlevel% neq 0 (
    echo.
    echo [INFO] Web server exited with code %errorlevel%.
    pause
)
