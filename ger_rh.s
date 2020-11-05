#TRABALHO 1 DA DISCIPLINA PIHS- FERNANDO SILVA SILVÉRIO - 98936 - UEM - 2020
.section .data
    #ABERTURA DO PROGRAMA
    abertura:	.asciz	"\nTrabalho Pratico #1 - Gestão de RH - by Fernando S. Silvério (98936)\nIniciando\n\n"
	#PRINTS PARA AS ENTRADAS DE DADOS
    pedeNome:	.asciz	"\nDigitar o nome completo: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
	pedeDataNasc:	.asciz	"\nDigitar data de nascimento: " #STRING DE 10 BYTES -> 2 BYTES PARA AS BARRAS E 8 PARA OS DIGITOS + CARACTER DE FIM DE STRING = 11 BYTES
    pedeGenero:	.asciz	"\nDigite o genero <M>asculino/<F>eminino " #CARACTER DE 1 BYTE
    pedeRua:    .asciz  "\nDigitar o logradouro: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeNumRua: .asciz  "\nDigitar o numero do logradouro: " #INTEIRO DE 4 BYTES
    pedeBairro: .asciz  "\nDigitar o nome do bairro: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES 
    pedeCep:    .asciz  "\nDigitar o CEP: " #STRING DE 8 BYTES + CARACTER DE FIM DE STRING = 9 BYTES 
    pedeCidade: .asciz  "\bDigitar o nome da cidade: " #STRING DE 20 BYTES + CARACTER DE FIM DE STRING = 21 BYTES
    pedeTelefone:   .asciz  "\nDigitar o telefone para contato: " #STRING DE 10 BYTES + CARACTER DE FIM DE STRING = 11 BYTES
    pedeEmail:  .asciz  "\nDigitar o email: " #STRING DE 40 BYTES + CARACTER DE FIM DE STRING = 41 BYTES
    pedeRg:     .asciz  "\nDigitar o numero do RG:" #STRING DE 9 BYTES + CARACTER DE FIM DE STRING = 10 BYTES
    pedeCpf:	.asciz	"\nDigitar o numero do CPF: " #STRING DE 11 BYTES + CARACTER DE FIM DE STRING = 12 BYTES
    pedeDataContr:  .asciz  "\nDigitar a data da contratacao: " #STRING DE 10 BYTES -> 2 BYTES PARA AS BARRAS E 8 PARA OS DIGITOS + CARACTER DE FIM DE STRING = 11 BYTES
    pedeCargo:  .asciz  "\nDigitar o cargo: " #STRING DE 10 BYTES + CARACTER DE FIM DE STRING = 11 BYTES
    pedeSalario:    .asciz  "\nDigitar o salario: " #INTEIRO DE 4 BYTES
    #MOSTRAR OS CAMPOS POR TIPO
	mostraNome:	.asciz	"\nNome: %s"
	mostraDataNasc:	.asciz	"\nData de Nascimento: %d"
	mostraCpf:	.asciz	"\nCPF: %s"
	mostraGenero:	.asciz	"\nGenero: %c"
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
    menu:   .asciz  "\nMENU DE SELECAO\n\n1- INSERIR UM REGISTRO\n2- REMOVER UM REGISTRO\n3- CONSULTAR REGISTRO POR NOME\n4- MOSTRAR RELATORIO DE REGISTROS\n0- SAIR"
    selecaoOp: .asciz "\nDigitar a sua escolha:\n"
    opcao:  .int 0
    #DEFINIÇÃO DO TAMANHO DO REGISTRO (EM BYTES)
    tamDoRegistro:		.int	296
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
_fim:
    pushl $0
    call exit
_escolher:

    #Menu inicial

    pushl $menu
    call printf
    addl $4, %esp
    
    #Selecao de opcao

    pushl $selecaoOp
    call printf
    #addl $4, %esp
    
    pushl $opcao
    pushl $Inteiro
    call scanf
    #addl $4, %esp

    movl $opcao, %eax

    cmpl $1, %eax
    je _insertReg

    cmpl $2, %eax
    je _removeReg

    cmpl $3, %eax
    je _readReg

    cmpl $4, %eax
    je _readRelatorio

    jmp _fim



_insertReg:

    #Alocando para a lista o tamanho do registro
    
    pushl tamDoRegistro
    call malloc
    movl %eax, lista
    addl $4, %esp

    #Lendo o nome
    
    pushl $pedeNome
    call printf
    addl $4, %esp
    movl lista, %edi
    pushl %edi
    call gets

    popl %edi
    addl $41, %edi

    #Lendo data de nascimento

    pushl %edi

    pushl $pedeDataNasc
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $11, %edi

    #Lendo o genero

    pushl %edi

    pushl $pedeGenero
    call printf
    addl $4, %esp
    pushl $Char
    call scanf
    addl $4, %esp

    popl %edi

    #Lendo nome da rua

    pushl %edi

    pushl $pedeRua
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $41, %edi

    #Lendo o numero da rua

    pushl %edi

    pushl $pedeNumRua
    call printf
    addl $4, %esp
    pushl $Inteiro
    call scanf
    addl $4, %esp

    popl %edi

    #Lendo bairro

    pushl %edi

    pushl $pedeBairro
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $41, %edi

    #Lendo CEP

    pushl %edi

    pushl $pedeCep
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $9, %edi

    #Lendo Cidade

    pushl %edi

    pushl $pedeCidade
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $21, %edi

    #Lendo telefone

    pushl %edi

    pushl $pedeTelefone
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $11, %edi

    #Lendo Email

    pushl %edi

    pushl $pedeEmail
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $41, %edi

    #Lendo RG

    pushl %edi

    pushl $pedeRg
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $10, %edi

    #Lendo CPF

    pushl %edi

    pushl $pedeCpf
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $12, %edi

    #Lendo data de contratacao

    pushl %edi

    pushl $pedeDataContr
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $11, %edi

    #Lendo Cargo

    pushl %edi

    pushl $pedeCargo
    call printf
    addl $4, %esp
    pushl %edi
    call gets

    popl %edi
    addl $11, %edi

    #Lendo salario

    pushl %edi

    pushl $pedeSalario
    call printf
    addl $4, %esp
    pushl $Inteiro
    call scanf
    addl $4, %esp

    popl %edi

    #Finalizando a leitura do registro

    addl $4, %edi

    movl $NULL, (%edi)

    ret


_removeReg:
    #remover registro
_readReg:
    #ler um registro por nome
_readRelatorio:
    #mostrar todos os registros



