bug：初始化mysql返回结果无法写入到init_mysql文件中  
mysql初始化后会生成一个临时密码，第一次进去mysql需要用到   
如果运行脚本报以下错误
-bash: ./mysql_slave.sh: /bash/bin: 坏的解释器: 没有那个文件或目录  
解决方法  
[root@redis_server ~]# sed -i 's/\r$//' mysql.sh
