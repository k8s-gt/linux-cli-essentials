# POSIX shell 101

Una de las herramientas mas importantes y temidas por todos los que deseamos
introducirnos al mundo de GNU Linux es la interfaz de linea de comandos. En este
apartado encontrarás ejercicios básicos y prácticos para aprender de las POSIX
Shells.

La grabación de la charla donde se compartió este material la puedes
[ver acá](https://www.youtube.com/watch?v=SFJlgpWhHZQ).

**NOTA**: Los ejercicios que encuentras acá están enfocados en utilizar los "Shell
built-in commands" en la manera de lo posible. Hay unas pocas excepciones pero
lo haremos notar en su momento.

- [The developer friendly side 👾](#the-developer-friendly-side-)
  - [Donde todos comenzamos](#donde-todos-comenzamos)
  - [Variables](#variables)
  - [Expresiones](#expresiones)
    - [Aritméticas](#aritméticas)
    - [Lógicas](#lógicas)
    - [Interpolación de cadenas](#interpolación-de-cadenas)
  - [Condicionales](#condicionales)
    - [if](#if)
    - [case](#case)
  - [Iteradores](#iteradores)
    - [while / until](#while--until)
    - [for](#for)
  - [Scripts, funciones y parametros](#scripts-funciones-y-parametros)
- [Recursos externos para seguir aprendiendo](#recursos-externos-para-seguir-aprendiendo)

## The developer friendly side 👾

### Donde todos comenzamos

```sh
# Hola mundo
echo 'Hola mundo'
```

<!-- Roll credits? -->

### Variables

```sh
# Asignación de valor
FOO='bar'
```

```sh
# Acceso al valor
echo $FOO
```

<!-- Las constantes las veremos más adelante -->

### Expresiones

#### Aritméticas

```sh
# Asignar valor númerico a N
let 'N=1+1'
echo $N
# Incrementar N en 1
let N++
echo $N
# Asignar valor númerico a M usando otra notación
M=$(( N + 5 ))
echo $M
# Disminuir M en 1
(( M-- ))
echo $M
# No necesita ser asignado para ser interpretado
echo $(( 4 * 5 ))
echo $(( N * M ))
echo $(( RANDOM % 20 )) # Un número del 1 al 20 al azár
```

Las shell solo manejan arimética de números enteros, por lo cual es recomendable
usar otras aplicaciones para este tipo de operaciones

#### Lógicas

Las POSIX shell no manejan valores lógicos de manera explicita. Es decir no hay
valores `true` o `false`.

En su lugar, se utiliza el valor que retornan otros comandos (exit code) tomando
`0` como éxitoso/verdadero y cualquier otro número como contrario.

#### Interpolación de cadenas

Para las shells todos los valores son cadenas de texto, no existen tipos explícitos.

```sh
FOO='mundo' # Comilla simple ' deshabilita interpolación
echo "Hola ${FOO}" # Comillas dobles " son requeridas para interpolación
```

En realidad esto es "expansion" o "substitution" de variables, pero veremos más
de ello adelante.

### Condicionales

#### if

```sh
FOO='No es una cadena vacía'
if [ -n "${FOO}" ]; then
  echo $FOO
else
  echo 'La variable FOO está vacía'
fi
```

#### case

```sh
FOO=$(( RANDOM % 20 ))
echo $FOO
case "${FOO}" in
  1*)
    echo 'Este número inicia con 1'
    ;;

  2*)
    echo 'Este número inicia con 2'
    ;;

  *) # Default
    echo 'Este número inicia con otro número diferente de 1 o 2'
    ;;
esac
```

### Iteradores

#### while / until

```sh
N=1
while [ $N -le 3 ]; do
  echo "Contador: ${N}"
  N=$(( $N + 1 ))
done
```

```sh
N=1
until [ $N -gt 3 ]; do
  echo "Contador: ${N}"
  N=$(( $N + 1 ))
done
```

#### for

```sh
for i in 'uno' 'dos' 'tres'; do
    echo $i
done

# Lo siguiente corre en shells que no sean sh
ARR=("cat" "dog" "mouse" "frog")
for str in ${ARR[@]}; do
  echo $str
done
```

### Scripts, funciones y parametros

Ver archivo `calculadora.sh`

## Recursos externos para seguir aprendiendo

- [Numeric comparation operators](https://opensource.com/article/19/10/programming-bash-logical-operators-shell-expansions#numeric-comparison-operators)
- [Shell substitutions simply explained](http://mywiki.wooledge.org/CommandSubstitution)
- [Bash manual - Shell expansions](https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions)
- [Grabación de la sesión donde compartimos de cada concepto](https://www.youtube.com/watch?v=SFJlgpWhHZQ)
