#!/bin/sh
if [ -f "/etc/smartdns/anti-ad-smartdns.conf" ];then
	rm -rf /etc/smartdns/anti-ad-smartdns.conf
        cd /etc/smartdns/
        wget https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf
        cd ~
        systemctl restart smartdns
else
        cd /etc/smartdns/
        wget https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf
        cd ~
       if [ -f "/etc/smartdns/anti-ad-smartdns.conf" ];then
	crontab -l > conf
	sed -i 's/conf-file /etc/smartdns/anti-ad-smartdns.conf//g' >> /etc/smartdns/smartdns.conf
	sed -i 's/00 02 * * * /bin/bash /root/ad.sh//g' >> conf && crontab conf
	echo -e "00 02 * * * /bin/bash /root/ad.sh" >> conf && crontab conf && rm -f conf
       /sbin/service cron reload
        echo -e "conf-file /etc/smartdns/anti-ad-smartdns.conf" >> /etc/smartdns/smartdns.conf
       systemctl restart smartdns
       cp /root/denta/ad.sh /root/
	else
		clear
		echo "脚本没有完成请重新运行"
		cd ~
	fi
fi

