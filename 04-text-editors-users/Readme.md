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

gedit is the official text editor of the GNOME desktop environment. While aiming at simplicity and ease of use, gedit is a powerful general purpose text editor. It can be used to create and edit all kinds of text files. Gedit features a flexible plugin system which can be used to dynamically add new advanced features to gedit itself. 

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

### Habilitar plugins
```bash
apt-get install gedit-plugins
```
### Plugins interesantes
- Translate: Traducir.
- Embbebed terminal: Terminal en gedit
- Find in files: Navegador de archivos
- Join/Split lines: Une y separa lineas.
- Word completion: Auto completa las palabras
- Text Size: Cambia el tamaño del texto
- Inster Date/Time: Inserta la hora y tiempo actual.
- Misspelled word: Subraya las palabras mal escritas.
- Color picker: Muestra una tabla de colores e inserta el codigo hexadecimal.
- Quick Highlight: Subraya todas las ocurrencias de la misma palabra.

# Crear entorno de trabajo
Descargar este repositorio y ejecutar los siguientes comandos bash:
```bash
# Cambiar de directorio
cd ./04-text-editors-users
# Construir imagen de contenedor
docker build -t session4 . 
# Ejecutar contenedor. (La primera vez lleva un poco de tiempo.)
docker run -it session4 bash
```

## Nano

**Man page:** https://linux.die.net/man/1/nano

```bash


```

## Emacs
Emacs is one of the oldest and most versatile text editors. The GNU Emacs version was originally written in 1984 and is well known for its powerful and rich editing features. It can be customized and extended with different modes, enabling it to be used like an Integrated Development Environment (IDE) for programming languages such as Java, C, and Python.

For those who have used both the Vi and the user-friendly nano text editors, Emacs presents itself as an in-between. Its strengths and features resemble those of Vi, while its menus, help files, and command-keys compare with nano.

```bash
apt-get install emacs
# 2, 63
# Ver mensaje de bienvenida
emacs
# Para moverse entre opciones presionar TAB.


# C-<chr>  means hold the CONTROL key while typing the character <chr>
#          Thus, C-f would be: hold the CONTROL key and type f.
# M-<chr>  means hold the META or EDIT or ALT key down while typing <chr>.
#          If there is no META, EDIT or ALT key, instead press and release the
#          ESC key and then type <chr>.  We write <ESC> for the ESC key.

# Cerrar C-x C-c
# C-v show next page
# M-v show previous page
# C-l center the text, C-l mueve el texto donde esta el cursor al medio


# Moverse en el texto
# Flechas.
# C-p linea anterior
# C-b caracter a la derecha
# c-f caracter a la isquierda
# c-n siguiente linea
# P for previous, N for next, B for backward and F for forward.  You


# Mover por palabres
# M-b palabra a la derecha
# M-f palabra a la izquierda

# Mover por lineas
# C-a inicio
# C-e end 

# Mover por oraciones (Hasta el siguiente punto)
# M-a   inicion
# M-e fin

# Mover al inicio y fin del archivo 
# M-< Inicio
# M-> Fin

# C-g cancelar combinaciones



<DEL> eliminar caracter antes del cursor
C-d eliminar siguiente caracter despues del cursor

M-<DEL> elimina la palabra antes del cursor
M-d elimina la palabra siguiente al cursor

C-k elimna desde el cursor hast el final de la linea
M-k eliminar el resto del parrafor.


ESC-ESC-ESC cancelar

CTRL+Space CTRL+W Delete highlight

CTRL / undo

CTRL x  CTRL s guardar cambios

CTRL x CTRL f cambiar buffer
CTRL x CTRL b listar buffers
# C-x 1 Eliminar otras ventanas, dejar solo 1.
C X derecha
C X izq
C z exit

C x 2 split window

C M <Command> Move the bottom window
C x o move the bottom window

# Search 
c s search  
    C s next occurrence
c r reverse search
    C r
```
CTRL
ALT
ESC

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


## VIM
VIM es un editor de texto que tiene multiple modos.
- Modo vista: En este modo es posible realizar acciones o atajos
- Modo  insertar: En este modo es cuando se puede escribir dentro del editor.
```bash
# Atajos
# Salir de VIM, sin guardar
ESC + :q!
# Salir de VIM, guardando cambios
ESC + :wq!

```





# Links
- https://phoenixnap.com/kb/linux-man 


# Manejo de usuarios

/etc/passwd

    User account information. 
/etc/shadow
    Secure user account information. 
/etc/group
    Group account information. 
/etc/gshadow
    Secure group account information. 
/etc/default/useradd
    Default values for account creation. 
/etc/skel/
    Directory containing default files. 
/etc/login.defs
    Shadow password suite configuration. 

**adduser: Man page:** https://linux.die.net/man/8/adduser
```bash
# 
adduser user1
adduser user2

# Cambiar password local
passwd

# Cambiar password usuario
passwd user2



# Desactivar usuario
passwd -l 'username'

# Eliminar usuario
userdel -r 'username'


# configurar consola
usermod -s /bin/bash user2  

# Usuario puede cambiar consola
chsh -s /bin/sh  



```

## Finger utility
```bash
apt-get install finger
finger user1
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
#   
```

## Dar permisos
| Command |	Description |
| --- | --- |
| file |	Determines file type. |
| touch |	Used to create a file. |
| rm |	To remove a file. |
| cp |	To copy a file. |
| mv |	To rename or to move a file. |
| rename |	To rename file. |

## Editar crudini