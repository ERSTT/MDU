@ECHO OFF
chcp 65001 > nul
cd %~dp0
:: ERST 发布于MDU
if exist CloudflareST.exe (GOTO t2) else (GOTO DL)
:t2
if exist ip.txt (GOTO t3) else (GOTO DL)
:t3
if exist ipv6.txt (GOTO MENU) else (GOTO DL)

:DL
ECHO.检测到缺少CloudflareST.exe等相关文件 正在获取....
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo 检测到32位系统，正在下载32位CloudflareST程序
    powershell -command "(new-object Net.WebClient).DownloadFile('https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_386.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo 检测到64位系统，正在下载64位CloudflareST程序
    powershell -command "(new-object Net.WebClient).DownloadFile('https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_amd64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo 检测到ARM64架构系统，正在下载ARM64的CloudflareST程序
    powershell -command "(new-object Net.WebClient).DownloadFile('https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.2.5/CloudflareST_windows_arm64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else (
    echo 未知系统架构，脚本正在退出
    exit /b 1
)

if exist CloudflareST.exe (GOTO t4) else (GOTO DL2)
:t4
if exist ip.txt (GOTO t5) else (GOTO DL2)
:t5
if exist ipv6.txt (GOTO zip) else (GOTO DL2)

:DL2
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo 下载失败，正在尝试使用备用链接下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://ghproxy.org/https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_386.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo 下载失败，正在尝试使用备用链接下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://ghproxy.org/https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_amd64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo 下载失败，正在尝试使用备用链接下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://ghproxy.org/https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.2.5/CloudflareST_windows_arm64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
)

if exist CloudflareST.exe (GOTO t6) else (GOTO DL3)
:t6
if exist ip.txt (GOTO t7) else (GOTO DL3)
:t7
if exist ipv6.txt (GOTO zip) else (GOTO DL3)

:DL3
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo 下载失败，正在尝试使用备用链接2下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://mirror.ghproxy.com/https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_386.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo 下载失败，正在尝试使用备用链接2下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://mirror.ghproxy.com/https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_windows_amd64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo 下载失败，正在尝试使用备用链接2下载
    powershell -command "(new-object Net.WebClient).DownloadFile('https://mirror.ghproxy.com/https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.2.5/CloudflareST_windows_arm64.zip','CloudflareST.zip')" 2>nul
	powershell -command "Expand-Archive -Force '%~dp0CloudflareST.zip' '%~dp0'" 2>nul
)

if exist CloudflareST.exe (GOTO t8) else (GOTO DL4)
:t8
if exist ip.txt (GOTO t9) else (GOTO DL4)
:t9
if exist ipv6.txt (GOTO zip) else (GOTO DL4)

:DL4
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo 下载失败，尝试自行下载CloudflareST_windows_386.zip
	echo 10秒后脚本自动退出
	timeout /nobreak /t 10 >nul
	exit
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo 下载失败，尝试自行下载CloudflareST_windows_amd64.zip
	echo 10秒后脚本自动退出
	timeout /nobreak /t 10 >nul
	exit
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    echo 下载失败，尝试自行下载CloudflareST_windows_arm64.zip
	echo 10秒后脚本自动退出
	timeout /nobreak /t 10 >nul
	exit
)

if exist CloudflareST.exe (GOTO zip) else (GOTO DL4)

:zip
del CloudflareST.zip
del cfst_3proxy.bat
del cfst_hosts.bat
del "使用+错误+反馈说明.txt"

GOTO MENU

:MENU
cls
ECHO.
ECHO.                       Cloudflare测速工具
ECHO.
ECHO.                       1  测速IPV4
ECHO.
ECHO.                       2  测速IPV6
ECHO.
ECHO.                       3  测速IPV4+IPV6
ECHO.
ECHO.                       4  退   出
ECHO.
ECHO.
ECHO.
choice /C 12345 /N /M "请输入选择项目的序号："

IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO cmd3
IF ERRORLEVEL 2 GOTO cmd2
IF ERRORLEVEL 1 GOTO cmd1
PAUSE

:cmd1

echo. | CloudflareST.exe -url https://cdn.cloudflare.steamstatic.com/steam/apps/256843155/movie_max.mp4 -f ip.txt -o "" | find /v "按下 回车键 或 Ctrl+C 退出"


ECHO.按下 1 返回菜单
ECHO.按下 2 退出脚本
ECHO.
ECHO.
choice /C 12 /N /M "请输入选择项目的序号："

IF ERRORLEVEL 2 GOTO exit
IF ERRORLEVEL 1 GOTO MENU
PAUSE

:cmd2

echo. | CloudflareST.exe  -url https://cdn.cloudflare.steamstatic.com/steam/apps/256843155/movie_max.mp4 -f ipv6.txt -o "" | find /v "按下 回车键 或 Ctrl+C 退出"


ECHO.按下 1 返回菜单
ECHO.按下 2 退出脚本
ECHO.
ECHO.
choice /C 12 /N /M "请输入选择项目的序号："

IF ERRORLEVEL 2 GOTO exit
IF ERRORLEVEL 1 GOTO MENU
PAUSE

:cmd3
echo. | CloudflareST.exe  -url https://cdn.cloudflare.steamstatic.com/steam/apps/256843155/movie_max.mp4 -f "ip.txt" -f "ipv6.txt" -o "" | find /v "按下 回车键 或 Ctrl+C 退出"


ECHO.按下 1 返回菜单
ECHO.按下 2 退出脚本
ECHO.
ECHO.
choice /C 12 /N /M "请输入选择项目的序号："

IF ERRORLEVEL 2 GOTO exit
IF ERRORLEVEL 1 GOTO MENU
PAUSE

:exit
exit
:: ERST 发布于MDU
