# Sesion 5: Manejo de usuarios
# Crear entorno de trabajo
Descargar este repositorio y ejecutar los siguientes comandos bash:
```bash
# Cambiar de directorio
cd 05-user-management/
# Construir imagen de contenedor
docker build -t session5 . 
# Detener y eliminar contenedor
docker stop session5
docker rm session5
# Ejecutar contenedor. 
docker run --name session5 -it session5 bash
```
## Revisar usuarios
```bash
man id

id
```

## Crear usuarios
```bash
adduser sysadmin1
adduser --disabled-password --gecos "" sysadmin2
adduser --disabled-password --gecos "" engineer1
adduser --disabled-password --gecos "" designer1

# uuid usuario
id -u sysadmin1  
id -u engineer1  
id -u designer1  

# Cambiar password local
passwd

# Cambiar password usuario
passwd engineer1
passwd designer1

cat /etc/passwd

adduser --disabled-password --gecos "" example
cat /etc/passwd
# Desactivar usuario
passwd -l example

# Eliminar usuario
userdel -r example


# configurar consola
usermod -s /bin/sh sysadmin1  
usermod -s /bin/sh engineer1  
usermod -s /bin/bash designer1  

# Revisar consola
su sysadmin1
su engineer1
su designer1

# Usuario puede cambiar consola
chsh -s /bin/sh  
```

## Agregar usuario manualmente a sudoers
```bash
# Caso 1
adduser --disabled-password --gecos "" noroot
echo "noroot  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/noroot
# rm /etc/sudoers.d/example

su noroot

su sysadmin1
```

## Grupos en linux

En linux existen dos tipos de grupos:
- `Grupos primarios`: Cuando creamos un archivo utilizando un usuario en especifico, por defecto el grupo del archivo es seteado al grupo primario del usuario. El grupo primario normalmente tiene el mismo nombre de la cuenta de usuario. La informacion del usuario es almacenada en el archivo  `/etc/passwd`.
- `Grupos secundarios`: El objetivo principal de crear los grupos secundarios es darle permisos especificos a un conjunto de usuarios. Por ejemplo si queremos que cualquier usuario tenga permisos sudo entonces lo agregamos al grupo sudo. Mientras por ejemplo si queremos que pueda ejecutar docker lo agregamos al grupo de docker. 
Un usuario puede ser asignado solamente a un grupo primario. Pero puede ser asignado desde 0 a hasta 15 grupos secundarios.

```bash
groupadd sysadmin
groupadd engineers
groupadd designers


# uuid del grupo
id -g sysadmin1

cat /etc/group

# Eliminar grupo
groupadd test
groupdel test

# Listar grupos
getent group  
getent group "sysadmin"

# Agregar  usuario a grupo
adduser sysadmin1 sysadmin
adduser sysadmin2 sysadmin
adduser engineer1 engineers
adduser designer1 designers


# Quitar grupo
# deluser USER GROUPNAME
deluser sysadmin1 sysadmin

cat /etc/group
cat /etc/passwd
```

## Permisos
**Comandos para trabajar con archivos**
| Command |	Description |
| --- | --- |
| file |	Determines file type. |
| touch |	Used to create a file. |
| rm |	To remove a file. |
| cp |	To copy a file. |
| mv |	To rename or to move a file. |
| rename |	To rename file. |

```bash
# Crear directorio para sysadmin
mkdir -p /tmp/sysadmin
mkdir -p /tmp/engineers
mkdir -p /tmp/designers

# Crear archivos ejecutables
## Para sysadmin
cat << EOF > /tmp/sysadmin/script_sysadmin1.sh
#!/bin/sh
echo "Ejecutando script sysadmin1"
EOF
cat << EOF > /tmp/sysadmin/script_sysadmin2.sh
#!/bin/sh
echo "Ejecutando script sysadmin2"
EOF

## Para ingenieros
cat << EOF > /tmp/engineers/script_engineers.sh
#!/bin/sh
echo "Ejecutando script engineers"
EOF

## Para diseñadores
cat << EOF > /tmp/designers/designers.txt
Este es un archivo para designers
EOF
```
### Ejemplo1
```bash
ls -al /tmp/sysadmin

# Asignar usuario y grupo para sysadmin
chown sysadmin1 /tmp/sysadmin/script_sysadmin1.sh
chown sysadmin2 /tmp/sysadmin/script_sysadmin2.sh
chgrp sysadmin -R /tmp/sysadmin
chmod 740 -R  /tmp/sysadmin
ls -al /tmp/sysadmin

# Permisos 740
# 7 todos los permisos para el owner
# 4 El grupo puede leer
# 0 Otros no lo puede acceder

# Pruebas

# su engineer1
# sh /tmp/sysadmin/script_sysadmin1.sh (FAIL)
# echo "#test" >> /tmp/sysadmin/script_sysadmin1.sh (FAIL)
# cat /tmp/sysadmin/script_sysadmin1.sh (FAIL)
# exit

# su sysadmin1
# source /tmp/sysadmin/script_sysadmin1.sh (pass)
# echo "#test" >> /tmp/sysadmin/script_sysadmin1.sh (pass)
# cat /tmp/sysadmin/script_sysadmin1.sh (pass)

# source /tmp/sysadmin/script_sysadmin2.sh  (FAIL)
# echo "#test" >> /tmp/sysadmin/script_sysadmin2.sh (FAIL)
# cat /tmp/sysadmin/script_sysadmin2.sh (pass)

```
### Ejemplo 2
```bash
ls -al /tmp/engineers
# Asignar usuario y grupo para engineers
chown engineer1:engineers -R /tmp/engineers

# Archivo script 1 solo puede ser leido por el dev1
chmod 745 -R  /tmp/engineers
ls -al /tmp/engineers

# Permisos 744
# 7 todos los permisos para el owner
# 4 El grupo puede leer
# 4 Otros pueden leer


# Pruebas

# su engineer1
# sh /tmp/engineers/script_engineers.sh (pass)
# echo "#test" >> /tmp/engineers/script_engineers.sh (pass)
# cat /tmp/engineers/script_engineers.sh (pass)
# exit

ls -al /tmp/engineers
# su designer1
# echo "test" >> /tmp/engineers/script_engineers.sh (FAIL)
# cat /tmp/engineers/script_engineers.sh (pass)
# exit
```

