#!/bin/bash
echo -e '\nInstalamos el paquete para probar samba'

sudo apt-get install smbclient

read -p "IP del servidor : " ip

echo -e '\nList all shares:'

smbclient -L //$ip/compartido -U master

# connect:
#smbclient //$ip/compartido -U master

echo -e '\nCreamos una carpeta en el nodo esclavo para montar la partición compartida del servidor.'
mkdir /home/$USER/blender
cd /home/$USER/
sudo chmod 777 blender/ -R

#instalamos el paquete para compartir archivos
sudo apt-get install cifs-utils

#Opcion 2
echo -e '\nPara montar la carpeta compartida de manera permanente, editamos el archivo /etc/fstab (con privilegios de root) y agrega la siguiente línea:'
echo -e '\nsudo nano /etc/fstab'
#en la última línea del archivo fstab agregamos
#//servername/sharename  /media/windowsshare  cifs  username=master,password=master,iocharset=utf8,sec=ntlm  0  0

echo -e "//$ip/compartido /home/master/blender cifs username=master,password=master,iocharset=utf8,sec=ntlm 0 0" | sudo tee --append /etc/fstab
