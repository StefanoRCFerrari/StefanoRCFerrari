/* Stéfano Ferrari
    RA: 2760482511014
    Objetivo: Ler um arquivo PPM de entrada, aplicar um dos dois filtros (Escala de Cinza ou Esticar Contraste) e salvar a imagem resultante.
    O programa solicita e lê da entrada padrão (stdin) o nome dos arquivos PPM de entrada e saída e o nome do efeito.
    Depois, o programa cria um novo arquivo no formato PPM P3 com a imagem processada.*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Estrutura para representar a imagem.
typedef struct {
    int largura, altura, max;
    int *R, *G, *B;
} imagem;

// Sabe qual efeito aplicar
int reconheceFiltro(const char *s1, const char *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char*)s1 - *(const unsigned unsigned char*)s2;
}

void limpaMemoria(imagem *img) {
    free(img->R);
    free(img->G);
    free(img->B);
    free(img);
}


imagem* criaImagem(int larg, int alt, int valMax) {

    imagem *img = (imagem*)malloc(sizeof(imagem));

    img->largura = larg;
    img->altura = alt;
    img->max = valMax;

    int total_pixels = larg * alt;

    int tamanho_bytes = total_pixels * sizeof(int);

    img->R = (int*)malloc(tamanho_bytes);
    img->G = (int*)malloc(tamanho_bytes);
    img->B = (int*)malloc(tamanho_bytes);

    return img;
}

void achaEspectroCont(const imagem *img, int qualRGB, int *min_val, int *max_val) {

    int minAtual = 255;
    int maxAtual = 0;
    int total_pixels = img->largura * img->altura;

    for (int k = 0; k < total_pixels; k++) {
        int val;

        if (qualRGB == 0) val = img->R[k];
        else if (qualRGB == 1) val = img->G[k];
        else val = img->B[k];

        if (val < minAtual) minAtual = val;
        if (val > maxAtual) maxAtual = val;
    }

    *min_val = minAtual;
    *max_val = maxAtual;
}



void cinza(imagem *img) {

    int total_pixels = img->largura * img->altura;

    for (int k = 0; k < total_pixels; k++) {
        float avg = ((float)img->R[k] + img->G[k] + img->B[k]) / 3.0f;
        int new_val = (int)floorf(avg);

        img->R[k] = new_val;
        img->G[k] = new_val;
        img->B[k] = new_val;
    }
}

void contraste(imagem *img) {

    int minR, maxR, minG, maxG, minB, maxB;

    achaEspectroCont(img, 0, &minR, &maxR);
    achaEspectroCont(img, 1, &minG, &maxG);
    achaEspectroCont(img, 2, &minB, &maxB);

    float rangeR = (float)(maxR - minR);
    float rangeG = (float)(maxG - minG);
    float rangeB = (float)(maxB - minB);

    if (rangeR == 0.0f) rangeR = 1.0f;
    if (rangeG == 0.0f) rangeG = 1.0f;
    if (rangeB == 0.0f) rangeB = 1.0f;

    int total_pixels = img->largura * img->altura;

    for (int k = 0; k < total_pixels; k++) {

        // R
        float r_orig = (float)img->R[k];
        int newR = (int)floorf(((r_orig - (float)minR) * 255.0f) / rangeR);

        // G
        float g_orig = (float)img->G[k];
        int newG = (int)floorf(((g_orig - (float)minG) * 255.0f) / rangeG);

        // B
        float b_orig = (float)img->B[k];
        int newB = (int)floorf(((b_orig - (float)minB) * 255.0f) / rangeB);

        // Limitar) valores em [0, 255]
        img->R[k] = (newR > 255) ? 255 : ((newR < 0) ? 0 : newR);
        img->G[k] = (newG > 255) ? 255 : ((newG < 0) ? 0 : newG);
        img->B[k] = (newB > 255) ? 255 : ((newB < 0) ? 0 : newB);
    }
}


imagem* lerImagem(const char *filename) {

    FILE *fp = fopen(filename, "r");

    char format[3];
    int w, h, max_val;

    fscanf(fp, "%2s", format);
    fscanf(fp, "%d %d", &w, &h);
    fscanf(fp, "%d", &max_val);

    imagem *img = criaImagem(w, h, max_val);

    int total_pixels = w * h;
    for (int k = 0; k < total_pixels; k++) {
        fscanf(fp, "%d %d %d", &img->R[k],
