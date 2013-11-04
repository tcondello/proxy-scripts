#!/bin/bash
# Extract proxies from samair.ru


echo "[+] Extracting proxy List, be patient"
echo "[-] Downloads a list of proxies and stores them in proxys.conf ip:port"
sleep 2

if [ -f proxys.conf ]; then
echo "[+] Previous proxys.conf detected....deleting"
rm proxys.conf
fi

if [ -f proxys*.tm ]; then
echo "[+] Previous proxys.tm detected....deleting"
rm proxys.tm
fi

for i in `seq -w 02 10` ; do 
echo "[+] Parsing : *samair.ru* : Proxy page : ${i} done"

phantomjs jsget.js http://samair.ru/proxy/proxy-${i}.htm > proxys${i}.tm ; done

echo "[+] Extracting IP'S and PORTS"

perl -ne 'while(/((\d{1,3}\.){3,3}\d{1,3}).*?<\/script>(:\d{2,4})/g){print $1, $3, "\n";}' *.tm | sort -u >> proxys.conf
rm *.tm

proxys=`wc -l proxys.conf | cut -d " " -f 6`

echo "[+] Done, We've $proxys proxies"

