@echo off

@REM echo Working directory is %~dp0
@REM echo Download ffmpeg from https://ffmpeg.org/download.html and place it here.

:choice
echo options: 
echo "1. Quit" 
echo "2. Convert Original" 
echo "3. Convert Down to 1080" 
echo "4. Convert Down to 720" 
echo "5. Convert Down to 480" 
echo "6. Convert Whole Folder - Original" 
echo "7. Convert Whole Folder - 720" 
echo "8. Convert to HEVC"

set /p choice="Select an option: "

if "%choice%"=="1" goto :Quit
if "%choice%"=="2" goto :ConvertOriginal
if "%choice%"=="3" goto :ConvertDown1080
if "%choice%"=="4" goto :ConvertDown720
if "%choice%"=="5" goto :ConvertDown480
if "%choice%"=="6" goto :ConvertFolderOriginal
if "%choice%"=="7" goto :ConvertFolder720
if "%choice%"=="8" goto :ConvertHEVC

:Quit
exit /b

:ConvertOriginal
set /p entry=Drag video here: 
@REM %~dp0ffmpeg -i "%entry%" -movflags faststart -vcodec h264 -acodec aac "%~n1n.mp4"
ffmpeg -i "%entry%" -movflags faststart -vcodec h264 -acodec aac "%entry%n.mp4"
goto :choice

:ConvertDown1080
set /p entry=Drag video here: 
ffmpeg -i "%entry%" -vf scale=-1:1080 -movflags faststart -vcodec h264 -acodec aac "%entry%n.mp4"
goto :choice

:ConvertDown720
set /p entry=Drag video here: 
ffmpeg -i "%entry%" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "%entry%n.mp4"
goto :choice

:ConvertDown480
set /p entry=Drag video here: 
ffmpeg -i "%entry%" -vf scale=-2:480 -movflags faststart -vcodec h264 -acodec aac "%entry%n.mp4"
goto :choice

:ConvertFolderOriginal
set /p entry=Drag folder here: 
for %%i in ("%entry%\*.mp4") do (
    ffmpeg -i "%%i" -movflags faststart -vcodec h264 -acodec aac "%%i.n.mp4"
)
goto :choice

:ConvertFolder720
set /p entry=Drag folder here: 
for %%i in ("%entry%\*.mp4") do (
    ffmpeg -i "%%i" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "%%i.n.mp4"
)
goto :choice

:ConvertHEVC
set /p entry=Drag video here: 
ffmpeg -i "%entry%" -movflags faststart -vcodec libx265 -acodec aac "%entry%n.mp4"
goto :choice

:End