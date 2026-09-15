@echo off
chcp 65001 >nul
rem ============================================================
rem  设备密码管理系统 - Windows EXE 一键打包脚本
rem  使用方法：在 Windows 上双击本文件即可
rem  要求：已安装 Python 3.8+（安装时勾选 "Add Python to PATH"）
rem  产物：dist\DeviceManager.exe （单文件，可拷贝到任意电脑运行）
rem ============================================================
setlocal
cd /d "%~dp0"

echo.
echo  ============================================
echo   设备密码管理系统  Windows EXE 打包
echo  ============================================
echo.

rem ---- 1. 检查 Python ----
where python >nul 2>nul
if errorlevel 1 (
    echo  [错误] 未找到 Python，请先安装 Python 3.8+ 并勾选 Add to PATH
    echo         下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo  [1/3] 安装打包依赖（pyinstaller、openpyxl）...
python -m pip install --upgrade pip
python -m pip install pyinstaller openpyxl
if errorlevel 1 (
    echo  [错误] 依赖安装失败，请检查网络后重试
    pause
    exit /b 1
)

echo.
echo  [2/3] 开始打包，约 1~3 分钟，请稍候...
python -m PyInstaller --noconfirm --clean device_manager.spec
if errorlevel 1 (
    echo  [错误] 打包失败，请查看上方报错信息
    pause
    exit /b 1
)

echo.
echo  [3/3] 打包完成！
echo.
echo  ============================================
echo   EXE 文件位置: dist\DeviceManager.exe
echo   双击即可运行，无需安装 Python
echo   数据存放在:   %USERPROFILE%\.device_manager\
echo  ============================================
echo.
pause
endlocal
