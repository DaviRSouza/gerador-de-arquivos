#!/bin/bash

diretorio="$(dirname "$(realpath "$0")")"
maior_numero=0
encontrado=false
nome_usuario=$USER

for arquivo in "$diretorio"/$nome_usuario*; do
    if [[ -f "$arquivo" ]]; then
        nome_arquivo=$(basename "$arquivo")
        if [[ $nome_arquivo =~ $nome_usuario([0-9]+) ]]; then
            numero="${BASH_REMATCH[1]}"
            if (( numero > maior_numero )); then
                maior_numero=$numero
                encontrado=true
            fi
        fi
    fi
done

if [[ $encontrado == false ]]; then
    contador=1
    limite=25
else
    contador=$((maior_numero + 1))  # Inicia do próximo número
    limite=$((maior_numero + 25))
fi

echo "$contador $limite"

while [[ $contador -le $limite ]]; do
    touch "$nome_usuario$contador"
    ((contador++))
done
