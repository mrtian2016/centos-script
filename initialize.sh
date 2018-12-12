#!/bin/bash
# 检查是否为root用户
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install software"
    exit 1
fi

# 切换到用户目录
cd ~
touch initialize-script.log
log_file=initialize-script.log
if [ -f "${log_file}" ];then
 echo "Warning: You have already run this script"
 exit 1
fi

# 安装第三方源
echo "Installing third-party sources..."
yum -y install epel-release >> initialize-script.log

#安装yum-axelge,安装软件时可以并行下载
echo "Installing yum-axelget..."
yum -y install yum-axelget >> initialize-script.log

# 更新软件
yum -y update >> initialize-script.log

# 安装 zsh wget screen git
echo "Installing zsh wget screen git..."
yum -y install zsh wget screen git vim >> initialize-script.log

# 切换 shell
chsh -s /bin/zsh

# 安装 Oh-My-Zsh
echo "Installing Oh-My-Zsh..."
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh >> initialize-script.log

# 一些alias
echo "Writing some alias..."
echo "alias vi=vim" >> ~/.zshrc
echo -e "alias reload=\"source ~/.zshrc && echo '>> OH MY, ZSH configurations are reloaded! '\"" >> ~/.zshrc
# 更改语言
echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local
echo "Complete !!! Have Fun !!!"

