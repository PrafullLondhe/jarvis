@echo off
title JARVIS - Install 3D GLB Viewer
cd /d "%~dp0"
echo Installing the embedded 3D model viewer...
python -m pip install PyQt6-WebEngine
if errorlevel 1 (
  echo.
  echo Installation failed. Check Python and internet connection.
  pause
  exit /b 1
)
echo.
echo 3D viewer dependency installed.
echo Now launch JARVIS using your normal start script.
pause
