.data
    vetor:      .word -1:20     # Vetor de 20 posições
    menu:       .asciiz "\n1) Limpar\n2) Inserir\n3) Eliminar\n4) Imprimir\n5) Finalizar\nEscolha uma opção: "
    msgInserir: .asciiz "\nDigite um número natural: "
    msgPosicao: .asciiz "\nDigite a posição (0-19): "
    msgCheio:   .asciiz "\nVetor está cheio!\n"
    msgVazio:   .asciiz "\nPosição já está vazia!\n"
    msgInvalido: .asciiz "\nOpção inválida!\n"
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
    
    # Ler opção
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Switch case do menu
    beq $t0, 1, op_limpar
    beq $t0, 2, op_inserir
    beq $t0, 3, op_eliminar
    beq $t0, 4, op_imprimir
    beq $t0, 5, op_finalizar
        
    # Opção inválida
    li $v0, 4
    la $a0, msgInvalido
    syscall
    j menu_principal

op_limpar:
    jal limpar_vetor
    j menu_principal
    
op_inserir:
    # Solicitar número
    li $v0, 4
    la $a0, msgInserir
    syscall
    
    # Ler número
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Verificar se é natural
    bltz $t1, menu_principal
    
    # Procurar posição vazia (-1)
    li $t2, 0          # índice
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
    # Solicitar posição
    li $v0, 4
    la $a0, msgPosicao
    syscall
    
    # Ler posição
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Verificar se posição é válida
    bltz $t1, menu_principal
    bge $t1, 20, menu_principal
    
    # Calcular endereço do elemento
    la $t2, vetor
    mul $t3, $t1, 4
    add $t2, $t2, $t3
    
    # Verificar se posição já está vazia
    lw $t4, ($t2)
    beq $t4, -1, posicao_vazia
    
    # Eliminar número
    li $t4, -1
    sw $t4, ($t2)
    j menu_principal

posicao_vazia:
    li $v0, 4
    la $a0, msgVazio
    syscall
    j menu_principal

op_imprimir:
    la $t0, vetor      # endereço base do vetor
    li $t1, 0          # contador
    li $t3, 0
    
imprimir_loop:
    beq $t1, 20, verificar_vazio
    
    # Carregar número atual
    lw $t2, ($t0)
    
    # Verificar se não é -1
    beq $t2, -1, proximo_numero
    
    # Se chegou aqui, encontrou um número para imprimir
    li $t3, 1          # marca que encontrou pelo menos um número
    
    # Imprimir número
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Imprimir espaço
    li $v0, 4
    la $a0, espaco
    syscall
    
proximo_numero:
    addi $t1, $t1, 1
    addi $t0, $t0, 4
    j imprimir_loop

verificar_vazio:
    beq $t3, $zero, imprimir_vazio   # Se não imprimiu nenhum número, mostra mensagem
    
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

# Função para limpar vetor
limpar_vetor:
    la $t0, vetor      # endereço base do vetor
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
