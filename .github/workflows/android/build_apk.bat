@echo off
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "ANDROID_SDK_ROOT=%LOCALAPPDATA%\Android\Sdk"
set "JAVA_HOME=C:\Progra~1\Microsoft\jdk-21.0.10.7-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo Building APK Debug...
call gradlew.bat assembleDebug --no-daemon
if %ERRORLEVEL% EQU 0 (
    echo BUILD SUKSES!
) else (
    echo BUILD GAGAL!
)
