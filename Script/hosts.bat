@echo off
chcp 65001 > nul
:: ERST 发布于MDU

:: 管理员权限运行CMD
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""cd %~dp0 && %~s0"" ::","","runas",1)(window.close)&&exit


set "domain=monikadesign.uk"
set "tracker=daisuki.monikadesign.uk"
set "temp_file=%temp%\temp_hosts.txt"
set "hosts_file=%SystemRoot%\System32\drivers\etc\hosts"
set "hosts_bak=%SystemRoot%\System32\drivers\etc\hosts_bak"
set "cfip="

:MENU
cls
ECHO.
ECHO.                        MDU HOSTS修改工具
ECHO.
ECHO.                       1  修改MDU HOSTS
ECHO.
ECHO.                       2  备份HOSTS文件
ECHO.
ECHO.                       3  还原HOSTS备份
ECHO.
ECHO.                       4  退   出
ECHO.
ECHO.
ECHO.
choice /C 12345 /N /M "请输入选择项目的序号："

IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO bakhosts
IF ERRORLEVEL 2 GOTO hostsbak
IF ERRORLEVEL 1 GOTO ip
PAUSE

:ip
cls
echo.
echo 填写之前优选的IP,填写完毕后按回车键(ENTER)开始运行
echo.
echo 示例IP:
echo    172.67.133.75
echo    2606:4700:3033::6815:ddb
echo.
echo.
echo.
set /p "cfip=请输入IP: "

set "hosts1=%cfip% %domain%"
set "hosts2=%cfip% %tracker%"

GOTO hosts

:hosts
echo 检查HOSTS文件是否存在，如果不存在，则创建一个HOSTS文件
if not exist "%hosts_file%" (
    type nul > "%hosts_file%"
)

GOTO one

:one
echo 检查是否有hosts备份文件，如果没有则创建hosts备份文件
if exist %hosts_bak% (GOTO edit) else (GOTO hostsone)

:edit
:: 创建临时文件以保存新的 hosts 内容，先排除指定关键字的行
(
    findstr /v /i /c:"%domain%" "%hosts_file%"
) > "%temp_file%"

:: 检查末尾是否为空行，不是空行则添加空行
powershell -Command "& {(Get-Content '%temp_file%')|ForEach-Object{$_}; if ((Get-Content '%temp_file%' -Raw) -notmatch '\r?\n$') { Add-Content '%temp_file%' '' }}"

:: 添加hosts
echo %hosts1%>> "%temp_file%"
echo %hosts2%>> "%temp_file%"

:: 替换 hosts 文件
move /y "%temp_file%" "%hosts_file%"

:: 清空DNS
ipconfig /flushdns

cls
echo.
echo 已完成修改HOSTS，测试是否可以正常访问MDU
echo 如遇到网络问题可尝试还原hosts备份
echo 按下 1 返回菜单
echo 按下 2 退出脚本
echo.
echo.
choice /C 12 /N /M "请输入选择项目的序号："
IF ERRORLEVEL 2 GOTO exit
IF ERRORLEVEL 1 GOTO MENU
:hostsone
echo.
echo 正在备份 Hosts
copy "%hosts_file%" "%hosts_bak%"

GOTO edit

:hostsbak
echo.
echo 正在备份 Hosts
copy "%hosts_file%" "%hosts_bak%"

GOTO MENU
 
:bakhosts
echo.
echo 正在恢复 Hosts
copy "%hosts_bak%" "%hosts_file%"

GOTO MENU

:exit
exit
:: ERST 发布于MDU