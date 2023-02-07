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

# Cambiar password local
passwd

# Cambiar password usuario
passwd hr1
passwd dev1



# Desactivar usuario
passwd -l 'username'

# Eliminar usuario
userdel -r 'username'


# configurar consola
usermod -s /bin/bash user2  

# Usuario puede cambiar consola
chsh -s /bin/sh  
```

## Grupos en linux

Types of Linux Groups

In Linux-based system, there are two types of groups, which are:

    Primary group
    Secondary or supplementary group

Primary group: When we create a file through a specific user account, by default, the filegroup is set to the user's primary group. It will provide the same name as the file user group as the user account name. The primary group stores the user information in /etc/passwd file.

Secondary or supplementary group: The main motive to create a secondary group

is to allow the specific permission to limited users. For example, if we want to add any user to the sudo group, the added user will inherit the sudo rights, and be able to run the sudo commands. If we add a user to the docker group, then it will inherit the properties of the docker group and be able to run the docker commands.

A user can be added to precisely one primary group. It is not necessary to add a user to a secondary group, so a user can be added to zero or more secondary groups.
```bash
# Listar grupos
groupmod "Press Tab key twice"
getent group  

# Agregar  usuario a grupo
usermod -a -G GROUPNAME USERNAME
usermod -a -G jtpGroup, JtpGroup2, JtpGroup3 user1  

# Quitar grupo
deluser USER GROUPNAME


# Cambi9ar nombre de grupo
groupmod -n <oldGroup> <newGroup>  
gpasswd -d user1 jtpGroup  

# Eliminar grupo
groupdel <group>  
```

## Revisar usuarios
```bash
man id

id
# uuid usuario
id -u user1  
# uuid del grupo
id -g javatpoint

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
mkdir -p /etc/hr
mkdir -p /etc/dev
```