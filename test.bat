@echo off
setlocal enabledelayedexpansion
title thrift - Run Verification Test Suite

echo ========================================================
echo   thrift -- The Campus Exchange
echo   Running Automated Test Suite...
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
        echo [ERROR] java was not found.
        pause
        exit /b 1
    )
)

"!JAVA_CMD!" -cp "bin;lib\*" AppTest

pause
