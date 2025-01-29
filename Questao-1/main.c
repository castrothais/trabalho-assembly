#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#define TAMANHOVETOR 20

void imprimirVetor(int vetor[TAMANHOVETOR]) {
    printf("Conte�do do vetor:\n");
    for (int i = 0; i < TAMANHOVETOR; i++) {
        printf("%d ", vetor[i]);
    }
    printf("\n");
}

void eliminarValor(int vetor[TAMANHOVETOR]) {
    int posicao;
    printf("Informe a posi��o que deseja eliminar o valor:\n");
    scanf("%d", &posicao);

    if (posicao < 0 || posicao >= TAMANHOVETOR) {
        printf("Posi��o inv�lida! A posi��o deve ser entre 0 e %d.\n", TAMANHOVETOR - 1);
        return;
    }

    if (vetor[posicao] >= 0) {
        vetor[posicao] = -1;
        printf("Valor na posi��o %d foi eliminado.\n", posicao);
    } else {
        printf("A posi��o %d j� est� vazia!\n", posicao);
    }
}

void inserirValor(int vetor[TAMANHOVETOR]) {
    int numero;

    do {
        printf("Por favor, informe um n�mero maior ou igual a zero: ");
        scanf("%d", &numero);
    } while (numero < 0);

    for (int i = 0; i < TAMANHOVETOR; i++) {
        if (vetor[i] == -1) {
            vetor[i] = numero;
            printf("Valor %d inserido na posi��o %d.\n", numero, i);
            return;
        }
    }
    printf("N�o h� espa�o dispon�vel para inserir o valor.\n");
}

void limparVetor(int vetor[TAMANHOVETOR]) {
    for (int i = 0; i < TAMANHOVETOR; i++) {
        vetor[i] = -1;
    }
    printf("Vetor limpo.\n");
}

void imprimirMenu() {
    printf("\n =======================");
    printf("\n Menu");
    printf("\n =======================");
    printf("\n 1 - Limpar");
    printf("\n 2 - Inserir");
    printf("\n 3 - Eliminar");
    printf("\n 4 - Imprimir");
    printf("\n 5 - Finalizar");
    printf("\n =======================\n");
}

int main() {
    setlocale(LC_ALL, "Portuguese");
    int vetor[TAMANHOVETOR], opcao;

    for (int i = 0; i < TAMANHOVETOR; i++) {
        vetor[i] = -1;
    }

    while (1) {
        imprimirMenu();
        printf("Escolha uma op��o: ");
        scanf("%d", &opcao);

        while (opcao < 1 || opcao > 5) {
            printf("Por favor, informe uma op��o entre 1 e 5: ");
            scanf("%d", &opcao);
        }

        switch (opcao) {
            case 1:
                limparVetor(vetor);
                break;
            case 2:
                inserirValor(vetor);
                break;
            case 3:
                eliminarValor(vetor);
                break;
            case 4:
                imprimirVetor(vetor);
                break;
            case 5:
                printf("Programa finalizado.\n");
                return 0;
            default:
                printf("Op��o inv�lida! Tente novamente.\n");
                break;
        }
    }
}
