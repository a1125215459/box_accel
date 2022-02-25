#该接口判断文件是否存在
file_exist(){
a=`sr 'ls -a '$1''|wc -l`
if [ $a -ge 1 ]
then
echo "-------------->succ"
else
echo "-------------->failed"
fi
}

#该接口用于判断文件不存在
file_not_exist(){
a=`sr 'ls -a '$1''|wc -l`
if [ "$a" -eq 0  ]
then
echo "-------------->succ"
else
echo "-------------->failed"
fi
}

#该接口用于判断进程是否存在
proc_exist(){
j=0
for i in $*
do
b=`sr 'ps | grep '$i' | grep -Ev "grep"' | wc -l`
if [ $b -eq 1 ]
then
let j++
fi
done
if [ $j -eq $# ]
then
echo "-------------->succ"
else
echo "-------------->failed"
fi
}
#该接口用于杀掉进程
kill_proc(){
for i in $*
do
sr 'killall '$i''
if [ $? -eq 0 ]
then
echo "$i kill succ"
else
echo "$i still alive"
fi
done
}
#该接口用于设置版本号
set_version(){
for i in $*
do
sr 'echo '$1' > '$2' 2>/dev/null'
done
}
#该接口用于获取版本号
get_version(){
sr 'cat '$1''
}
#该接口用于盒子断电重启
reboot(){
sr 'reboot'
}
#该接口用于执行盒子xy脚本
xy(){
sr 'cd /jffs2;
sh xy '$1''
}