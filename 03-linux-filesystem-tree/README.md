---
theme: default
background: /wallhaven-nmrl3k.jpg
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Enter Linux FHS
  Platica sobre el sistema de archivos de linux

drawings:
  persist: false
css: unocss
title: Enter Linux FHS
---

# Enter Linux HFS

Una introducion al sistema de archivos de Linux

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Bienvenidos <carbon:arrow-right class="inline"/>
  </span>
</div>

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---

# Que es FHS
**Filesystem Hierchy Standard** 


-  Se publicaron el **14 de Febrero de 1994**
-  La version mas actual es la **3.0** [Jun-1995]
-  Compatibilidad entre sistemas Unix-Like
-  Definicion de directorios principales y sus contenidos
-  No son son obligatorias pero recomendadas

<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/guide/syntax#embedded-styles
-->

<style>
h1 {
  background-color: #2B90B6;
  background-image: linear-gradient(45deg, #4EC5D4 10%, #146b8c 20%);
  background-size: 100%;
  -webkit-background-clip: text;
  -moz-background-clip: text;
  -webkit-text-fill-color: transparent;
  -moz-text-fill-color: transparent;
}
</style>

---

# FHS 101

Muchas distribuciones siguen el stadard parcialmente siguiendo los objetivos de la distribuciones.


|     |     |
| --- | --- |
| <kbd>/</kbd>| `filesystem` root  |
| <kbd>/home</kbd>| Directorio para usuarios |
| <kbd>/bin</kbd> <kbd>/sbin</kbd> |  Directorio para archivos ejecutables |
| <kbd>/usr</kbd> | Componentes no esenciales para el sistema operativo (cont..) |
| <kbd>/etc</kbd> | Archvos de configuracion globales |
| <kbd>/opt </kbd> | Directorio opcional, usualmente para applicaciones instaladas "manualmente" |
| <kbd>/lib</kbd> <kbd>/lib32</kbd> <kbd>/lib64</kbd> | Directorio para librerias |
| <kbd>/var</kbd> | Directorio para datos variables |
---

# FHS 101, pt2


|     |     |
| --- | --- |
| <kbd>/mnt </kbd> | Directorio para montar dispositivos de manera manual |
| <kbd>/boot </kbd> | Directorio donde se almacena todo lo relacionado a los archivos estaticos del kernel |
| <kbd>/sys </kbd> | Directorio que almacena informacion del Kernel|
| <kbd>/dev </kbd> | Directorio donde se almacenan archivos especiales que representan dispositivos de entrada y salida |
| <kbd>/proc </kbd> | Directorio donde se tiene la informacion de los procesos del sistema |
| <kbd>/run </kbd> | Directorio para almacenar informacion en tiempo de ejecucion |
| <kbd>/tmp </kbd> | Tierra de nadie :) |
| <kbd>/root </kbd> | Directorio exclusivo para el usuario root |


---
layout: image-right
image: wallhaven-nmrl3k.jpg
---

# / root filesystem

Donde todo empieza

```bash {2|2-9|9-18}
tree -d -L 1 /
/
├── /bin
├── /dev
├── /etc
├── /home
├── /lib
├── /mnt
├── /opt
├── /proc
├── /root
├── /run
├── /sbin
├── /sys
├── /tmp
├── /usr
└── /var
```
---

# ... Una pausa

## Todo es un archivo

Para mantener todo simple en todos los `Unix-Like` es un archivo

Lo que cambia es el tipo de archivo

- Directorios
- Archivos regulares
- Archivos de caracteres especiales 
- Archivos de tipo Pipe
- Archivos de tipo FIFO
- Archivos de tipo UNIX domain socket
- Archivos de pseudo terminal
- Archivo de tipo Nulo (Null)
- Archivo de tipo Zero
- Archivo de tipo Random
- Archivos File descriptor
- ...

---
layout: image-right
image: matrix.jpg
---

# /home

Tu pedacito de tierra en la matrix esta alojado aqui

- Directorio inicial de cualquier usuario
- En un entorno multiusuario solo el usuario propietario del directorio puede ver su contenido
- No son necesarios los permisos de root para ejcutar cualquier operacion aqui
- Esta pensado para almacenar archivos personales
- Aqui puedes tener tus `dotfiles`


---
highlighter: shiki
---

# ... Otra pausa :) 

## Hablemos brevemente de los archivos regulares
```bash {1|2|3}
.
..
.ash_history
bin
```

## Que pasa con los permisos?

```bash {1|2|3}
drwxr-sr-x    1 dfhs     dfhs            26 Nov 29 03:59 .
drwxr-xr-x    1 root     root            18 Nov 29 01:55 ..
-rw-------    1 dfhs     dfhs            11 Nov 29 03:59 .ash_history
```

## drwxr-sr-x WTH?

d = directorio

r = lectura (**r**ead)

s = SUID bit

w = escritura (**w**rite)

x = ejecucion (e**x**cution)

---
layout: image-left
image: matrix.jpg
---

# /bin and /sbin

## /bin
Aqui se almacenan binarios fundamentales para el sistema

## /sbin
Aqui tambien se guardan binarios fundamentales ... xD


---
layout: image-right
image: matrix.jpg
---

# /usr
**U**nix **S**ystem **R**esources, cualquier programa considerado no esencial para la funcionalidad basica del sistema

## Subdirectorios
|     |     |
| --- | --- |
| <kbd>/usr/bin</kbd> | Directorio standar para binarios |
| <kbd>/usr/sbin</kbd> | Directorio para binarios que necesitan permisos de root | 
| <kbd>/usr/local</kbd> | Estructura para binarios compilados localmente | 
| <kbd>/usr/{src,include}</kbd> | Archivos de codigo de kernel y headers | 
| <kbd>/usr/share</kbd> | Archivos que no estan atados a la arquitectura, iconos, documentacion ... | 

---
layout: image-left
image: matrix.jpg
---

# /etc
Configuraciones globales para el sistema

Si una aplicacion va a estar disponible para todos los usuarios del sistema, se recomienda la configuracion de esta aplicacion se almacene aqui

---
layout: image-left
image: matrix.jpg
---

# /opt

El directorio *opcional*

- Third-party applications
- Software instalado manualmente
- Etc..

---
layout: image-left
image: matrix.jpg
---

# /lib /lib32 /lib64

Directorio para las librerias.

- Binarios que son compartidos por aplicaciones ejecutables para tener cierta funcionalidad o acceso a recursos del sistema

---
layout: image-left
image: matrix.jpg
---

# /var

**var** es por que la data aqui es variable (es cambiante/dinamica)

- Archivos de log
- Procesamiento de archivos
- Cola de mensajes
- Se espera que el contenido del archivo se incremente

---

# /boot

- Kernel compilado
- Configuracion

---

# /sys

- Una interfaz con el kernel
- Un sistema de archivos virtual
- Desaparece al apagar el equipo
- Se usa para obtener informacion sobre el sistema y sus componentes

---

# /dev

almacena todos los archivos especiales para interactuar con el hardware


- archivos de tipo caracter
- archivos de tipo bloque

---

# /proc

Almacena toda la informacion relacionada a los procesos que se estan ejecutando en el sistema


- Esta conformado de pseudo-archivos con informacion acerca de los procesos y los recursos que esta utilizando

---
# /run

Es un directorio temporal usado para ejecutar procesos en `stages` iniciales del arranque, donde es muy probable que el sistema de archvos /var/run no esta disponible

---
# /tmp
En este directorio la aplicaciones almacenan informacion temporal para la sesion que se esta ejecutando

- Desaparece al apagar el sistema

---
# /root
El equivalente del home pero para el usuario root

---

# Una vision sobre como funciona el almacenamiento en disco


- Que es un directorio
- Que es un inodo
- Que es un (hard/soft) link 


---
# El fin?

Necesitas saber mas, algunos terminos que podrias "googlear"

- FHS
- procfs
- sysfs
- Linux File System/Structure Explained
- Demystifying Linux 101
- A source about file system reflection on the physical hard drive

---
