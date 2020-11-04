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
    menu:   .asciz  "\nMENU DE SELECAO\n\n1- INSERIR UM REGISTRO\n2- REMOVER UM REGISTRO\n3- CONSULTAR REGISTRO POR NOME\n4- MOSTRAR RELATORIO DE REGISTROS"
    #DEFINIÇÃO DO TAMANHO DO REGISTRO (EM BYTES)
    tamDoRegistro:		.int	296
    #DEFINIÇÃO DE RÓTULOS PARA TIPOS
	Int:	.asciz	"%d"
	Chat:	.asciz	"%c"
	String:	.asciz	"%s"
	lista:		.int	0
	NULL:		.int	0
.section .text
.globl _start

_start:
    call _escolher
_fim:

_escolher:
    #criar um if para cada uma das operacoes do menu
_insertReg:
    #inserir registro 
_removeReg:
    #remover registro
_readReg:
    #ler um registro por nome
_readRelatorio:
    #mostrar todos os registros