-bash: ./mysql_slave.sh: /bash/bin: 坏的解释器: 没有那个文件或目录
解决方法：
[root@redis_server ~]# sed -i 's/\r$//' mysql_slave.sh