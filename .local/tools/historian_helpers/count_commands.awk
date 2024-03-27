#!/usr/bin/env awk -f

# Función para procesar cada línea de cada archivo
{
  # Incrementar el contador de la línea actual
  lines[$1]++
}

# Función para imprimir las estadísticas al finalizar la lectura de todos los archivos
END {
  # Iterar sobre todas las líneas únicas
  for (line in lines) {
    # Imprimir el número de ocurrencias de la línea actual
    print lines[line], " times used: ", line
  }
}

