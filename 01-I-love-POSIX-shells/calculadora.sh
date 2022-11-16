#!/bin/bash

OPERACION="${1}"
OPERANDO_1="${2}"
OPERANDO_2="${3}"

imprimir_ayuda () {
  echo "${0} <Operación> <Operando 1> <Operando 2>

Operaciones soportadas
  - suma
  - resta
  - contador

Solo se soportan número enteros."
}

if [ -z "${OPERACION}" ]; then
  imprimir_ayuda
  exit 1
fi

case $OPERACION in
  sum*)
    echo (( OPERANDO_1 + OPERANDO_2 ))
    ;;
  resta*)
    echo (( OPERANDO_1 - OPERANDO_2 ))
    ;;
  cont*)
    if [ -z "${OPERANDO_2}" ]; then
      OPERANDO_2="${OPERANDO_1}"
      OPERANDO_1='1'
    fi

    if [ "${OPERANDO_1}" -gt "${OPERANDO_2}" ]; then
      echo "[ERROR] Orden de los argumentos es incorrecto. Intente: ${OPERACION} ${OPERANDO_2} ${OPERANDO_1}"
      exit 1
    fi

    while [ "${OPERANDO_1}" -le "${OPERANDO_2}" ]; do
      echo "${OPERANDO_1}"
      OPERANDO_1=$(( OPERANDO_1 + 1 ))
    done
    ;;
  *)
    echo "[ERROR] Operación $OPERACION no soportada"
    imprimir_ayuda
    exit 1
    ;;
esac

exit 0
