1. HACER TODO COMO ROOT

2. CONFIGURAR SOURCES.LST CON LOS REPOS DE BULLSEYE

3. Instalar los siguientes paquetes:
apt-get install pxelinux syslinux dnsmasq

4. Configurar el archivo /etc/dnsmasq.conf

5. Crear el directorio para el servidor FTP
mkdir /var/lib/tftpboot

6. Copiar los siguientes archivos
cp /usr/lib/PXELINUX/pxelinux.0 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/menu.c32 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/libmenu.c32 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/libutil.c32 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/libcom32.c32 /var/lib/tftpboot
cp /usr/lib/syslinux/modules/bios/vesamenu.c32 /var/lib/tftpboot

7. Crear el directorio...
mkdir /var/lib/tftpboot/pxelinux.cfg

8. touch /var/lib/tftpboot/pxelinux.cfg/default

9. Crear el directorio para guardar los archivos del ISO de CentOS
mkdir /var/lib/tftpboot/data

10. mkdir /var/lib/tftpboot/data/CentOS-7-x86_64-Minimal-2009

11. Copiar el contenido del ISO
cp -fr /home/caadmin/Desktop/ISO/* /var/lib/tftpboot/data/CentOS-7-x86_64-Minimal-2009/

12. chmod -R 755 /var/lib/tftpboot/data

13. Instalar servidor NFS
apt-get install nfs-server

14. Configurar el archivo /etc/exports

15. Reiniciar el servicio NFS
systemctl restart nfs-server

16. Verificar el servicio
showmount -e 192.168.10.2