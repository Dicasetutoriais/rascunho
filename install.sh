#!/bin/bash
pdtmod=https://github.com/Dicasetutoriais/rascunho
banner(){
cat <<FECHA
 
'####:'##::: ##::'######::'########::::'###::::'##:::::::'##:::::::
. ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##::::::: ##:::::::
: ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::: ##:::::::
: ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##::::::: ##:::::::
: ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: ##:::::::
: ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##:::::::
'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ########:
....::..::::..:::......::::::..:::::..:::::..::........::........::                                                                                                                   
                                                   BY @TURBONET2023

FECHA

}
escolha(){
  echo "ESCOLHA O QUE DESEJA FAZER: "
  read -p "  ▍" leitor
  [[ $leitor == 1 ]] && dtmod
  [[ $leitor == 0 ]] && cat /dev/null > ~/.bash_history && history -c && rm -rf install* > /dev/null 2>&1 && rm -rf wget-log* > /dev/null 2>&1 && clear && exit 0
  [[ $leitor == * ]] && main_menu  
  
}
main_menu(){ 
clear
banner
printf """
 ===============================
 | 1 ) PAINEL DTUNNEL MOD      | 
 ===============================
 | 0 ) SAIR                    |
 ===============================\n
 """
escolha
 }
dtmod(){
if [[ $(uname -m) == "aarch64" ]]; then
echo ""
echo -e "\n\033[1;31mSISTEMA (aarch64) INCOMPATÍVEL!\033[0m"
rm -rf install* > /dev/null 2>&1
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
sleep 3
exit 0
else
rm -rf install* > /dev/null 2>&1
wget $pdtmod/installorig.sh > /dev/null 2>&1 && chmod +x installorig.sh && ./installorig.sh
cat /dev/null > ~/.bash_history && history -c
rm -rf wget-log* > /dev/null 2>&1
sleep 3
exit 0
fi
} 
main_menu