#TRABALHO 1 DA DISCIPLINA PIHS- FERNANDO SILVA SILVÉRIO - 98936 - UEM - 2020
.section .data
    #ABERTURA DO PROGRAMA
    abertura:	.asciz	"\nTrabalho Pratico #1 - Gestão de RH - by Fernando S. Silvério (98936)\n\n"
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
    selecaoOp: .asciz "\nDIGITAR A SUA ESCOLHA:\n"
    opcao:  .int 0
    #DEFINIÇÃO DO TAMANHO DO REGISTRO (EM BYTES)
    tamDoRegistro:		.int	61
    #DEFINIÇÃO DE RÓTULOS PARA TIPOS
	Inteiro:	.asciz	"%d"
	Char:	.asciz	"%c"
	String:	.asciz	"%s"
	lista:		.int	0
    lista_copy:  .int    0
	NULL:		.int	0
    pulaLin:    .asciz "\n"
    #PARA ORIENTACAO NA LISTA
    p_inicio:    .int NULL
    p_atual: .int NULL
	p_ant: .int NULL
	p_fim: .int NULL
    flag:   .int 0
    #MENSAGENS SUPORTE
    msgEmpty:   .asciz "LISTA VAZIA\n"

    

.section .text
.globl _start

_start:
    pushl $abertura
    call printf
    addl $4, %esp
    jmp _menu
_fim:
    pushl $0
    call exit

# FUNCOES PARA INSERCAO DE REGISTROS

_insertReg:
    movl tamDoRegistro, %ecx
    pushl %ecx
    call malloc
    movl %eax, lista
    addl $4, %esp
    movl lista, %edi
    call _readReg

    movl p_inicio, %eax

    cmpl $NULL, %eax
    jne _searchPosition

_readReg:
    pushl %edi

    pushl $pedeNome
    call printf
    addl $4, %esp
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

_searchPosition:
    movl %eax, p_ant
    movl 61(%eax), %ebx
    movl %ebx, p_atual

    pushl p_inicio
    pushl %edi
    call strcasecmp
    addl $8, %esp
    cmpl $0, %eax
    jle _insertStart

    pushl p_fim
    pushl %edi
    call strcasecmp
    addl $8, %esp
    cmpl $0, %eax
    jge _insertEnd


_searchMid:
    movl p_atual, %eax
    cmpl %eax, p_fim
    je _insertInPosition

    movl %eax, p_atual
    pushl p_atual
    pushl %edi
    call strcasecmp
    addl $8, %esp
    cmpl $0, %eax
    jle _insertInPosition

    movl p_atual, %eax
    movl %eax, p_ant
    movl 61(%eax), %ebx
    movl %ebx, p_atual
    jmp _searchMid


_insertInPosition:
    movl p_atual, %eax
    movl p_ant, %esi
    movl %edi, 61(%esi)
    movl %eax, 61(%esi)
    ret


_insertStart:
    movl p_inicio, %esi
    movl %esi, 61(%edi)
    movl %edi, p_inicio
    ret

_insertEnd:
    movl p_fim, %eax
    movl %edi, 61(%eax)
    movl %edi, p_fim
    ret


#FUNCOES PARA MOSTRAR REGISTROS

_showReg:
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


_return:
    ret

_emptyList:
    pushl $msgEmpty
    call printf
    addl $4, %esp
    jmp _return

_iterateList:
    call _showReg
    pushl $pulaLin
    call printf
    addl $4, %esp
    cmpl %edi, p_fim
    je _return
    movl 61(%edi), %edi
    jmp _iterateList



_show_all_records:
    movl p_inicio, %edi
    cmpl $NULL, %edi
    je _emptyList
    jne _iterateList


#FUNCOES PARA REMOVER

_removeReg:

#FUNCOES PARA BUSCA

_show_Reg_ByName:



_menu:
    pushl $menu
    call  printf
    pushl $selecaoOp
    call  printf
    pushl $opcao
    pushl $Inteiro
    call scanf
    addl $16, %esp

    #PARA REMOVER O ENTER E EVITAR BUGS
    pushl $Char
    call scanf
    addl $4, %esp

    cmpl $0, opcao
    jz   _fim
    cmpl $1, opcao
    jz   _insertReg
    cmpl $2, opcao
    jz   _removeReg 
    cmpl $3, opcao
    jz   _show_Reg_ByName 
    cmpl $4, opcao
    jz   _show_all_records

    jmp _menu  