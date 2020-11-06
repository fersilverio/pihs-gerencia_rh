#TRABALHO 1 DA DISCIPLINA PIHS- FERNANDO SILVA SILVÉRIO - 98936 - UEM - 2020
.section .data
    #ABERTURA DO PROGRAMA
    abertura:	.asciz	"\nTrabalho Pratico #1 - Gestão de RH - by Fernando S. Silvério (98936)\nIniciando\n\n"
	#PRINTS PARA AS ENTRADAS DE DADOS
    pedeNome:	.asciz	"\nDigitar o nome completo: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeCpf:	.asciz	"\nDigitar o numero do CPF: " #STRING DE 11 BYTES + CARACTER DE FIM DE STRING = 12 BYTES
    pedeGenero:	.asciz	"\nDigite o genero <M>asculino/<F>eminino " #CARACTER DE 1 BYTE

    #MOSTRAR OS CAMPOS POR TIPO
	mostraNome:	.asciz	"\nNome: %s"
    mostraGenero:	.asciz	"\nGenero: %c"
    mostraCpf:	.asciz	"\nCPF: %s"
    #MENU PRINCIPAL DO PROGRAMA
    menu:   .asciz  "\nMENU DE SELECAO\n\n1- INSERIR UM REGISTRO\n2- REMOVER UM REGISTRO\n3- CONSULTAR REGISTRO POR NOME\n4- MOSTRAR RELATORIO DE REGISTROS\n0- SAIR"
    selecaoOp: .asciz "\nDigitar a sua escolha:\n"
    opcao:  .int 0
    #DEFINIÇÃO DO TAMANHO DO REGISTRO (EM BYTES)
    tamDoRegistro:		.int	61
    #DEFINIÇÃO DE RÓTULOS PARA TIPOS
	Inteiro:	.asciz	"%d"
	Char:	.asciz	"%c"
	String:	.asciz	"%s"
	lista:		.int	0
	NULL:		.int	0
.section .text
.globl _start

_start:
    pushl $abertura
    call printf
    addl $4, %esp
    
    call _escolher
    #call _insertReg
    #call _showReg
_fim:
    pushl $0
    call exit






_insertReg:
    pushl tamDoRegistro
    call malloc
    movl %eax, lista
    addl $4, %esp

    pushl $pedeNome
    call printf
    addl $4, %esp

    movl lista, %edi
    pushl %edi
    call gets
    call gets

    popl %edi
    addl $41, %edi

    pushl %edi

    pushl $pedeCpf
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $12, %edi

    pushl %edi

    pushl $pedeGenero
    call printf
    addl $4, %esp
    pushl $Char
    call scanf
    addl $4, %esp

    popl %edi
    addl $4, %edi

    movl $NULL, (%edi)
    subl $57, %edi

    ret 


_showReg:
    movl lista, %edi
    
    pushl %edi

    pushl $mostraNome
    call printf
    addl $4, %esp

    popl %edi
    addl $41, %edi
    pushl %edi
    
    pushl %edi
    pushl $mostraCpf
    call printf
    addl $8, %esp

    popl %edi
    addl $12, %edi
    pushl %edi

    pushl (%edi)
    pushl $mostraGenero
    call printf
    addl $8, %esp

    popl %edi

    subl $53, %edi

    ret











_escolher:
    pushl $menu
    call printf

    pushl $opcao
    pushl $Inteiro
    call scanf

    addl $12, %esp


    cmpl $1, opcao
    jz _insertReg

    cmpl $0, opcao
    jz _fim

    jmp _escolher


