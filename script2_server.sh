#!/bin/bash
###Instalación de Afanasy 2.2.1
##
read -p "IP del servidor : " ip

echo -e '\nDescargando paquete de instalacion'

wget https://ufpr.dl.sourceforge.net/project/cgru/2.2.1/cgru.2.2.1.ubuntu14.04.5_amd64.tar.gz


mkdir instalador_afanasy
tar -zxvf cgru.2.2.1.ubuntu14.04.5_amd64.tar.gz -C instalador_afanasy/


echo -e '\nInstalar afanasy Server'
cd instalador_afanasy/
sudo ./install_afserver.sh

echo -e '\nInstalar CGRU'
sudo ./install_cgru.sh

#Iniciar CGRU - Afanasy Keeper desde las aplicaciones de Ubuntu.

#/bin/bash /opt/cgru/start.sh
#python3 /opt/cgru/utilities/keeper/keep

echo '{"cgru_config":{
"":"Created by CGRU Keeper at Wed Jan 27 14:08:14 2018",
	"editor":"xterm -e nano \"%s\"",
	"af_servername":"'$ip'",
        "af_ip_trust":["*.*","127.0.0.1","192.168.*","*:*","0:0:0:0:0:0:0:1","FC00:*","FD00:*"],
"":""
}}' > $HOME/.cgru/config.json

###Configuracion
##

echo -e '\nCrear un archivo config.json en opt/cgru con la siguiente información'

sudo touch  /opt/cgru/config.json
echo -e '{"cgru_config":{
  "af_servername":"'$ip'",
  "":""
}}' | sudo tee /opt/cgru/config.json


#/bin/bash /opt/cgru/start.sh
#python3 /opt/cgru/utilities/keeper/keep

gnome-terminal -e '/bin/bash /opt/cgru/start.sh'
gnome-terminal -e 'python3 /opt/cgru/utilities/keeper/keep'
