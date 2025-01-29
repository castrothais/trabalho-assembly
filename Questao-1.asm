.data
    vetor:      .word -1:20     # Vetor de 20 posi��es
    menu:       .asciiz "\n1) Limpar\n2) Inserir\n3) Eliminar\n4) Imprimir\n5) Finalizar\nEscolha uma op��o: "
    msgInserir: .asciiz "\nDigite um n�mero natural: "
    msgPosicao: .asciiz "\nDigite a posi��o (0-19): "
    msgCheio:   .asciiz "\nVetor est� cheio!\n"
    msgVazio:   .asciiz "\nPosi��o j� est� vazia!\n"
    msgInvalido: .asciiz "\nOp��o inv�lida!\n"
    msgVetorVazio: .asciiz "\nVetor vazio!\n"
    espaco:     .asciiz " "
    quebra:     .asciiz "\n"

.text
.globl main

main:
    # Inicializar vetor com -1
    jal limpar_vetor
    
menu_principal:
    # Imprimir menu
    li $v0, 4
    la $a0, menu
    syscall
    
    # Ler op��o
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Switch case do menu
    beq $t0, 1, op_limpar
    beq $t0, 2, op_inserir
    beq $t0, 3, op_eliminar
    beq $t0, 4, op_imprimir
    beq $t0, 5, op_finalizar
        
    # Op��o inv�lida
    li $v0, 4
    la $a0, msgInvalido
    syscall
    j menu_principal

op_limpar:
    jal limpar_vetor
    j menu_principal
    
op_inserir:
    # Solicitar n�mero
    li $v0, 4
    la $a0, msgInserir
    syscall
    
    # Ler n�mero
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Verificar se � natural
    bltz $t1, menu_principal
    
    # Procurar posi��o vazia (-1)
    li $t2, 0          # �ndice
    la $t3, vetor
    
procurar_vazio:
    beq $t2, 20, vetor_cheio
    lw $t4, ($t3)
    beq $t4, -1, inserir_numero
    addi $t2, $t2, 1
    addi $t3, $t3, 4
    j procurar_vazio

inserir_numero:
    sw $t1, ($t3)
    j menu_principal

vetor_cheio:
    li $v0, 4
    la $a0, msgCheio
    syscall
    j menu_principal

op_eliminar:
    # Solicitar posi��o
    li $v0, 4
    la $a0, msgPosicao
    syscall
    
    # Ler posi��o
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Verificar se posi��o � v�lida
    bltz $t1, menu_principal
    bge $t1, 20, menu_principal
    
    # Calcular endere�o do elemento
    la $t2, vetor
    mul $t3, $t1, 4
    add $t2, $t2, $t3
    
    # Verificar se posi��o j� est� vazia
    lw $t4, ($t2)
    beq $t4, -1, posicao_vazia
    
    # Eliminar n�mero
    li $t4, -1
    sw $t4, ($t2)
    j menu_principal

posicao_vazia:
    li $v0, 4
    la $a0, msgVazio
    syscall
    j menu_principal

op_imprimir:
    la $t0, vetor      # endere�o base do vetor
    li $t1, 0          # contador
    li $t3, 0
    
imprimir_loop:
    beq $t1, 20, verificar_vazio
    
    # Carregar n�mero atual
    lw $t2, ($t0)
    
    # Verificar se n�o � -1
    beq $t2, -1, proximo_numero
    
    # Se chegou aqui, encontrou um n�mero para imprimir
    li $t3, 1          # marca que encontrou pelo menos um n�mero
    
    # Imprimir n�mero
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Imprimir espa�o
    li $v0, 4
    la $a0, espaco
    syscall
    
proximo_numero:
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    j imprimir_loop

verificar_vazio:
    beq $t3, $zero, imprimir_vazio   # Se n�o imprimiu nenhum n�mero, mostra mensagem
    
    # Imprimir quebra de linha
    li $v0, 4
    la $a0, quebra
    syscall
    j menu_principal

imprimir_vazio:
    li $v0, 4
    la $a0, msgVetorVazio
    syscall
    j menu_principal

op_finalizar:
    li $v0, 10
    syscall

# Fun��o para limpar vetor
limpar_vetor:
    la $t0, vetor      # endere�o base do vetor
    li $t1, 0          # contador
    li $t2, -1         # valor a ser inserido
    
limpar_loop:
    beq $t1, 20, limpar_fim
    sw $t2, ($t0)
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    j limpar_loop
    
limpar_fim:
    jr $ra
