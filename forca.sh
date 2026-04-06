#!/bin/bash
# Stéfano Ferrari - Jogo da Forca em Bash

# Cores ANSI
verde="\e[32m"
vermelho="\e[31m"
reset="\e[0m"

# Função pra desenhar a forca - ASCII
desenhar_forca() {
    case $numero_tent in
        0) 
            echo -e " _______\n |     |\n |\n |\n |\n |\n=====" 
            ;;
        1) 
            echo -e " _______\n |     |\n |     O\n |\n |\n |\n=====" 
            ;;
        2) 
            echo -e " _______\n |     |\n |     O\n |     |\n |\n |\n=====" 
            ;;
        3) 
            echo -e " _______\n |     |\n |     O\n |    /|\n |\n |\n=====" 
            ;;
        4) 
            echo -e " _______\n |     |\n |     O\n |    /|\\ \n |\n |\n=====" 
            ;;
        5) 
            echo -e " _______\n |     |\n |     O\n |    /|\\ \n |    /\n |\n=====" 
            ;;
        6) 
            echo -e " _______\n |     |\n |     O\n |    /|\\ \n |    / \\ \n |\n=====" 
            ;;
    esac
}

# Mostra palavra oculta
mostrar_palavra() {
    echo -ne "Palavra: "
    for ((cont=0; cont<tamanho; cont++)); do
        echo -ne "${oculta[$cont]} "
    done
    echo
}

# Mostra letras usadas com cor
mostrar_tentativas() {
    echo -ne "Letras usadas: "
    for ((cont=0; cont<qt_tentadas; cont++)); do
        letra="${ja_tentou[$cont]}"
        if [[ "${resultado_tentativa[$cont]}" -eq 1 ]]; then
            echo -ne "${verde}${letra}${reset} "
        else
            echo -ne "${vermelho}${letra}${reset} "
        fi
    done
    echo
}

# Verifica se venceu
verificar_vitoria() {
    venceu=1
    for ((cont=0; cont<tamanho; cont++)); do
        if [[ "${oculta[$cont]}" == "_" ]]; then
            venceu=0
            break
        fi
    done
}

# Processa tentativa
processar_tentativa() {
    acertou=0
    for ((cont=0; cont<tamanho; cont++)); do
        if [[ "${escolhida:$cont:1}" == "$tentativa" ]]; then
            oculta[$cont]="$tentativa"
            acertou=1
        fi
    done

    resultado_tentativa[$qt_tentadas]=$acertou

    if [[ $acertou -eq 0 ]]; then
        ((numero_tent++))
        echo -e "${vermelho}Errou!${reset}"
    else
        echo -e "${verde}Acertou!${reset}"
    fi
}

resp="S"

while [[ "$resp" == "S" ]]; do
    numero_tent=0
    tentativa=""
    cont=0
    listaPalavras=(
        "abacaxi" "porcelana" "sereia" "fatia" "janela"
        "farofa" "protetor" "cuidado" "satisfeito" "toalha"
        "costela" "academia" "perigoso" "arejado" "setembro"
        "meridiano" "mosquito" "recibo" "questionamento" "gravata"
    )
    ja_tentou=()
    resultado_tentativa=()
    qt_tentadas=0
    random=$((RANDOM % ${#listaPalavras[@]}))
    escolhida="${listaPalavras[$random]}"
    tamanho=${#escolhida}
    oculta=()
    for ((cont=0; cont<tamanho; cont++)); do
        oculta+=("_")
    done

    while true; do
        echo
        desenhar_forca
        mostrar_palavra
        mostrar_tentativas
        echo "Erros: $numero_tent/6"
        read -p "Digite uma letra: " tentativa
        tentativa=$(echo "$tentativa" | tr '[:upper:]' '[:lower:]')

        if [[ ! "$tentativa" =~ ^[a-z]$ ]]; then
            echo "Digite apenas uma letra valida!"
            continue
        fi

        repetida=0
        for ((cont=0; cont<qt_tentadas; cont++)); do
            if [[ "${ja_tentou[$cont]}" == "$tentativa" ]]; then
                repetida=1
                break
            fi
        done

        if [[ $repetida -eq 1 ]]; then
            echo "Voce ja tentou essa letra!"
            continue
        fi

        ja_tentou[$qt_tentadas]="$tentativa"
        processar_tentativa
        ((qt_tentadas++))
        verificar_vitoria

        if [[ $venceu -eq 1 ]]; then
            echo
            mostrar_palavra
            echo -e "${verde}Voce venceu!${reset}"
            break
        fi

        if [[ $numero_tent -ge 6 ]]; then
            echo
            desenhar_forca
            echo -e "${vermelho}Voce perdeu! Palavra era: $escolhida${reset}"
            break
        fi
    done

    read -p "Deseja jogar novamente? (S/N): " resp
    resp=$(echo "$resp" | tr '[:lower:]' '[:upper:]')
    while [[ "$resp" != "S" && "$resp" != "N" ]]; do
        echo "Entrada invalida. Digite S ou N:"
        read resp
        resp=$(echo "$resp" | tr '[:lower:]' '[:upper:]')
    done
done
