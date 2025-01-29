.data
mensagem:       .asciiz "Informe um número para imprimir o desenho: "
mensagemAlerta: .asciiz "Por favor, informe um número maior que zero.\n"
asteriscoSimbolo:  .asciiz "* "
jogodavelhaSimbolo: .asciiz "# "
quebrarLinha:    .asciiz "\n"

.text
.globl main
main:
    
    li $v0, 4
    la $a0, mensagem
    syscall
    
    
    li $v0, 5
    syscall
    move $t0, $v0           

    
    jal validarNumeroNatural

    beq $v0, $zero, end_program  
    jal imprimirDesenho

end_program:
    li $v0, 10
    syscall

validarNumeroNatural:
    blez $t0, numero_invalido 
    li $v0, 1                
    jr $ra

numero_invalido:
    li $v0, 0                
    li $v0, 4
    la $a0, mensagemAlerta
    syscall
    jr $ra

imprimirDesenho:
    move $t1, $t0            
    subi $t6, $t1, 1         
    li $t2, 0                

imprimir_linhas:
    bge $t2, $t6, end_desenho  
    sub $t3, $t1, $t2       
    subi $t3, $t3, 1         
    li $t4, 0                

imprimir_estrela:
    bge $t4, $t3, imprimir_hash 
    li $v0, 4                
    la $a0, asteriscoSimbolo 
    syscall
    addi $t4, $t4, 1         
    j imprimir_estrela       

imprimir_hash:
    addi $t3, $t2, 1         
    li $t4, 0                

imprimir_hash_loop:
    bge $t4, $t3, imprimir_quebra_linha 
    li $v0, 4                
    la $a0, jogodavelhaSimbolo 
    syscall
    addi $t4, $t4, 1         
    j imprimir_hash_loop     

imprimir_quebra_linha:
    li $v0, 4                
    la $a0, quebrarLinha     
    syscall
    addi $t2, $t2, 1         
    bne $t2, $t6, imprimir_linhas 

end_desenho:
    jr $ra                    