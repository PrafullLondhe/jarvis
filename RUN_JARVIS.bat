@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title JARVIS
if exist "%LOCALAPPDATA%\Python\pythoncore-3.14-64\python.exe" (
  set "JARVIS_PY=%LOCALAPPDATA%\Python\pythoncore-3.14-64\python.exe"
) else if exist ".venv\Scripts\python.exe" (
  set "JARVIS_PY=%CD%\.venv\Scripts\python.exe"
) else (
  for /f "delims=" %%P in ('where python 2^>nul') do if not defined JARVIS_PY set "JARVIS_PY=%%P"
)
if not defined JARVIS_PY (
  echo Python was not found.
  pause
  exit /b 1
)
echo Starting with:
"%JARVIS_PY%" -c "import sys; print(sys.executable)"
"%JARVIS_PY%" -c "from cv2 import face; face.LBPHFaceRecognizer_create(); print('Face ID ready')"
if errorlevel 1 (
  echo Face ID is not ready. Run FIX_FACE_ID.bat first.
  pause
  exit /b 1
)
"%JARVIS_PY%" main.py
if errorlevel 1 pause
