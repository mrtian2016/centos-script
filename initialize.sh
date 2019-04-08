#!/bin/bash
# 检查是否为root用户
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install software"
    exit 1
fi

# 切换到用户目录
cd ~

log_file="initialize-script-log"

if [ -f "./${log_file}" ]; then
    echo "Warning: You have already run this script"
    exit 1
fi

touch $log_file

# 安装第三方源
echo "Installing third-party sources..."
yum -y install epel-release >> $log_file


#安装yum-axelge,安装软件时可以并行下载
echo "Installing yum-axelget..."
yum -y install yum-axelget >> $log_file

# 更新软件
yum -y update >> $log_file

# 安装 zsh wget screen git
echo "Installing zsh wget screen git..."
yum -y install zsh wget screen git vim htop net-tools >> $log_file

# 切换 shell
chsh -s /bin/zsh

# 安装 Oh-My-Zsh
echo "Installing Oh-My-Zsh..."
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh >> $log_file

# 一些alias
echo "Writing some alias..."
echo "alias vi=vim" >> ~/.zshrc
echo -e "alias reload=\"source ~/.zshrc && echo '>> OH MY, ZSH configurations are reloaded! '\"" >> ~/.zshrc
echo "Complete !!! Have Fun !!!"
zsh
source ~/.zshrc

