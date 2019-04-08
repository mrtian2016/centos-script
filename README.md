# centos-script

参数：
  ```args: [-l , -f , -s ] [--lnmp=, --firewalld=, --selinux=]```

-  -l|--lnmp : 是否安装lnmp 默认不安装 参数: lnmp|lnmpa|lamp|nginx|db|mphp 具体使用请参考 [ https://lnmp.org/ ](#)
- -f|—firewalld: 防火墙，默认关闭，开启:true
- -s|—selinux: SELinux墙，默认关闭，开启:true

	 
例如仅安装NGINX并关闭selinux和防火墙的命令为:
 ```curl -o- -L -s https://raw.githubusercontent.com/mrtian2016/centos-script/master/initialize.sh | sudo bash /dev/stdin -l false -f false -s false```
