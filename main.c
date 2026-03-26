#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define NUMEROPALAVRAS 20 //Isso facilita o aumento no número de palavras futuramente caso eu queira acrescentar sem precisar mudar uma variável de cada vez

int main() {

    char listaPalavras[NUMEROPALAVRAS][20] = {
        "abacaxi", "porcelana", "sereia", "fatia", "janela",
        "farofa", "protetor", "cuidado", "satisfeito", "toalha",
        "costela", "academia", "perigoso", "arejado", "setembro",
        "meridiano", "mosquito", "recibo", "questionamento", "gravata"
    }; //Pra colocar mais palavras, precisa mudar a constante NUMEROPALAVRAS no começo do código

    char resp = 'S';

    srand(time(NULL)); //Por algum motivo, isso é necessário para o Random. Ainda em estudo

    while (resp == 'S') { //Começa aqui

        int numero_tent = 0;
        char tentativa;
        int cont;

        char escolhida[20];
        char oculta[20];
        char ja_tentou[26];
        int qt_tentadas = 0;

        int random = rand() % NUMEROPALAVRAS;
        strcpy(escolhida, listaPalavras[random]); //Já separou a palavra que escolheu da lista sem zoar a original no vetor de cima

        int tamanho = strlen(escolhida);

        for (cont = 0; cont < tamanho; cont++) {
            oculta[cont] = '_';
        }
        oculta[tamanho] = '\0'; //Tava zoando as contagens e manipulações. Em bash provavelmente não zoe, mas se essa base ficar zoada, vai me dificultar a vida

        for (cont = 0; cont < 26; cont++) {
            ja_tentou[cont] = '-';
        }

        //Loopzinho básico do jogo em si até acertar ou morrer
        while (1) {

            printf("\nPalavra: ");
            for (cont = 0; cont < tamanho; cont++) {
                printf("%c ", oculta[cont]);
            }

            printf("\nLetras usadas: ");
            for (cont = 0; cont < qt_tentadas; cont++) {
                printf("%c ", ja_tentou[cont]);
            }

            printf("\nErros: %d/6\n", numero_tent);

            printf("Digite uma letra: ");
            scanf(" %c", &tentativa);

            tentativa = tolower(tentativa);


            if (tentativa < 'a' || tentativa > 'z') {
                printf("Digite apenas uma letra valida!\n");
                continue;
            }//C considera esses char como o valor ascii, então, isso salva demais


            int repetida = 0;
            for (cont = 0; cont < qt_tentadas; cont++) {
                if (ja_tentou[cont] == tentativa) {
                    repetida = 1;
                    break;
                }
            }

            if (repetida) {
                printf("Voce ja tentou essa letra!\n");
                continue;
            }

            ja_tentou[qt_tentadas] = tentativa;
            qt_tentadas++;

            int acertou = 0;

            for (cont = 0; cont < tamanho; cont++) {
                if (escolhida[cont] == tentativa) {
                    oculta[cont] = tentativa;
                    acertou = 1;
                }
            }

            if (!acertou) {
                numero_tent++;
                printf("Errou!\n");
            } else {
                printf("Acertou!\n");
            }

            int venceu = 1;//Deduz que venceu, exceto que encontre um underscore provando o contrário... É mais fácil do que conferir se é tudo letra...
            for (cont = 0; cont < tamanho; cont++) {
                if (oculta[cont] == '_') {
                    venceu = 0;
                    break;
                }
            }

            if (venceu) {
                printf("\nPalavra: %s\n", oculta);
                printf("Voce venceu!\n");
                break;
            }

            if (numero_tent >= 6) {
                printf("\nVoce perdeu! Palavra era: %s\n", escolhida);
                break;
            }
        }

        printf("\nDeseja jogar novamente? (S/N): ");
        scanf(" %c", &resp);
        resp = toupper(resp);

        while (resp != 'S' && resp != 'N') {
            printf("Entrada invalida. Digite S ou N: ");
            scanf(" %c", &resp);
            resp = toupper(resp);
        }
    }

    return 0;
}
