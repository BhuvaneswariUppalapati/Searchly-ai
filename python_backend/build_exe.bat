@echo off
echo ============================================
echo  Searchly AI - Build Python Backend .exe
echo ============================================
echo.
echo This compiles server.py into a standalone searchly_server.exe
echo that works WITHOUT Python installed on the end user's machine.
echo.
echo First-time build takes 5-10 minutes and requires ~2GB disk space.
echo.

:: Check PyInstaller is installed
python -m PyInstaller --version >nul 2>&1
if errorlevel 1 (
    echo Installing PyInstaller...
    python -m pip install pyinstaller
)

:: Run PyInstaller
echo Building searchly_server.exe...
python -m PyInstaller searchly_server.spec --noconfirm --clean

if errorlevel 1 (
    echo.
    echo ERROR: Build failed. Check the output above.
    pause
    exit /b 1
)

:: Copy the output folder to where Electron expects it
echo.
echo Copying output to ../resources/python_server/ ...
if not exist "..\resources" mkdir "..\resources"
xcopy /E /I /Y "dist\searchly_server" "..\resources\python_server"

echo.
echo ============================================
echo  Done! searchly_server.exe is ready.
echo  Now run: npm run build:win
echo ============================================
pause
