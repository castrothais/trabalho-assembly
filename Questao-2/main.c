#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

void imprimirDesenho(int numero) {
    for(int i = 0; i < numero-1; i++) {
        for(int j = 0; j < numero - i - 1; j++) {
            printf("* ");
        }
        for(int k = 0; k < i + 1; k++) {
            printf("# ");
        }
        printf("\n");
}
}

int validarNumeroNatural(int numero) {
    if (numero <= 0) {
        printf("Por favor, informe um número maior que zero.\n");
        return 0;
    }
    return 1;
}

int main() {
    setlocale(LC_ALL, "Portuguese");

    int numero;

    printf("Informe um número para imprimir o desenho: ");
    scanf("%d", &numero);

    if (validarNumeroNatural(numero)) {
        imprimirDesenho(numero);
    }

    return 0;
}
