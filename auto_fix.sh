#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

clean_bt() {
    sed -i "/bt.cn/d" /etc/hosts
}

in_bt() {
    echo "$1 www.bt.cn api.bt.cn download.bt.cn dg1.bt.cn dg2.bt.cn" >>/etc/hosts
}

no_btcheck() {
    path_1="/www/server/panel/data"
    path_2="/www/server/panel/install"
    echo -e "\e[1;31m===================================================================\e[0m"
    for FILE in ${path_1}/userInfo.json ${path_1}/plugin_bin.pl ${path_1}/auth_list.json ${path_2}/public.sh ${path_2}/check.sh; do
        lsattr ${FILE}
    done
    get_bt=$(grep "bt.cn" /www/server/panel/pyenv/lib/python3.7/urllib/request.py)
    if [ "${get_bt}" ]; then
        echo "request.py result:"
        echo "==================================================================="
        grep "bt.cn" -C 3 /www/server/panel/pyenv/lib/python3.7/urllib/request.py
        echo "==================================================================="
    fi

    echo "节点连接状态:"
    curl -s -m 5 -w "www.bt.cn %{http_code} %{remote_ip}\n" https://www.bt.cn -o cwww.bt.cn.txt
    curl -s -m 5 -w "api.bt.cn %{http_code} %{remote_ip}\n" https://api.bt.cn -o capi.bt.cn.txt
    curl -s -m 5 -w "download.bt.cn %{http_code} %{remote_ip}\n" http://download.bt.cnn -o cdownload.bt.cn.txt
    curl -s -m 5 -w "dg1.bt.cn %{http_code} %{remote_ip}\n" http://dg1.bt.cn -o cdg1.bt.cn.txt
    curl -s -m 5 -w "dg2.bt.cn %{http_code} %{remote_ip}\n" http://dg2.bt.cn -o cdg2.bt.cn.txt
    
    rm -f *.bt.cn.txt
    echo -e "\n系统DNS设置:"
    cat /etc/resolv.conf
}

_info(){
    sleep 1
    echo -e "\n\e[1;31m#####修复完成,请登录面板查看是否正常#####\e[0m\n"
}

_fix_node(){
    host_ip=(128.1.164.196 116.213.43.206 125.90.93.52 36.133.1.8 116.10.184.219)
    tmp_file1=/dev/shm/net_test1.pl
    [ -f "${tmp_file1}" ] && rm -f ${tmp_file1}
	touch $tmp_file1
    ser_name="api.bt.cn"

    for host in ${host_ip[@]};
	do
		NODE_CHECK=$(curl --resolv ${ser_name}:443:${host} --connect-timeout 3 -m 3 2>/dev/null -w "%{http_code} %{time_total}" https://${ser_name} -o c${ser_name}.txt|xargs)
		rm -rf c${ser_name}.txt
		NODE_STATUS=$(echo ${NODE_CHECK}|awk '{print $1}')
		TIME_TOTAL=$(echo ${NODE_CHECK}|awk '{print $2 * 1000 - 500 }'|cut -d '.' -f 1)
		if [ "${NODE_STATUS}" == "200" ];then
			if [ $TIME_TOTAL -lt 100 ];then
				echo "$host" >> $tmp_file1
			fi
		fi
	done
    NODE_URL=$(cat $tmp_file1|sort -r -g -t " " -k 1|head -n 1|awk '{print $1}')

	rm -f $tmp_file1
    clean_bt
    echo "$NODE_URL www.bt.cn api.bt.cn download.bt.cn dg2.bt.cn dg1.bt.cn" >> /etc/hosts
}

echo "正在自动清理/etc/hosts旧宝塔节点..."
sleep 0.5
echo "自动修复节点中..."
_fix_node
echo "开始测试节点...请勿中断程序..."

bt_check_01=$(curl -s -m 5 -w "%{http_code}\n" https://www.bt.cn -o cwww.bt.cn.txt)
bt_check_02=$(curl -s -m 5 -w "%{http_code}\n" https://api.bt.cn -o capi.bt.cn.txt)
bt_check_03=$(curl -s -m 5 -w "%{http_code}\n" http://download.bt.cn -o cdownload.bt.cn.txt)
bt_check_04=$(curl -s -m 5 -w "%{http_code}\n" http://dg1.bt.cn -o cdg1.bt.cn.txt)
bt_check_05=$(curl -s -m 5 -w "%{http_code}\n" http://dg2.bt.cn -o cdg2.bt.cn.txt)

if [ "${bt_check_01}" != 200 ] || [ "${bt_check_02}" != 200 ] || [ "${bt_check_03}" != 200 ] || [ "${bt_check_04}" != 200 ] || [ "${bt_check_05}" != 200 ]; then
    rm -f *.bt.cn.txt
    while :
    do
        echo "==================================================================="
        echo -e "\e[1;31m您的服务器无法连接宝塔官网或某个节点,请尝试根据下面的选项手动修复!\e[0m"
        echo -e "\n如果您不清楚自己的服务器是哪个地区或网络,请输入数字3或6尝试修复!"
        echo "==================================================================="
        echo "1) 欧美等地境外服务器     2) 亚洲等地境外服务器"
        echo "3) 中国香港/台湾服务器    4) 国内移动网络服务器"
        echo "5) 国内联通网络服务器     6) 国内其他网络服务器"
        echo "7) 以上选项均无法解决     8) 退出或按组合键[ctrl+c]"
        echo "==================================================================="
        echo "修复后请登录面板查看是否正常,如果仍然不行请尝试其他选项"
        read -p "请输入对应数字尝试自动修复[1-8]:" input
        case ${input} in
        [1]*)
            clean_bt
            in_bt "128.1.164.196"
            _info
            ;;
        [2]*)
            clean_bt
            in_bt "116.213.43.206"
            _info
            ;;
        [3]*)
            clean_bt
            in_bt "125.90.93.52"
            _info
            ;;
        [4]*)
            clean_bt
            in_bt "36.133.1.8"
            _info
            ;;
        [5]*)
            clean_bt
            in_bt "116.213.43.206"
            _info
            ;;
        [6]*)
            clean_bt
            in_bt "125.90.93.52"
            _info
            ;;
        [7]*)
            clean_bt
            no_btcheck
            echo -e "\n\e[1;31m请将上方红线至此段话显示的所有内容,截图完整上传宝塔论坛或发送给宝塔运维\e[0m\n"
            break
            ;;
        [8]*)
            break
            ;;
        *)
            echo -e "\n\e[1;31m输入有误,请重新选择正确的选项!\e[0m\n"
            ;;
        esac
    done
else
    rm -f *.bt.cn.txt
    echo -e "\n节点连接测试正常,如果面板仍然无法使用,请截图此段文字并联系宝塔运维\n"
fi
