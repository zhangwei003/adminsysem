#! /bin/bsh
# 根据项目tag文件拉取文件
# 项目目录
dir_project=/Users/chenzhuo/Lnmp/dnmp/www/adminsysem
# 日志存储文件
file_log=/tmp/git.log
# tag文件
file_tag=$dir_project/demo.log
# 判断文件存在
if [ -e $file_tag ]; then
# 进入项目
cd $dir_project
# pull
git pull >> $file_log
# 删除tag
rm -rf $file_tag
#追加时间
date >> $file_log
else
echo "文件不存在"
fi
