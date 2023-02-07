# Indice
- Que es man?
- Editores de texto en linux
- Manejo de usuarios y grupos en linux

# Que es man?
Este comando se utiliza para obtener el manual de referencia de un comando o herramienta para correr en la línea de comandos. 

```bash 
# Informacion del comando
man [option] [section number] [command name]

# Dentro del contenedor ejecutar la siguiente instruccion
man man
# Aqui estamos viendo la pagina del manual de la pagina del manual.

man -f grep

# Mostrar todas las opciones
man -a grep

# Buscar por expresion regular
man -k grep

# Obtener la direccion de los manuales
man -wa  grep
```

# Editores de texto

## Gedit

**Man page:** https://linux.die.net/man/1/gedit

Gedit es el editor de texto oficial de los entornos de escritorio GNOME.  Si bien tiene como objetivo la simplicidad y la facilidad de uso, gedit es un poderoso editor de texto de propósito general. Se puede utilizar para crear y editar todo tipo de archivos de texto. Gedit presenta un sistema de complementos flexible que se puede usar para agregar dinámicamente nuevas funciones avanzadas a gedit.

```bash
# Iniciar gedit
gedit test

# Iniciar gedit, nueva ventana
gedit --new-window

# Iniciar gedit, nueva pestaña en la misma ventana.
gedit --new-document

# Abrir el archivo e ir a una linea en especifico.
#       gedit file_name +n
gedit example1.txt +265

# Abrir multiples archivos
gedit example1.txt example2.txt
```

**Habilitar plugins**
```bash
apt-get install gedit-plugins
```

**Plugins interesantes**
- Translate: Traducir de ingles a español.
- Embbebed terminal: Terminal en gedit
- Find in files: Navegador de archivos
- Join/Split lines: Une y separa lineas.
- Word completion: Auto completa las palabras
- Text Size: Cambia el tamaño del texto
- Inster Date/Time: Inserta la hora y tiempo actual.
- Misspelled word: Subraya las palabras mal escritas.
- Color picker: Muestra una tabla de colores e inserta el codigo hexadecimal.
- Quick Highlight: Subraya todas las ocurrencias de la misma palabra.

## Crear entorno de trabajo
Descargar este repositorio y ejecutar los siguientes comandos bash:
```bash
# Cambiar de directorio
cd ./04-text-editors-users
# Construir imagen de contenedor
docker build -t session4 . 
# Detener y eliminar contenedor
docker stop session4
docker rm session4
# Ejecutar contenedor. 
docker run --name session4 -it session4 bash
```

## Nano

**Man page:** https://linux.die.net/man/1/nano

```bash
apt-get install -y nano
nano
# CTRL + x  (Exit nano)
nano example1.txt

# CTRL = ^
# M = ALT

#^G     (F1)      Manual de nano
#^X     (F2)      Salir de nano
#^O     (F3)      Guardar camobios en disco
#^R     (Ins)     Insertar contenido de otro archivo al archivo actual
#^W     (F6)      Buscar una palabra en especifico
#^\     (M-R)     Reemplazar una cadena
#^K     (F9)      Cortar actual linea de texto
#^U     (F10)     Pegar todas las lineas de texto cortadas.
#^J     (F4)      Justificar bloque de texto
#^C     (F11)     Mostrar la informacion del cursor.
#^_     (M-G)     Ir a una linea y columan en especifico (fila, columna)
#M-U              Deshacer la ultima operacion
#M-E              Rehacer la ultima operacion de deshacer
#M-A    (^6)      Comenzar seleccion de texto
#M-6    (M-^)     Copiar linea actual (o region seleccionada) y se almacena en el clipboard.
#^Q               Buscar palabra de retroceso
#M-Q              Buscar siguiente ocurrencia hacia atras.
#M-W              Buscar siguiente ocurrencia hacia adelante
#^A     (Home)    Ir al inicio de la linea
#^E     (End)     Ir al final de la linea.
#^P     (Up)      Ir a la linea anterior
#^N     (Down)    Ir a la siguiente linea
#^Left  (M-Space) Regresar una palabra
#^Right (^Space)  Avanzar una palabra
#^Up    (M-7)     Ir al bloque de texto anterior
#^Down  (M-8)     Ir al siguiente bloque de texto
#M-3              Comentar/Descomentar la linea actual
#M-Del            Eliminar linea actual
#^S               Guardar cambios, sin confirmacion
#M-N              Habilitar/deshabilitar numeracion.
```

## Emacs
Emacs es uno de los editores de texto más antiguos y versátiles. La versión de GNU Emacs se escribió originalmente en 1984 y es bien conocida por sus potentes y ricas funciones de edición. Se puede personalizar y ampliar con diferentes modos, lo que permite utilizarlo como un entorno de desarrollo integrado (IDE) para lenguajes de programación como Java, C y Python.
Para aquellos que han usado tanto Vi como los editores de texto nano fáciles de usar, Emacs se presenta como un intermedio. Sus fortalezas y características se asemejan a las de Vi, mientras que sus menús, archivos de ayuda y teclas de comando se comparan con las de nano.

- Menu
    - Entrar al menu F10
    - Salir del menu 3 esc
    - Herramientas
        Calendar
        Simple calculator
        Programmable calculator
        Searching a directory
        Encrypting and decrypting document
        Send and read e-mails
        Search files using grep
        Spell checking
        Running shell commands and compiling code
        Version control
        Compare and merge files
        Games
- Main buffer
- status bar/mode line
- Mini buffer

```bash
apt-get install emacs

# Ver mensaje de bienvenida
emacs

# Para moverse entre opciones presionar TAB.
# CTRL = C
# M = ALT

# C-<chr>  means hold the CONTROL key while typing the character <chr>
# M-<chr>  means hold the META or EDIT or ALT key down while typing <chr>.


# C-x C-c               Cerrar emacs
# C-v                   Mostrar siguiente pagina
# M-v                   Mostrar pagina anterior
# C-l                   Centrar cursor.
# C-p                   Moverse a la linea anterior
# C-b                   Moverse a la derecha 
# C-f                   Moverse a la izquierda 
# C-n                   Moverse a la siguiente linea
# M-b                   Moverse a la siguiente palabra
# M-f                   Moverse a la palabra anterior.
# C-a                   Moverse al inicio de la linea
# C-e                   Moverse al final de la linea.
# M-a                   Moverse al inicio del parrafo
# M-e                   Moverse al final del parrafo
# M-<                   Moverse al inicio del archivo
# M->                   Moverse al final del archivo
# C-g                   Cancelar combinaciones
# C-x   u               Rehace cambio
# C-/                   Deshacer cambio
# <DEL>                 Eliminar caracter antes del cursor
# C-d                   Eliminar siguiente caracter despues del cursor
# M-<DEL>               Elimina la palabra antes del cursor
# M-d                   Elimina la palabra siguiente al cursor
# C-k                   Elimna desde el cursor hast el final de la linea
# M-k                   Eliminar el resto del parrafor.
# ESC-ESC-ESC cancelar
# C+Space C+W           Eliminar seleccion
# C-x  C-s              Guardar cambios
# C-x C-f               Cambiar buffer
# C-x C-b               Listar buffers
# C-x 1                 Eliminar otras ventanas, dejar solo 1.
# C-X derecha           Cambiar de buffer
# C-X izq               Cambiar de buffer
# C-z                   Exit
# C-x 2                 Dividir ventana
# C-x o                 Cambiar a la ventana de abajo

# C-M <Command>         Cambiar la ventana de abajo

# Search 
# C-s                   Buscar  hacia adelante
#    C-s                Buscar siguiente ocurrencia
# C-r                   Buscar  hacia atras
#    C-r                Buscar ocurrencia previa
```



## VIM
VIM es un editor de texto que tiene multiple modos.
- Modo vista: En este modo es posible realizar acciones o atajos
- Modo  insertar: En este modo es cuando se puede escribir dentro del editor.
```bash
apt-get install vim

# Regresar a modo vista
# ESC

# Ir a modo insertar
# i

# Moverse en modo vista
# h izq
# j abajo
# k arriba
# l derecha


# Moverse una palabra a la vez
# w         Al inicio de la siguiente palabra
# b         Al inicio de la palabra anterior
# e         Al final de la siguiente palabra
# ge        Al final de la palabra anterior

# x         Eliminar caracter
# x+n       Eliminar n caracteres

# 0         Moverse al inicio de la linea
# $         Moverse al final de la linea
# :n        Ir a una linea en especifico

# o         Add new line
# D         Elimina todo hasta el final de linea
# dw        Elimina la palabra donde esta el cursor
# 3dw       Elimina tres palabras
# dd        Elimina la linea actual

# gg        Moverse al inicio del archivo
# G         Moverse al final del archivo

# yy        Copiar linea actual
# p         Pegar linea actual
# 3p        Pegar 3 veces

# /yourtext Buscar texto
#       n   Mover hacia adelante
#       N   Mover hacia atras

# :w        Guardar cambios
# :q        Cerrar vim

# r         Reemplazar caracter actual
# R         Reemplazar desde el caracter actual.

# J         Unir multiples lineas

# A         Comenzar a escribir desde el final de la linea

# C-f       Scroll down la pagina entera
# C-b       Scroll up la pagina entera

# Swap area is a file created by Vim to store buffer contents periodically. While editing file our changes may be lost because of any 
#   reasons and Vim provides swap files to provide data recovery.
# :Swapname

# u                 Deshacer
# Ctrl+r o :red     Rehacer


# Atajos
# Salir de VIM, sin guardar
ESC + :q!
# Salir de VIM, guardando cambios
ESC + :wq!

```

# Manejo de usuarios

**Archivos importantes**
- `/etc/passwd`:    User account information. 
- `/etc/group` :    Group account information. 

**adduser: Man page:** https://linux.die.net/man/8/adduser
```bash
# 
adduser hr1
adduser --disabled-password --gecos "" dev1
adduser --disabled-password --gecos "" hr2
adduser --disabled-password --gecos "" dev2
adduser --disabled-password --gecos "" dev3
adduser --disabled-password --gecos "" admin1
adduser --disabled-password --gecos "" admin2

# Cambiar password local
passwd

# Cambiar password usuario
passwd hr1
passwd dev1
passwd hr2
passwd dev2
passwd dev3


# Desactivar usuario
passwd -l hr2

# Eliminar usuario
userdel -r dev3


# configurar consola
usermod -s /bin/sh dev3  

# Usuario puede cambiar consola
chsh -s /bin/sh  
```

## Grupos en linux

En linux existen dos tipos de grupos:
- `Grupos primarios`: Cuando creamos un archivo utilizando un usuario en especifico, por defecto el grupo del archivo es seteado al grupo primario del usuario. El grupo primario normalmente tiene el mismo nombre de la cuenta de usuario. La informacion del usuario es almacenada en el archivo  `/etc/passwd`.
- `Grupos secundarios`: El objetivo principal de crear los grupos secundarios es darle permisos especificos a un conjunto de usuarios. Por ejemplo si queremos que cualquier usuario tenga permisos sudo entonces lo agregamos al grupo sudo. Mientras por ejemplo si queremos que pueda ejecutar docker lo agregamos al grupo de docker. 
Un usuario puede ser asignado solamente a un grupo primario. Pero puede ser asignado desde 0 a hasta 15 grupos secundarios.

```bash
groupadd hr
groupadd dev
groupadd admin
groupadd test


# Eliminar grupo
groupdel test

# Listar grupos
getent group  
getent group "dev"

# Agregar  usuario a grupo
adduser dev1 dev
adduser dev2 dev
usermod -aG sudo dev2

# Quitar grupo
# deluser USER GROUPNAME
deluser admin2 admin
```

## Revisar usuarios
```bash
man id

id
# uuid usuario
id -u dev1  
# uuid del grupo
id -g dev1

```

## Dar permisos
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
# Crear directorio para dev
mkdir -p /tmp/dev
# Cambiar permisos del directorio
chgrp dev /tmp/dev -R
# Ver permisos de la carpeta
ls -al /tmp/dev

# Crear archivos ejecutables
cat << EOF > /tmp/dev/script_dev1.sh
echo "hello world"
EOF
cat << EOF > /tmp/dev/script_dev2.sh
echo "goodbye world"
EOF
# Ver permisos de la carpeta
ls -al /tmp/dev

# Asignar usuario y grupo
chown dev1 /tmp/dev/script_dev1.sh
chgrp dev /tmp/dev/script_dev1.sh
chmod 700  /tmp/dev/script_dev1.sh
# Archivo script 1 solo puede ser leido por el dev1
chmod 740  /tmp/dev/script_dev1.sh


# Asignar usuario y grupo
chown dev2:dev /tmp/dev/script_dev2.sh
chmod 765  /tmp/dev/script_dev2.sh
```

## Agregar usuario manualmente a sudoers
```bash
username ALL=(ALL) NOPASSWD:/bin/mkdir,/bin/rmdir
```