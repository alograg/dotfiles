#!/usr/bin/env awk -f

FNR==NR { commands[$4]; next }
{
	for (command in commands) {
		if (index($0, command) == 1) {
			lines[$0]++
		}
	}
}

END {
  # Iterar sobre todas las líneas únicas
  for (line in lines) {
    # Imprimir el número de ocurrencias de la línea actual
    print lines[line], " times used: ", line
  }
}

