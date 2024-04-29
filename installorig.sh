#!/bin/bash
clear
sitedwn=https://github.com/Dicasetutoriais/rascunho/blob/main/
IP=$(wget -qO- ipv4.icanhazip.com)
[[ $(crontab -l | grep -c "crondtunnel.sh") != '0' ]] && crontab -l | grep -v 'crondtunnel.sh' | crontab -
function os_system {
system=$(cat -n /etc/issue | grep 1 | cut -d ' ' -f6,7,8 | sed 's/1//' | sed 's/	  //')
distro=$(echo "$system" | awk '{print $1}')
case $distro in
Debian) vercion=$(echo $system | awk '{print $3}' | cut -d '.' -f1) ;;
Ubuntu) vercion=$(echo $system | awk '{print $2}' | cut -d '.' -f1,2) ;;
esac
}
function install_start {
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install unzip -y 
sudo apt-get install npm -y
npm install -g pm2 
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=21
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update -y
sudo apt-get upgrade -y
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt-get install nodejs -y
[[ ! -d /etc/paineldtunnel ]] && mkdir /etc/paineldtunnel
cd /etc/paineldtunnel || exit
wget $sitedwn/paineldtunnel.zip > /dev/null 2>&1
unzip -o paineldtunnel.zip > /dev/null 2>&1
rm paineldtunnel.zip > /dev/null 2>&1
cd || exit
chmod 777 -R /etc/paineldtunnel > /dev/null 2>&1
secret1=$(node -e "console.log(require('crypto').randomBytes(256).toString('base64'));")
secret2=$(node -e "console.log(require('crypto').randomBytes(256).toString('base64'));")
secret3=$(node -e "console.log(require('crypto').randomBytes(256).toString('base64'));")
sed -i "s;secret1;$secret1;g" /etc/paineldtunnel/.env > /dev/null 2>&1
sed -i "s;secret2;$secret2;g" /etc/paineldtunnel/.env > /dev/null 2>&1
sed -i "s;secret3;$secret3;g" /etc/paineldtunnel/.env > /dev/null 2>&1
[[ $(crontab -l | grep -c "crondtunnel.sh") = '0' ]] && (
crontab -l 2>/dev/null
echo "@reboot bash /etc/paineldtunnel/crondtunnel.sh"
) | crontab -
service cron restart
cd /etc/paineldtunnel || exit
npm install -g pm2
npm run prod
pm2 start
npm install
npm start npm --name "paineldtunnel" -- start --instances 10
npx prisma generate
npx prisma migrate deploy
bash /etc/paineldtunnel/crondtunnel.sh
reboot
cd || exit
clear
echo -e "\033[1;32mPAINEL INSTALADO COM SUCESSO!\033[0m"
echo ""
echo -e "\033[1;36m SEU PAINEL:\033[1;37m http://$IP\033[0m"
echo ""
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mao prompt! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
rm install* > /dev/null 2>&1
clear
reboot
}
os_system
[[ "$(whoami)" != "root" ]] && {
clear
echo -e "\n\033[1;33m[\033[1;31m ERRO\033[1;33m] \033[1;37m- \033[1;33mVOCÊ PRECISA EXECUTAR COMO ROOT! \033[0m"
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mao prompt! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
rm install* > /dev/null 2>&1
clear
}
if [[ "$distro" != "Ubuntu" ]]; then
clear
echo -e "\n\033[1;33m[\033[1;31m ERRO\033[1;33m] \033[1;37m- \033[1;33mSISTEMA NÃO COMPATIVEL! FAVOR INSTALAR O UBUNTU 20.04 OU 22.04! \033[0m"
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mao prompt! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
rm install* > /dev/null 2>&1
clear
else
if [[ "$vercion" == "20.04" ]]; then
install_start
elif [[ "$vercion" == "22.04" ]]; then
install_start
else
clear
echo -e "\n\033[1;33m[\033[1;31m ERRO\033[1;33m] \033[1;37m- \033[1;33mSISTEMA NÃO COMPATIVEL! FAVOR INSTALAR O UBUNTU 20.04 OU 22.04! \033[0m"
echo -ne "\n\033[1;31mENTER \033[1;33mpara retornar ao \033[1;32mao prompt! \033[0m"; read
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
rm install* > /dev/null 2>&1
clear
fi
fi 
