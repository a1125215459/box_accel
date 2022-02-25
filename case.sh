source func.sh
versionA="2.0.16"
versionB="2.0.3"
case-power_off_protect_file(){
	echo "检验power_off_protect"
	file_exist "/opt/gamebox/bin/power_off_protect.sh"
}

case-accelbox_init_file(){
	echo "检验accelbox_init.sh脚本"
	file_exist /opt/gamebox/bin/accelbox_init.sh
}

case-recover_file(){
	echo "检查/opt/gamebox/bin目录是否有脚本"
	file_exist "/opt/gamebox/bin/recover.sh"
}

case-update_file(){
	echo "检查包含update.sh"
	file_exist "/jffs2/accelbox/script/update.sh"
}

case-update_firmware_file(){
	echo "/jffs2/accelbox/script下包含update_firmware.sh（无-r选项）"
	file_exist "/jffs2/accelbox/script/update_firmware.sh"
}

case-nodes_file(){
	echo "校验本地保存的节点列表文件nodes.amsdb"
	file_exist "/jffs2/accelbox/ams/nodes.amsdb"
}

case-domain_file(){
	echo "校验本地默认保存的节点列表文件domain_list.amsdb"
	file_exist "/jffs2/accelbox/ams/domain_list.amsdb"
}

case-login_file(){
	echo "校验本地login.amsdb文件且内容完整"
	file_exist "/jffs2/accelbox/ams/login.amsdb"
}

case-auth_file(){
	echo "校验本地auth.amsdb文件存在且内容完整"
	file_exist "/jffs2/accelbox/ams/auth.amsdb"
}

case-udhcpd_leases_file(){
	echo "识别主机类型（查看缓存文件udhcpd.leases.exts）"
	file_exist "/var/lib/misc/udhcpd.leases.exts"
}

case-auto_push_file(){
    echo "校验auto_push.sh"
	file_exist "/jffs2/accelbox/script/auto_push.sh"
}

case-accelbox_tar_file(){
	echo "校验目录/opt/gamebox/中包含accelbox.tar.gz"
    file_exist "/opt/gamebox/accelbox.tar.gz"
}

case-porc_accel_guard_exist(){
	echo "通电之后检查 accel_guard进程"
	proc_exist "accel-guard"
}

case-proc_ams_agent_exist(){
	echo "查看agent/ams工作情况"
	proc_exist "ams" " agent-box"
}

case-accel_guard_normal_kill_ams(){
	echo "中断ams进程后（accel-guard正常）"
	kill_proc "ams"
	sleep 5
	proc_exist "/jffs2/accelbox/ams/ams"
}

case-accel_guard_normal_kill_agent-box(){
	echo "中断agent进程后（accel-guard正常）"
	kill_proc "agent-box"
	sleep 5
	proc_exist "/jffs2/accelbox/agent/agent-box"
}

case-update_poweroff_flag_exist(){
	echo "断电重启时-.update_poweroff_flag存在"
	sr 'touch /jffs2/.update_poweroff_flag;
    cp -r /jffs2/accelbox /jffs2/accelbox_bak'
	set_version "$versionB" "/jffs2/accelbox_bak/version"
    reboot
    sleep 300
    a=`get_version "/jffs2/accelbox/version"`
    if [ $a = $versionB ];then
	echo "-------------->succ"	
	else
    echo "-------------->failed"
	fi
}
case-update_poweroff_flag_nexist(){
	set_version "$versionA" "/jffs2/accelbox/version"
	echo "断电重启时-.update_poweroff_flag不存在"
	sr 'cp -r /jffs2/accelbox /jffs2/accelbox_bak'
	set_version "$versionB" "/jffs2/accelbox_bak/version"
	reboot
	sleep 300
	a=`get_version "/jffs2/accelbox/version"`
	if [ $a = $versionA ];then
	echo "-------------->succ"	
	else
    echo "-------------->failed"
	fi
}
case-del_update_poweroff_flag(){
	echo ".update_poweroff_flag-断电重启后被删除"
	sr 'touch /jffs2/.update_poweroff_flag'
	reboot
	sleep 300
	file_not_exist /jffs2/.update_poweroff_flag
	
}
