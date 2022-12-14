# POSIX shell 102

Si vienes de [POSIX Shell 101](../01-POSIX-shell-101) o tienes experiencia
previa con las POSIX Shell (ej: bash ó zsh), ya habrás notado que estas
interfaces de texto no son tan complicadas. Por eso, ahora estas listo para
aprender de otras abstracciones que estas herramientas nos proveen.

**NOTA**: Los ejercicios que encuentras acá harán uso de varias
[GNU core utilities](https://www.gnu.org/software/coreutils/), además de los
built-in shell commands.

- [The POSIX world 🪐](#the-posix-world-)
  - [The Greeter](#the-greeter)
  - [Sustitución o expansión de variables](#sustitución-o-expansión-de-variables)
  - [Variables especiales expandidas por la shell](#variables-especiales-expandidas-por-la-shell)
  - [Variables de ambiente](#variables-de-ambiente)
  - [Exportar variables](#exportar-variables)
  - [Manejo de flujos de datos](#manejo-de-flujos-de-datos)
    - [Heredocs](#heredocs)
    - [Leer archivos línea a línea](#leer-archivos-línea-a-línea)
  - [Sustitución de shell y sub-shell](#sustitución-de-shell-y-sub-shell)
    - [El comando eval](#el-comando-eval)
  - [Flujo de ejecución](#flujo-de-ejecución)
  - [Manejo de señales](#manejo-de-señales)
  - [Utilidades](#utilidades)
  - [Scripts, funciones y parametros](#scripts-funciones-y-parametros)
    - [Argumentos posicionales](#argumentos-posicionales)
    - [Otros ejemplos](#otros-ejemplos)
- [Recursos externos para seguir aprendiendo](#recursos-externos-para-seguir-aprendiendo)

## The POSIX world 🪐

### The Greeter

Comencemos con como capturar un solo input (delimitado por `\n`)

```sh
FOO=''
echo $FOO

read -p 'Saludar a: ' FOO
echo "Hola ${FOO}"
```

### Sustitución o expansión de variables

Las POSIX shells pueden hacer multiples operaciones sobre los valores que una
variable tiene asignada.

```sh
unset UNSET_VAR
FOO='Hola mundo'

# Valores fallback o checks
echo "${UNSET_VAR-Valor defecto}"
echo "${FOO+Sobre escrito cuando no está vacío}"

BAR="${UNSET_VAR-Nothing to do here}"

# Substrings
echo "Substring: ${FOO:5}"
echo "Substring: ${FOO:5:1}"

# Longitud de una cadena
echo "Longitud: ${#FOO}. Cadena: ${FOO}"

# Esto es overkill
echo ${FOO} | sed -e 's/o/u/g'

# Sustitución de cadenas
FOO='1Hola mundo!1!!1!1'
echo "${FOO/ /_}"   # Sustituir primer aparición sin importar posición
echo "${FOO//1/_}"  # Sustituir todas las apariciones
echo "${FOO/#1/_}"  # Sustituir solo si está al inicio
echo "${FOO/%1/_}"  # Sustituir solo si está al final
```

Se sugiere **no** depender de shell expasions para manejar valores estructurados
como `json`, es mejor delegar esto a una herramienta especializada como
[jq](https://stedolan.github.io/jq/) o [yq](https://mikefarah.gitbook.io/yq/)
para `yaml`.

### Variables especiales expandidas por la shell

- `~` es equivalente a utilizar la variable de entorno `$HOME`
- `$?` el "status code" más reciente
- `$_` el paramtetro más reciente
- `$@` expande la lista de argumentos que recibió una función o script
- `$#` es la cantidad de argumentos que recibió una función o script
- `$*` expande todos los argumentos que recibió una función o script como solo una cadena
- `$$` Identificador de proceso (PID) de la shell actual
- `$!` Identificador de proceso (PID) del proceso enviado background más reciente.
- `$0` Nombre con el que fue invocado el script actual
- `$IFS` "input field separator" determina el caracter usado para fin de cadena (o campo)

```sh
# Dan el mismo resultado
echo ~
echo $HOME

# Comprobemos diferencia entre $@ y $*
function expand_at () {
  echo "Son: $# argumentos"
  for i in "$@"; do
    echo $i
  done
}

function expand_star () {
  echo "Son: $# argumentos"
  for i in "$*"; do
    echo $i
  done
}

expand_at uno dos tres cuatro cinco
expand_star uno dos tres cuatro cinco
```

### Variables de ambiente

Hay varibles de entorno seteadas por el sistema y otras que se cargan al iniciar
"sesión". Para fines prácticos nos enfocaremos en las más utilizadas

```sh
# Que shell estoy utilizando en este momento
echo $SHELL
# Cual es el HOME de mi actual usuario
echo $HOME
# En que directorio está mi shell apuntando actualmente
echo $PWD
# En donde están todos los binarios que puedo invocar en esta shell
echo $PATH
```

Acerca de `$PATH`, esta variable la utiliza la shell para buscar los binarios o
cli que puede utilizar. Por eso, cuando instalamos manualmente un binario en un
path no estandar necesitamos agregarlo a dicha variable para que la shell lo
reconozca.

Ver más en el [manual](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html)

### Exportar variables

El comando `export` nos permite exportar valores para que otros proceso con el
mismo padre puedan verlo.

```sh
echo 'echo $UNA_VARIABLE' > /tmp/script_temporal.sh
chmod +x /tmp/script_temporal.sh   # Damos permisos de ejecución

# Ejecutamos nuestro script
/tmp/script_temporal.sh

# Ahora exportamos la variable que necesita y ejecutamos de nuevo
export UNA_VARIABLE='Esta variable viene de otro proceso'
/tmp/script_temporal.sh
```

Aclaraciones:
  - `chmod` **no** es un shell built-in.
  - el simbolo `>` usamos para redireccionar la salida del `echo`, se verá más
    adelante.

### Manejo de flujos de datos

Los procesos en sistemas Unix-like manejan 3 flujos de datos por defecto:

- Standard Input - STDIN
- Standard Output - STDOUT
- Standard Error - STDERR

Las POSIX shell abstraen el manejo de estos flujos por medio de los siguientes símbolos

- `>` redirige STDOUT
- `>>` agrega (append) y redirige STDOUT
- `2>` redirige el STDERR
- `2>&1` converge STDERR hacia STDOUT

- `<` redirige el STDIN
- `|` redirige STDOUT de un proceso hacia el STDIN de otro


```sh
# Por defecto las shell imprimen lo que llege a STDOUT
echo 'Hola mundo'

# Ya no veremos el mensaje al redirigir el STDOUT del echo
echo 'Hola mundo' >/tmp/ejemplo.log
# Podemos hacer "append" al usar >>
echo 'Esta es la línea 2' >>/tmp/ejemplo.log

# Podemos verificar el archivo usando cat
cat /tmp/ejemplo.log

# Estamos imprimiendo el STDIN de la subshell
echo "$(</tmp/ejemplo.log)"

# Estamos redirigiendo el STDOUT del echo hacia el STDIN de tr
echo 'Hola mundo' | tr 'o' '-'
```

Aclaración. `cat` y `tr` son [GNU core utilities](https://www.gnu.org/software/coreutils/).

#### Heredocs

```sh
FOO='Soporta expansiones de variables'

cat << EOF >/tmp/archivo.txt
Esto es un heredoc :D

$FOO
EOF
```

Aclaración. `cat` es una [GNU core utility](https://www.gnu.org/software/coreutils/).

#### Leer archivos línea a línea

```sh
# ¿Cuántos "cli" tienes en tu sistema operativo?
ls -1 $(echo $PATH | tr ':' ' ')| sort | uniq | wc -l

# Ahora escribamos los primeros diez en un archivo
ls -1 $(echo $PATH | tr ':' ' ')| sort | uniq | tail -10 >/tmp/comandos.log

# leeremos el archivo de ejemplo línea por línea
while read -r linea; do
  echo "Encontré: $linea";
done </tmp/comandos.log
```

Aclaración. `sort`, `uniq`, `wc` y `tail` son [GNU core utilities](https://www.gnu.org/software/coreutils/).


### Sustitución de shell y sub-shell

```sh
# Uso antiguo
FECHA=`date`
echo $FECHA

# Uso sugerido
FECHA=$(date)
echo $FECHA
```

La sub-shell es similar, inclusive en sintaxis `()`. La diferencia es que la
sub-shell actua como solo un proceso, mientras que la sustitución como si fuera
una expasión de variable "especial"

```sh
echo $(date; echo '') | wc -l
(date; echo '' ) | wc -l
```

Aclaraciones:
  - `wc` y `date` **no** son built-in commands
  - el uso de `;` se verá en la siguiente sección

#### El comando eval

>  Read ARGs as input to the shell and execute the resulting command

A simple vista, uno podría pensar que es lo mismo que una sustitución de shell,
sin embargo `eval` es usado cuando se necesita interpretar la salida de un
proceso y queremos que este mismo se ejecute.

Usalmente se utiizan en comando que levantan "deamons" o tienen interacciones al
fondo como `ssh-agent` por ejemplo.

```sh
# ssh-agent imprime en STDOUT las variables asociadas al daemon process
ssh-agent
SSH_AUTH_SOCK=<a/path>; export SSH_AUTH_SOCK;
SSH_AGENT_PID=<a PID>; export SSH_AGENT_PID;
echo Agent pid <a PID>;
# Al hacer eval del STDOUT logramos exportar las variables que ssh-agent imprimió
$ eval $(ssh-agent)
```

### Flujo de ejecución

Las POSIX shell te permiten manejar el flujo de como se ejecutan los procesos:

- `||` Ejecuta el siguiente proceso, cuando el primero returna un código de estado que no sea `0`
- `&&` Ejecuta el siguiente proceso, si y solo si el primero returna un código de estado `0`
- `;` Ejecuta el siguiente proceso, sin importar el código de estado del primero
- `:` Operador "noop" o "null". No hace nada y retorna código de estado `0`


```sh
# Ejecutar el segundo cuando el primero "falle"
(exit 1) || echo ':)'

# Ejecutar el segundo cuando el primero sea exitoso
(exit 0) && echo ':)'

# Ejecutar el segundo sin importar el estado del primero
(exit 1); echo ':)'

# "nada pasó acá"
:

# Caso especial de :
BAZ='valor1'
: ${BAZ:=valor2}
echo $?
echo $BAZ
```

### Manejo de señales

Las POSIX shell permiten "atrapar" las señales que reciben. Por lo general esto
es útil cuando queremos hacer limpieza de elementos temporales al terminar la
ejecución de nuestro script

```sh
cat << EOF >/tmp/ejemplo-trap.sh
#!/bin/bash

setup_tmp() {
  TMP_DIR=$(mktemp -d)

  cleanup() {
    code=$?
    set +e
    trap - EXIT
    rm -rf "\${TMP_DIR}"
    exit \$code
  }
  trap cleanup INT EXIT

  export TMP_DIR
}

setup_tmp
echo "Can't touch this" > \$TMP_DIR/mc-hammer.log
cd \$TMP_DIR && pwd && ls -talh
EOF

chmod +x /tmp/ejemplo-trap.sh
/tmp/ejemplo-trap.sh
```

Aclaración. `mktemp` **no** es un built-in command.

### Utilidades

Existe una amplia variedad de "utility commands", a continuación listaremos los
de uso frecuente

- `pwd` Imprime el acutla directorio que la shell está usando (working directory)
- `cd` Cambia el "working directory" hacia el que se le pase como argumento
  - `pushd`, `popd` (no soportado por todas las shells) Similar a `cd` pero da la noción de una pila
- `history` Imprime todos los comandos que la shell ha ejecutado hasta el momento
- `alias` Permite crear "alias" a los comandos
- `getops` Es utilizado dentro de los scripts para soportar "banderas"
- `&`, `fg` y `wait` Son utilizados para enviar un proceso a background, listar procesos en background y esperar por que todos los procesos en background terminen respectivamente.
- `help` (bash only)

### Scripts, funciones y parametros

Haremos una demostración juntos durante la charla, aún así la solución la puedes
encontrar en `gh-lookup.sh`.

Pero antes, abordemos unos cuantos símbolos o comandos que no hemos visto antes

- `#!` Conocido como "shebang". Cuando viene en la primer línea del script le
  indica al sistema cual es el interprete preferido para lo que viene a
  continuación.
- `/bin/bash -e` Está pasando la bandera `-e` al interprete, el cual provoca que
  se detenga cuando un comando returne un código de estado diferente a 0.

#### Argumentos posicionales

Los scripts y las funciones reciben los parametros que se pasaron al momento de
ser invocados en variables especiales llamadas "posicionales".

#### Otros ejemplos

Puede ver estos conceptos en uso en las siguientes utilerías escritas por la
comunidad de Kubernetes Guatemala

- [Bash CNI plugin](https://github.com/adawolfs/CNI-plugin-from-Scratch/blob/main/fhcn-cni)
- [GH Candle - Sincroniza perfiles de GitHub](https://github.com/jossemarGT/gh-candle)

## Recursos externos para seguir aprendiendo

- [Bash manual - Shell expansions](https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions)
- [Bash manual - Special parameters](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html)
- [Bash manual - Bash environment variables](https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html)
- [Autoconf Manual - Limitations of built-ins](https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Limitations-of-Builtins.html)
- [POSIX specification up-to-date](https://pubs.opengroup.org/onlinepubs/9699919799/)
- [POSIX shell language specification](https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xcu_chap02.html)
