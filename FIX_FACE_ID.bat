@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title JARVIS Face ID Repair
echo ===============================================
echo JARVIS - Repair OpenCV Face ID
echo ===============================================
echo.

REM Use the exact Python installation reported by the user's diagnostic first.
if exist "%LOCALAPPDATA%\Python\pythoncore-3.14-64\python.exe" (
  set "JARVIS_PY=%LOCALAPPDATA%\Python\pythoncore-3.14-64\python.exe"
) else if exist ".venv\Scripts\python.exe" (
  set "JARVIS_PY=%CD%\.venv\Scripts\python.exe"
) else (
  for /f "delims=" %%P in ('where python 2^>nul') do if not defined JARVIS_PY set "JARVIS_PY=%%P"
)

if not defined JARVIS_PY (
  echo ERROR: Python was not found.
  pause
  exit /b 1
)

echo This repair will use:
"%JARVIS_PY%" -c "import sys; print(sys.executable); print(sys.version)"
if errorlevel 1 goto failed

echo.
echo Updating pip...
"%JARVIS_PY%" -m pip install --upgrade pip
if errorlevel 1 goto failed

echo.
echo Removing all OpenCV package variants to prevent conflicts...
"%JARVIS_PY%" -m pip uninstall -y opencv-python opencv-python-headless opencv-contrib-python opencv-contrib-python-headless

echo.
echo Installing the contrib build (this contains cv2.face and LBPH)...
"%JARVIS_PY%" -m pip install --no-cache-dir --only-binary=:all: --force-reinstall opencv-contrib-python
if errorlevel 1 goto failed

echo.
echo Verifying the actual Face ID API...
"%JARVIS_PY%" -c "import sys,cv2; print('Python:',sys.executable); print('OpenCV:',cv2.__version__); print('cv2:',cv2.__file__); from cv2 import face; print('cv2.face:',face); recognizer=face.LBPHFaceRecognizer_create(); print('SUCCESS: LBPH Face ID is ready')"
if errorlevel 1 goto failed

echo.
echo SUCCESS. OpenCV contrib and LBPH are working in this Python.
echo Now start JARVIS using RUN_JARVIS.bat in this same folder.
pause
exit /b 0

:failed
echo.
echo REPAIR FAILED.
echo Please take a screenshot of the full error above and send it.
pause
exit /b 1
