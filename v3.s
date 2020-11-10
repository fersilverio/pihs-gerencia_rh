#TRABALHO 1 DA DISCIPLINA PIHS- FERNANDO SILVA SILVÉRIO - 98936 - UEM - 2020
.section .data
    #ABERTURA DO PROGRAMA
    abertura:	.asciz	"\nTrabalho Pratico #1 - Gestão de RH - by Fernando S. Silvério (98936)\n\n"
	#PRINTS PARA AS ENTRADAS DE DADOS
    pedeNome:	.asciz	"\nDigitar o nome completo: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeCpf:	.asciz	"\nDigitar o numero do CPF: " #STRING DE 11 BYTES + CARACTER DE FIM DE STRING = 12 BYTES
    pedeGenero:	.asciz	"\nDigite o genero Masculino (M) ou Feminino (F): " #CARACTER DE 4 BYTE
    pedeDataNasc:	.asciz	"\nDigitar data de nascimento: " #STRING DE 10 BYTES -> 2 BYTES PARA AS BARRAS E 8 PARA OS DIGITOS + CARACTER DE FIM DE STRING = 11 BYTES
    pedeNomeBusca: .asciz "\nDigite o nome para a busca: "
    pedeRua:    .asciz  "\nDigitar o logradouro: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeNumRua: .asciz  "\nDigitar o numero do logradouro: " #INTEIRO DE 4 BYTES
    pedeBairro: .asciz  "\nDigitar o nome do bairro: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES 
    pedeCep:    .asciz  "\nDigitar o CEP: " #STRING DE 8 BYTES + CARACTER DE FIM DE STRING = 9 BYTES 
    pedeCidade: .asciz  "\bDigitar o nome da cidade: " #STRING DE 20 BYTES + CARACTER DE FIM DE STRING = 21 BYTES
    pedeTelefone:   .asciz  "\nDigitar o telefone para contato: " #STRING DE 10 BYTES + CARACTER DE FIM DE STRING = 11 BYTES
    pedeEmail:  .asciz  "\nDigitar o email: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeRg:     .asciz  "\nDigitar o numero do RG:" #STRING DE 9 BYTES + CARACTER DE FIM DE STRING = 10 BYTES
    pedeDataContr:  .asciz  "\nDigitar a data da contratacao: " #STRING DE 10 BYTES -> 2 BYTES PARA AS BARRAS E 8 PARA OS DIGITOS + CARACTER DE FIM DE STRING = 11 BYTES
    pedeCargo:  .asciz  "\nDigitar o cargo: " #STRING DE 10 BYTES + CARACTER DE FIM DE STRING = 11 BYTES
    pedeSalario:    .asciz  "\nDigitar o salario: " #INTEIRO DE 4 BYTES
    #MOSTRAR OS CAMPOS POR TIPO
	mostraNome:	.asciz	"\nNome: %s"
    mostraGenero:	.asciz	"\nGenero: %c"
    mostraCpf:	.asciz	"\nCPF: %s"
    mostraDataNasc:	.asciz	"\nData de Nascimento: %d"
    mostraRua:	.asciz	"\nLogradouro: %s"
	mostraNumRua:	.asciz	"\nNumero: %d"
	mostraBairro:	.asciz	"\nBairro: %s"
	mostraCep:	.asciz	"\nCEP: %s"
    mostraCidade:	.asciz	"\nCidade: %s"
	mostraTelefone:	.asciz	"\nTelefone: %s"
	mostraEmail:	.asciz	"\nEmail: %s"
	mostraRg:	.asciz	"\nRG: %s"
	mostraDataContr:	.asciz	"\nData de Contratacao: %s"
	mostraCargo:	.asciz	"\nCargo: %s"
	mostraSalario:	.asciz	"\nSalario: %d"
    #MENU PRINCIPAL DO PROGRAMA
    menu:   .asciz  "\n ****  MENU DE SELECAO  ****\n\n1----> INSERIR UM REGISTRO\n2----> REMOVER UM REGISTRO\n3----> CONSULTAR REGISTRO POR NOME\n4----> MOSTRAR RELATORIO DE REGISTROS\n0----> SAIR"
    selecaoOp: .asciz "\nDIGITAR A SUA ESCOLHA:\n"
    opcao:  .int 0
    #DEFINIÇÃO DO TAMANHO DO REGISTRO (EM BYTES)
    tamDoRegistro:		.int	270
    #DEFINIÇÃO DE RÓTULOS PARA TIPOS
	Inteiro:	.asciz	"%d"
	Char:	.asciz	"%c"
	lista:		.int	0
	NULL:		.int	0
    #PARA ORIENTACAO NA LISTA
    p_inicio:    .int NULL
    p_atual: .int NULL
	p_ant: .int NULL
	p_fim: .int NULL
    flag:   .int 0
    #STRINGS DE SUPORTE
    pulaLin:    .asciz "\n"
    divisoria:  .asciz "x-----x------x--------x"
    msgEmpty:   .asciz "\nLISTA VAZIA\n"
    msgIns: .asciz "\nREGISTRO INSERIDO COM SUCESSO\n"
    msgRgNotFound: .asciz "\nREGISTRO NAO ENCONTRADO\n"
    msgRmv: .asciz "\nREGISTRO REMOVIDO COM SUCESSO\n"
    msgRel: .asciz "\nRELATORIO -> RELACAO DE TODOS OS FUNCIONARIOS\n"
    #VARIAVEIS SUPORTE
    nomeBusca: .space 41


    

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
    movl %eax, 266(%edi)
    movl %edi, p_inicio
    movl %edi, p_fim

    pushl $msgIns
    call printf
    addl $4, %esp

    jmp _menu

_readReg:
    pushl %edi

    pushl $pedeNome
    call printf
    addl $4, %esp
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

    pushl %edi

    pushl $pedeDataNasc
    call printf
    addl $4, %esp
    call gets
    call gets

    popl %edi
    addl $10, %edi

    pushl %edi

    pushl $pedeRua
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $41, %edi

    pushl %edi

    pushl $pedeNumRua
    call printf
    addl $4, %esp
    pushl $Inteiro
    call scanf
    addl $4, %esp

    popl %edi
    addl $4, %edi

    pushl %edi

    pushl $pedeBairro
    call printf
    addl $4, %esp
    call gets
    call gets

    popl %edi
    addl $41, %edi

    pushl %edi

    pushl $pedeCep
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $9, %edi

    pushl %edi

    pushl $pedeCidade
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $21, %edi


    pushl %edi

    pushl $pedeTelefone
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $11, %edi


    pushl %edi

    pushl $pedeEmail
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $41, %edi


    pushl %edi

    pushl $pedeRg
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $10, %edi

    
    pushl %edi

    pushl $pedeDataContr
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $10, %edi


    pushl %edi

    pushl $pedeCargo
    call printf
    addl $4, %esp
    call gets

    popl %edi
    addl $11, %edi

    pushl %edi

    pushl $pedeSalario
    call printf
    addl $4, %esp
    pushl $Inteiro
    call scanf
    addl $4, %esp

    popl %edi
    addl $4, %edi

    movl $NULL, (%edi)
    subl $266, %edi

    ret

_searchPosition:
    movl %eax, p_ant
    movl 266(%eax), %ebx
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
    movl 270(%eax), %ebx
    movl %ebx, p_atual
    jmp _searchMid


_insertInPosition:
    movl p_atual, %eax
    movl p_ant, %esi
    movl %edi, 266(%esi)
    movl %eax, 266(%esi)
    jmp _menu


_insertStart:
    movl p_inicio, %esi
    movl %esi, 266(%edi)
    movl %edi, p_inicio
    jmp _menu

_insertEnd:
    movl p_fim, %eax
    movl %edi, 266(%eax)
    movl %edi, p_fim
    jmp _menu


#FUNCOES PARA MOSTRAR REGISTROS

_showReg:
    
    pushl $divisoria
    call printf
    addl $4, %esp
    
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
    addl $4, %edi
    pushl %edi

    #
    pushl %edi

    pushl $mostraDataNasc
    call printf
    addl $4, %esp

    popl %edi
    addl $10, %edi
    pushl %edi

    #

    pushl %edi
    pushl $mostraRua
    call printf
    addl $4, %esp

    popl %edi
    addl $41, %edi
    pushl %edi


    pushl (%edi)

    pushl $mostraNumRua
    call printf
    addl $4, %esp

    popl %edi
    addl $4, %edi
    pushl %edi


    pushl %edi

    pushl $mostraBairro
    call printf
    addl $4, %esp

    popl %edi
    addl $41, %edi
    pushl %edi


    pushl %edi

    pushl $mostraCep
    call printf
    addl $4, %esp

    popl %edi
    addl $9, %edi
    pushl %edi


    pushl %edi

    pushl $mostraCidade
    call printf
    addl $4, %esp

    popl %edi
    addl $21, %edi
    pushl %edi


    pushl %edi

    pushl $mostraTelefone
    call printf
    addl $4, %esp

    popl %edi
    addl $11, %edi
    pushl %edi


    pushl %edi

    pushl $mostraEmail
    call printf
    addl $4, %esp

    popl %edi
    addl $41, %edi
    pushl %edi


    pushl %edi

    pushl $mostraRg
    call printf
    addl $4, %esp

    popl %edi
    addl $10, %edi
    pushl %edi


    pushl %edi

    pushl $mostraDataContr
    call printf
    addl $4, %esp

    popl %edi
    addl $10, %edi
    pushl %edi


    pushl %edi

    pushl $mostraCargo
    call printf
    addl $4, %esp

    popl %edi
    addl $11, %edi
    pushl %edi


    pushl (%edi)

    pushl $mostraSalario
    call printf
    addl $8, %esp

    popl %edi
    addl $4, %edi


    popl %edi

    subl $262, %edi

    ret


_return:
    jmp _menu

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
    movl 266(%edi), %edi
    jmp _iterateList



_show_all_records:
    
    pushl $msgRel
    call printf
    addl $4, %esp
    
    movl p_inicio, %edi
    cmpl $NULL, %edi
    je _emptyList
    jne _iterateList


#FUNCOES PARA REMOVER

_removeReg:
    movl $0, flag
    call _searchReg_ByName2
    movl $0, %eax
    cmpl %eax, flag
    je _return
    cmpl %edi, p_inicio
    je _removeFront
    cmpl %edi, p_fim
    je _removeEnd
    jmp _removeMiddle

_removeFront:
    movl 266(%edi), %eax
    movl %eax, p_inicio
    pushl %edi
    call free
    pushl $msgRmv
    call printf
    addl $8, %esp
    jmp _return

_removeEnd:
    movl p_ant, %eax
    movl %eax, p_fim
    pushl %edi
    call free
    pushl $msgRmv
    call printf
    addl $8, %esp
    jmp _return

_removeMiddle:
    movl p_ant, %esi
    movl 270(%edi), %eax
    movl %eax, 270(%esi)
    pushl %edi
    call free
    pushl $msgRmv
    call printf
    addl $8, %esp
    jmp _return




# PROCURAR POR NOME SEM RETORNO PARA O MENU - VERSAO PARA REMOVER
_searchReg_ByName2:
    movl p_inicio, %edi
    cmpl $NULL, %edi
    je _emptyList
    pushl $pedeNomeBusca
    call printf
    pushl $nomeBusca
    call gets
    call gets
    addl $8, %esp

_searching2:
    pushl %edi
    pushl $nomeBusca
    call strcasecmp
    addl $8, %esp
    cmpl $0, %eax
    je _success2
    cmpl %edi, p_fim
    je _searchEnd2
    movl %edi, p_ant
    movl 266(%edi), %edi
    jmp _searching2


_success2:
    movl $1, %eax
    movl %eax, flag
    call _showReg
    pushl $pulaLin
    call printf
    addl $4, %esp
    jmp _returnForRemove

_searchEnd2:
    pushl $msgRgNotFound
    call printf
    addl $4, %esp
    jmp _returnForRemove


_returnForRemove:
    ret
    

#FUNCOES PARA BUSCA

_searchReg_ByName:
    movl p_inicio, %edi
    cmpl $NULL, %edi
    je _emptyList
    pushl $pedeNomeBusca
    call printf
    pushl $nomeBusca
    call gets
    call gets
    addl $8, %esp

_searching:
    pushl %edi
    pushl $nomeBusca
    call strcasecmp
    addl $8, %esp
    cmpl $0, %eax
    je _success
    cmpl %edi, p_fim
    je _searchEnd
    movl %edi, p_ant
    movl 266(%edi), %edi
    jmp _searching


_success:
    movl $1, %eax
    movl %eax, flag
    call _showReg
    pushl $pulaLin
    call printf
    addl $4, %esp
    jmp _return

_searchEnd:
    pushl $msgRgNotFound
    call printf
    addl $4, %esp
    jmp _return

_menu:
    pushl $menu
    call  printf
    pushl $selecaoOp
    call  printf
    pushl $opcao
    pushl $Inteiro
    call scanf
    addl $16, %esp


    cmpl $0, opcao
    jz   _fim
    cmpl $1, opcao
    jz   _insertReg
    cmpl $2, opcao
    jz   _removeReg 
    cmpl $3, opcao
    jz   _searchReg_ByName 
    cmpl $4, opcao
    jz   _show_all_records

    jmp _menu  

