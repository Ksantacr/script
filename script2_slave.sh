#!/bin/bash

####Instalación (NODO ESCLAVO)
##

#Los nodos esclavos deben tener instalado Blender.
echo -e '\nInstalacion de Blender'
sudo apt-get install blender


read -p "IP del servidor : " ip

echo -e '\nDescargando paquete de instalacion'

#1. Descargar y el paquete de instalación para Ubuntu 14.04 LTS 64 bits.
wget https://ufpr.dl.sourceforge.net/project/cgru/2.2.1/cgru.2.2.1.ubuntu14.04.5_amd64.tar.gz

mkdir instalador_afanasy
#2. Descomprimir el archivo .tar.gz
tar -zxvf cgru.2.2.1.ubuntu14.04.5_amd64.tar.gz -C instalador_afanasy/


echo -e '\nAfanasy Render (nodo esclavo)'
#3. Ingresar a la carpeta que ha descomprimido.
cd instalador_afanasy/
#4. Instalar afanasy Render (esclavo): sudo ./install_afrender.sh
sudo ./install_afrender.sh

echo -e '\nInstalar CGRU'
#5. Instalar CGRU: sudo ./install_cgru.sh
sudo ./install_cgru.sh

#6. Iniciar CGRU - Afanasy Keeper desde las aplicaciones de Ubuntu.
#7. Una vez iniciado CGRU-Afanasy, se debe registrar la IP del servidor
### Configuracion
# Para hacer posible la renderización se deben registrar los paths del servidor en el archivo de configuración del render.

echo '{"cgru_config":{
"":"Created by CGRU Keeper at Wed Apr 27 14:08:14 2020",
	"af_servername":"'$ip'",
        "pathsmap":[
             ["/home/master/blender/","/home/master/Desktop/"]
        ],
"":""
}}' > $HOME/.cgru/config.json

gnome-terminal -e '/bin/bash /opt/cgru/start.sh'
gnome-terminal -e 'python3 /opt/cgru/utilities/keeper/keep'
