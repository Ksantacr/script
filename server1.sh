# Para montar la carpeta compartida de manera permanente, editamos el archivo /etc/fstab (con privilegios de root) y agrega la siguiente línea:
sudo nano /etc/fstab

#en la última línea del archivo fstab agregamos
//servername/sharename  /media/windowsshare  cifs  username=master,password=master,iocharset=utf8,sec=ntlm  0  0
#!/bin/bash
#Carpeta compartida entre servidor Afanasy y nodos esclavos

#Ruta del directorio a compartir (paso 3)
desktop_path=$(xdg-user-dir DESKTOP)

#sudo apt-get update

#Afanasy Server
echo -e '\n1. Instalar el protocolo de red "samba", creado para compartir una carpeta del Servidor con clientes de Windows o Linux.\n'

sudo apt-get install samba

echo -e '\n2. Configurar el usuario y la contraseña que será usado para el acceso a la carpeta.\n'
echo -e Usuario: $USER 
sudo smbpasswd -a $USER

echo -e '\n3. Crear el directorio que se va a compartir.\n'

mkdir $desktop_path/compartido

echo -e '\n4. Editar el archivo de configuración de samba. /etc/samba/smb.conf'
echo -e '5. Al final del archivo agregar las siguientes líneas\n'

echo -e "[compartido]\npath = /home/master/Desktop/compartido/\navailable = yes\nvalid users = master\nread only = no\nbrowsable = yes\npublic = yes\nwritable = yes" | sudo tee --append /etc/samba/smb.conf

echo -e '\n6. Guardar el archivo y cerrar el editor. Ahora, restaurar el servicio SMB, para que se produzcan los cambios.\n'
sudo service smbd restart
