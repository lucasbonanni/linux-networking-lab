

## Commands
[Intro to vbox-cli (scottlowe.org)](https://blog.scottlowe.org/2016/11/10/intro-to-vbox-cli/)
[vboxmanage-controlvm](https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-controlvm.html)
- VBoxManage startvm cafwfrontend --type headless
- VBoxManage controlvm cafwfrontend shutdown



> Debiean retbleed attack warning

#### To change the hostname
hostnamectl set-hostname server2

#### To ping machines
ansible all -m ping --ask-become-pass

ansible-playbook remotes.yml --ask-become-pass

#### My sql
mysql --user=user_name --password
mysql --user=aplicadauser --password

#### Download war file
curl https://github.com/sanchezih/up-computacionaplicada/raw/master/trabajo-practico/caserver02-assets/war-apps/agendasimpleca.war -o agendasimpleca.war

## cafwfrontend
### interfaces
enp0s3: bridge - ip 192.168.0.245/24
enp0s8: auto


## cafwbackend
### interfaces
enp0s3: 
enp0s8: auto
enp0s9: bridge - ip 192.168.0.246/24


## caserver02
### interfaces
enp0s3: 
enp0s8: bridge - ip 192.168.0.247/24

## caserver01
### interfaces
enp0s3: 
enp0s8: bridge - ip 192.168.0.248/24

For example, to add the manager-gui role to a user named tomcat with a password of s3cret, add the following to the config file listed above. 

## Links
[Debian - Network configuration](https://wiki.debian.org/es/NetworkConfiguration)

[Ansible - How to generate an encrypted pwd for the user module](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
pipx inject ansible passlib
ansible all -i localhost, -m debug -a "msg={{ 'mypassword' | password_hash('sha512', 'mysecretsalt') }}"


## Apache tomcat

If you're seeing this page via a web browser, it means you've setup Tomcat successfully. Congratulations!

This is the default Tomcat home page. It can be found on the local filesystem at: /var/lib/tomcat9/webapps/ROOT/index.html

Tomcat veterans might be pleased to learn that this system instance of Tomcat is installed with CATALINA_HOME in /usr/share/tomcat9 and CATALINA_BASE in /var/lib/tomcat9, following the rules from /usr/share/doc/tomcat9-common/RUNNING.txt.gz.


NOTE: For security reasons, using the manager webapp is restricted to users with role "manager-gui". The host-manager webapp is restricted to users with role "admin-gui". Users are defined in /etc/tomcat9/tomcat-users.xml.

Hay que copiar el war en /var/lib/tomcat9/webapps.

En /usr/share/tomcat9 hay que crear un script setenv.sh
con los siguientes valores.

export CA_MYSQL_SERVER_IP=127.0.0.1
export CA_MYSQL_SERVER_USERNAME=aplicadauser
export CA_MYSQL_SERVER_PASSWORD=Unapassword1234!
export CA_MYSQL_SERVER_PORT=3306

--- 
## Copy the ssh certificate.
ssh -i caadmin caadmin@192.168.0.248

usermod -aG sudo caadmin
usermod -aG sudo palermo

adduser username

[Apache tomcat9](https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-9-on-debian-10)


apachectl -t


dnsmasq
default


## Backup bash script
`*/5 * * * * /home/caadmin/backup-data1.sh`

Hola buenas noches, crea una imagen de una moto estilo chopera inspirada en dragones de occidente, roja con llamas, agresiva, confortable y con detalles dorados.

https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-es


http://192.168.0.247:8080/agendasimpleca/

java -version
