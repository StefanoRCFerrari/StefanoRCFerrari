#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX 129

// Função auxiliar para achar o min e max de um ÚNICO canal.
void achaEspectroCont(int canal[MAX][MAX], int cols, int rows, int *min_val, int *max_val) {
    int minAtual = 255;
    int maxAtual = 0;
    int i, j;

    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            int val = canal[i][j];

            if (val < minAtual) minAtual = val;
            if (val > maxAtual) maxAtual = val;
        }
    }

    *min_val = minAtual;
    *max_val = maxAtual;
}


void readImage(char *name, int R[MAX][MAX], int G[MAX][MAX], int B[MAX][MAX], int *cols, int *rows){
	int i, j, lixo;
	char p;

	FILE *f;
	f = fopen(name, "r");
	if(f==NULL){
		printf("Erro ao abrir a imagem \"%s\".\n", name);
		return;
	}
	fscanf(f, "%c", &p);
	fscanf(f, "%d", &lixo);
	fscanf(f, "%d %d", cols, rows);
	fscanf(f, "%d", &lixo);
	for(i=0;i<(*rows);i++){
		for(j=0;j<(*cols);j++){
			fscanf(f, "%d %d %d", &R[i][j], &G[i][j], &B[i][j]);
		}
	}
	fclose(f);
}

void writeImage(char *arqSaida, int R[MAX][MAX], int G[MAX][MAX], int B[MAX][MAX], int cols, int rows){
  	int i, j;
  	FILE *f;

  	f = fopen(arqSaida, "w");
  	fprintf(f, "P3\n%d %d\n255\n",cols, rows);

	for(i=0;i<rows;i++){
		for(j=0;j<cols;j++){
			fprintf(f, "%d %d %d", R[i][j], G[i][j], B[i][j]);
			if (j<cols-1){
				fprintf(f, " ");
			}
		}
		fprintf(f, "\n");
	}
	fclose(f);
}

void esticarContraste(int R[MAX][MAX], int G[MAX][MAX], int B[MAX][MAX], int novaR[MAX][MAX], int novaG[MAX][MAX], int novaB[MAX][MAX], int cols, int rows){
	int minR, maxR, minG, maxG, minB, maxB;
    int i, j;

    // Acha o espectro (min/max) de cada canal separadamente
    achaEspectroCont(R, cols, rows, &minR, &maxR);
    achaEspectroCont(G, cols, rows, &minG, &maxG);
    achaEspectroCont(B, cols, rows, &minB, &maxB);

    float rangeR = (float)(maxR - minR);
    float rangeG = (float)(maxG - minG);
    float rangeB = (float)(maxB - minB);

    // Prevenção contra divisão por zero (caso o canal seja monocromático)
    if (rangeR == 0.0f) rangeR = 1.0f;
    if (rangeG == 0.0f) rangeG = 1.0f;
    if (rangeB == 0.0f) rangeB = 1.0f;

    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            int newR, newG, newB;

            // R (Fórmula de esticamento)
            float r_orig = (float)R[i][j];
            newR = (int)floorf(((r_orig - (float)minR) * 255.0f) / rangeR);

            // G (Fórmula de esticamento)
            float g_orig = (float)G[i][j];
            newG = (int)floorf(((g_orig - (float)minG) * 255.0f) / rangeG);

            // B (Fórmula de esticamento)
            float b_orig = (float)B[i][j];
            newB = (int)floorf(((b_orig - (float)minB) * 255.0f) / rangeB);

            // Limitar valores em [0, 255]
            novaR[i][j] = (newR > 255) ? 255 : ((newR < 0) ? 0 : newR);
            novaG[i][j] = (newG > 255) ? 255 : ((newG < 0) ? 0 : newG);
            novaB[i][j] = (newB > 255) ? 255 : ((newB < 0) ? 0 : newB);
        }
    }
}

void escalaCinza(int R[MAX][MAX], int G[MAX][MAX], int B[MAX][MAX], int novaR[MAX][MAX], int novaG[MAX][MAX], int novaB[MAX][MAX], int cols, int rows){
	int i, j;
    for(i=0; i<rows; i++){
        for(j=0; j<cols; j++){
            // Calcula a média dos três canais
            float avg = ((float)R[i][j] + G[i][j] + B[i][j]) / 3.0f;
            int new_val = (int)floorf(avg);

            // Aplica o valor médio a todos os canais
            novaR[i][j] = new_val;
            novaG[i][j] = new_val;
            novaB[i][j] = new_val;
        }
    }
}

int main(int argc, char **argv) {
  if (argc != 3) {
    fprintf(stderr, "Argumentos invalidos.\n");
    fprintf(stderr, "Usado:");
    for (int i=0; i<argc; i++) {
			fprintf(stderr, " %s", argv[i]);
    }
    fprintf(stderr, "\n");
    return 1;
  }
  char efeito[20];
  char *arqEntrada = argv[1];
  char *arqSaida = argv[2];
  int R[MAX][MAX], G[MAX][MAX], B[MAX][MAX], novaR[MAX][MAX], novaG[MAX][MAX], novaB[MAX][MAX];
  int cols, rows;

  // Lê o nome do efeito do stdin (como solicitado no template)
  scanf("%s", efeito);

  // 1. Lê a imagem de entrada
  readImage(arqEntrada, R, G, B, &cols, &rows);

  // 2. Aplica o filtro e escreve a imagem de saída
	if (strcmp(efeito, "cinza") == 0) {
    escalaCinza(R, G, B, novaR, novaG, novaB, cols, rows);
    writeImage(arqSaida, novaR, novaG, novaB, cols, rows);
	} else if (strcmp(efeito, "esticar") == 0) {
    esticarContraste(R, G, B, novaR, novaG, novaB, cols, rows);
    writeImage(arqSaida, novaR, novaG, novaB, cols, rows);
	} else {
    fprintf(stderr, "Erro: Efeito '%s' desconhecido. Use 'cinza' ou 'esticar'.\n", efeito);
    return 1;
	}


  return 0;
}
