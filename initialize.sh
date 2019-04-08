#!/bin/bash

show_usage="args: [-l , -f , -s ]\
                                  [--lnmp=, --firewalld=, --selinux=]"


# lnmp 默认不安装 参数可以为 lnmp|lnmpa|lamp|nginx|db|mphp 
lnmp=false

# 防火墙默认关闭
firewalld=false

# SELinux默认关闭
selinux=false

GETOPT_ARGS=`getopt -a -o l:f:s: -l lnmp:,firewalld:,selinux: -- "$@"`
eval set -- $GETOPT_ARGS

#获取参数
while [ -n "$1" ]
do
        case "$1" in
                -l|--lnmp) lnmp=$2; shift 2;;
                -f|--firewalld) firewalld=$2; shift 2;;
                -s|--selinux) selinux=$2; shift 2;;
                --) break ;;
                *) echo $1,$2,$show_usage; exit 0 ;;
        esac
done
install_lnmp=false

case "$lnmp" in
    lnmp|lnmpa|lamp|nginx|db|mphp)
         install_lnmp=true;;
     *)
        echo "lnmp 参数错误"; break;;
esac

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
yum -y install epel-release | tee $log_file


#安装yum-axelge,安装软件时可以并行下载
echo "Installing yum-axelget..."
yum -y install yum-axelget | tee $log_file

# 更新软件
yum -y update | tee $log_file

# 安装 zsh wget screen git
echo "Installing zsh wget screen git..."
yum -y install zsh wget screen git vim htop net-tools | tee $log_file

# 切换 shell
chsh -s /bin/zsh
zsh
# 安装 Oh-My-Zsh
echo "Installing Oh-My-Zsh..."
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh | tee $log_file

# 一些alias
echo "Writing some alias..."
echo "alias vi=vim" >> ~/.zshrc
echo -e "alias reload=\"source ~/.zshrc && echo '| tee OH MY, ZSH configurations are reloaded! '\"" >> ~/.zshrc
echo "Complete !!! Have Fun !!!"
source ~/.zshrc

if [ "$selinux" = false ] ; then
    # 关闭SELinux
    echo "关闭SELinux"
    setenforce 0
    sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
fi

if [ "$firewalld" = false ] ; then
    # 关闭防火墙
    echo "关闭防火墙"
    systemctl stop firewalld.service
    systemctl disable firewalld.service
fi

if [ "$install_lnmp" = true ]; then
    echo "安装$lnmp"
    wget http://soft.vpser.net/lnmp/lnmp1.5.tar.gz -cO lnmp1.5.tar.gz && tar zxf lnmp1.5.tar.gz && cd lnmp1.5 && ./install.sh "$lnmp"
fi

