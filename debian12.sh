#!/bin/bash

# 确保脚本以 root 权限运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以 root 权限运行" 1>&2
   exit 1
fi

# 更新软件包和安装升级所需的软件包
apt update && apt upgrade -y
apt install -y apt-transport-https

# 备份现有的 sources.list 文件
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 将源列表更改为 Debian 12 的源
sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list

# 更新软件包索引
apt update

# 升级系统
apt full-upgrade -y

# 删除不再需要的软件包
apt autoremove -y

# 清理缓存
apt clean

# 重启系统
echo "系统将在 10 秒后重启"
sleep 10
reboot
