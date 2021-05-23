@echo off
echo 添加文件
call bat/add.bat
echo 同步文件
call bat/commit.bat
echo 推送更新
call bat/push.bat
pause