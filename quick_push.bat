@echo off
setlocal EnableDelayedExpansion
title Zit Tech Lab - Git Quick Sync Tool
color 0B

echo =======================================================
echo          ZIT TECH LAB - GIT QUICK SYNC TOOL
echo =======================================================
echo.

REM Kiem tra phan mem Git
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Git chua duoc cai dat hoac khong co trong bien moi truong PATH!
    echo Vui long kiem tra lai Git tren may tinh cua ban.
    echo.
    pause
    exit /b 1
)

REM Kiem tra trang thai thay doi
set HAS_CHANGES=
for /f "tokens=*" %%i in ('git status --porcelain 2^>nul') do (
    set HAS_CHANGES=1
)

if not defined HAS_CHANGES (
    echo [THONG BAO] Khong co tap tin nao thay doi hoac chua luu!
    echo Thu muc lam viec dang sach se - Working tree clean.
    echo.
    echo Khong can commit hoac push them gi.
    echo =======================================================
    echo.
    pause
    exit /b 0
)

echo [DANH SACH TAP TIN THAY DOI]:
echo -------------------------------------------------------
git status -s
echo -------------------------------------------------------
echo.

REM Nhap noi dung commit
set "MSG="
set /p "MSG=>> Nhap loi nhan commit (Nhan ENTER de tu dong lay gio): "

if "!MSG!"=="" (
    set "MSG=update: auto-sync %DATE% %TIME%"
)

echo.
echo [1/3] Dang them cac tap tin thay doi (git add -A)...
git add -A
if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Lenh git add that bai!
    pause
    exit /b 1
)

echo [2/3] Dang tao commit moi...
git commit -m "!MSG!"
if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Khong the tao commit!
    pause
    exit /b 1
)

echo [3/3] Dang day len GitHub (git push origin main)...
git push origin main
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [LOI] Qua trinh git push that bai!
    echo Vui long kiem tra ket noi mang hoac quyen truy cap.
    echo.
    pause
    exit /b 1
)

echo.
echo =======================================================
echo  THANH CONG! Moi thay doi da duoc day len GitHub.
echo =======================================================
echo.
pause
