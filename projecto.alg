
registo PESSOA 
	literal nome
	literal identificacao
	inteiro codigo
	inteiro telefone
fimRegisto


registo CONTA
	inteiro tipo_conta
	inteiro codigo_cliente
	inteiro codigo
	inteiro numero_conta
	inteiro estado
	real saldo
fimRegisto

constante literal caminho <- "C:\\Users\\manue\\OneDrive\\Documentos\\Adobe\\Ambiente de Trabalho\\ISAF\\2 ano\\PROGRAMAÇÃO 1\\Projecto de Programação\\BD.txt"

funcao inteiro contar_linhas_ficheiro() 
	inteiro linha
	fficheiro ficheiro   
			  
	fAbrir(ficheiro, caminho, falso)
	enquanto ftemlinha(ficheiro) faca 
		flerlinha(ficheiro)
	  linha <- linha + 1
	fimenquanto
	ffechar(ficheiro) 
  retorne linha
fimFuncao 
 
inteiro total_linhas <- contar_linhas_ficheiro()  
inteiro total_clientes  
inteiro total_contas 
inteiro i, posicao
		
PESSOA clientes[total_linhas   + 100]
CONTA contas[total_linhas  + 100]

//zau
funcao logico cadastro_cliente (Pessoa p)
		clientes [total_clientes] <- p
		total_clientes <- total_clientes + 1 
	retorne verdadeiro
fimFuncao

//Lucas
funcao inteiro buscar_conta(inteiro identificador)
	inteiro posicao
	para posicao de 0 ate total_contas
		se contas[posicao].numero_conta = identificador ou contas[posicao].codigo_cliente = identificador entao
			retorne posicao
		fimse
	fimPara
	retorne -1	
fimFuncao

funcao inteiro buscar_cliente(inteiro identificador)
		inteiro posicao
	para posicao de 0 ate total_clientes
		se  clientes[posicao].codigo = identificador entao
			retorne posicao
		fimse
	fimPara
	retorne -1	
fimFuncao

//Zau
funcao logico abrir_conta (Pessoa p, inteiro tipo_conta)
		conta c
		c.estado <- 1
		c.codigo_cliente <- p.codigo
		c.codigo <-  total_contas
		c.numero_conta <- 100 + total_contas 
		contas[total_contas] <- c
		total_contas <- total_contas + 1
	retorne verdadeiro
fimfuncao

//Lucas
funcao logico depositar(inteiro numero_conta, real valor)
	i <- buscar_Conta (numero_conta) 

	se i  >= 0  e valor >= 10 entao
		conta c <- contas [i]
		c.saldo <- c.saldo + valor
		retorne verdadeiro
	fimse
	retorne falso
fimfuncao

//Lucas
funcao logico levantar_dinheiro(inteiro numero_conta, real valor)
		 i <- buscar_Conta (numero_conta) 
		 conta c
		se i = -1  entao
			retorne falso
		fimse
		c <- contas [i]
		se  c.saldo < valor e valor >= 1 entao
				retorne falso
		fimse
		c.saldo <- c.saldo - valor 
		retorne verdadeiro 
	fimfuncao

//Lucas
funcao logico transferir_dinheiro(inteiro num_conta_a_enviar, inteiro num_conta_a_receber, real valor)
	inteiro posicao_enviar <-  buscar_Conta (num_conta_a_enviar) 
	inteiro posicao_receber <- buscar_Conta (num_conta_a_receber) 
	
	se posicao_receber >= 0 e  posicao_enviar >= 0 e valor >= 10 entao
		
		conta c_enviar <- contas [posicao_enviar]
		conta c_receber <- contas [posicao_receber]
		se  c_enviar .saldo >= valor entao
				c_enviar.saldo  <- c_enviar.saldo  - valor
				c_receber .saldo <- c_receber.saldo  + valor
		retorne verdadeiro
		fimse
	fimse 
retorne falso
fimFuncao	

funcao real consultar_saldo(inteiro numero_conta)
	inteiro posicao <- buscar_conta(numero_conta)
	se posicao <> -1 entao 
		CONTA c <- contas[posicao]
		retorne c.saldo
	fimse
	retorne -1
fimFuncao

funcao logico actualizar_dados(Pessoa p, inteiro codigo_cliente)
	inteiro posicao <- buscar_cliente(codigo_cliente)
	se posicao <> -1 entao
		p.codigo <- codigo_cliente
		clientes[posicao] <- p
		retorne verdadeiro
	fimse
	retorne falso
fimFuncao

funcao literal retorneLiteral(logico condicao, literal smsTrue, literal smsFalse)
	se condicao entao
		retorne smsTrue
	fimse
retorne smsFalse
fimFuncao



procedimento apresentar_dados_conta(CONTA c)
	mostre "\n\tDADOS DE CONTA************\n"
	mostre "\tNUMERO DE CONTA: " , strIntParaStr(c.numero_conta)
	mostre "\n\tESTADO: " ,  retorneLiteral(c.estado = 1,"Activado","Desativado")
	mostre "\n\tTIPO DE CONTA: " ,   retorneLiteral(c.tipo_conta = 1,"Empresa","Particular")
fimProcedimento

procedimento apresentar_dados_Cliente(PESSOA p, inteiro posicao)
	mostre "CLIENTE Nº: ", (posicao +1)
	mostre "\nCODIGO: ",p.codigo
	mostre "\nNOME: ",p.nome
	mostre "\nIDENTIFICACAO: ", p.identificacao
	mostre "\nTELEFONE: ", p.telefone	
fimProcedimento

//ZAU
procedimento listar_clientes ()
		inteiro contador 
		para contador de 0 ate total_clientes - 1
			PESSOA p <- clientes[contador]
		    inteiro posicao_conta <- buscar_conta(p.codigo)
			
			apresentar_dados_Cliente(p, contador)
			se posicao_conta >= 0  entao
				apresentar_dados_conta(contas[posicao_conta])
			fimse
			ESCREVA "\N______________________________\N"
		fimpara
fimprocedimento 
	
procedimento continuar()
		literal qualquer
		escreva " PRESSIONE QUALQUER TECLA...\n"
		leia qualquer
		limpatela
fimprocedimento


procedimento copia_de_seguranca()
	inteiro indice
	literal dados_conta, dados_cliente
	fficheiro ficheiro  

	se nao fExiste(caminho) entao
		fcriar(caminho)
	fimse
								
	fAbrir(ficheiro , caminho, verdadeiro)
	para indice de 0 ate (total_clientes - 1)
		dados_conta <- ""
		
		PESSOA p <- clientes[indice]
		dados_cliente <- strintparastr(p.codigo)+","+ p.nome+","+ p.identificacao+","+ strIntParaStr(p.telefone)
		fescrever(ficheiro, dados_cliente)
		
		CONTA c <- contas[indice]
	 	se c.estado = 1 entao
		dados_conta <- ","+strIntParaStr(c.codigo)+","+strIntParaStr(c.codigo_cliente)
		dados_conta <- dados_conta +","+strIntParaStr(c.estado)+","+ strTrocar(strRealParaStr(c.saldo),",","")+","+strIntParaStr(c.numero_conta)
		fescrever(ficheiro, dados_conta )
	 	fimse
	 	fescrever(ficheiro, "\n")
	fimpara
	ffechar(ficheiro)
fimprocedimento


procedimento restaurar_copia_seguranca() 
	fficheiro ficheiro    
	se nao fExiste(caminho) entao
		fcriar(caminho)
	fimse			 			
	fAbrir(ficheiro , caminho, falso)
	enquanto ftemlinha(ficheiro) faca 
		literal dados[] <- strRepartir(fLerLinha(ficheiro), ",") 
		PESSOA p
		p.codigo<-  strValorInt (dados[0])
		p.nome <- dados[1]
		p.identificacao <- dados[2]
		p.telefone <- strValorInt(dados[3]) 
		
		clientes[total_clientes] <- p
		total_clientes<- total_clientes + 1
		
 		CONTA c
 		se atamanho(dados, 0) > 4 entao
		c.codigo <- strValorInt (dados[4])
		c.codigo_cliente <-strValorInt (dados[5])
		c.estado<-   strValorInt (dados[6]) 
		c.saldo <- strValorReal( strTrocar(dados[7], "," , "") )
		c.numero_conta<-  strValorInt (dados[8])

		contas[total_contas] <- c
		total_contas <- total_contas + 1 
		fimse
 fimenquanto
ffechar(ficheiro)
fimProcedimento

procedimento sms_resultado(logico condicao)
	se   condicao entao 
		mostre "Operação realizada com suesso\n\n"
		copia_de_seguranca()
	senao
		mostre "Falha na operação\nRepita o processo!\n\n"
	fimse
fimProcedimento

procedimento menu()
	escreva "              MENU                   \n===================================\n"
		escreva "1- Cadastrar Cliente\n"
		escreva "2- Listar Clientes\n"
		escreva "3- Abertura de Conta\n"
		escreva "4- Depositar Dinheiro\n"
		escreva "5- Levantar Dinheiro\n"
		escreva "6- Consultar Saldo\n"
		escreva "7- Transferir Dinheiro\n"
		escreva "8- Actualizar Dados do Cliente\n"
		escreva "9- Terminar\n"
		escreva "==================================\n"
		escreva "\nOpção: "
fimprocedimento

inicio  
	restaurar_copia_seguranca() 
	logico operacao_sucedida
	inteiro tecla, tipoConta, i
 
enquanto tecla <> 9 faca
	
menu()
leia tecla

escolha(tecla)
caso 1: //Modulo cadastrar cliente
    PESSOA cliente
	mostre "Informe o nome: "
	receba cliente.nome
	mostre "Informe a identificacao: "
	receba cliente.identificacao
	mostre "Informe o telefone: "
	receba cliente.telefone
	cliente.codigo <-  parteInteira(aleatorio()*(total_clientes + 159) )
				
  	operacao_sucedida <- cadastro_cliente(cliente)
	limpatela
	sms_resultado(operacao_sucedida)
 
caso 2: //Modulo Listar clientes
	limpatela
	listar_clientes()
						
 caso 3:  //Modulo Abertura de conta
	inteiro identificacao, posicao
	operacao_sucedida <- falso
	
	mostre "Informe a identificacao de cliente: "
	receba identificacao
	posicao <- buscar_cliente(identificacao) 
	se posicao <> -1 entao 
		mostre "Informe o Tipo de Conta\n"
		mostre "0 - Particular\n"
		mostre "1 - Empresa\n"
		mostre "Tipo: "
		leia tipoConta	
		se tipoConta = 0 ou tipoConta = 1 entao
			operacao_sucedida <-  abrir_conta(clientes[posicao], tipoConta)
		senao 
			mostre "Falha no processo, repita a operação!\nPressione qualquer tecla"
		fimSe
	senao
		mostre "Cliente nao encontrado! repita a operação!\nPressione qualquer tecla"
	fimse
	limpaTela
	sms_resultado(operacao_sucedida) 
	
 caso 4: //Modulo Depositar dinheiro
 	operacao_sucedida <- falso
	inteiro numero_conta 
	real valor
					
	mostre "Informe o número de Conta: "
	receba numero_conta 
	mostre "Informe o valor a depositar: "
	receba valor 
	operacao_sucedida <- depositar(numero_conta, valor)
	sms_resultado(operacao_sucedida)
	tpause (3000)
	limpatela
				 
 caso 5: //Modulo Levantar dinheiro
    operacao_sucedida <- falso
	inteiro numero_conta
	real valor
			
	mostre "Informe o número de Conta: "
	receba numero_conta 
	mostre "Informe o valor a levantar: "
	receba valor 
	operacao_sucedida <- levantar_dinheiro(numero_conta, valor) 
	sms_resultado(operacao_sucedida)
	tpause (3000)
	limpatela
	 
 caso 6: //Modulo Consultar dinheiro
    inteiro numero_conta
	operacao_sucedida <- falso
	real saldo
	
	mostre "Informe o número de Conta: "
	receba numero_conta 
	saldo <- consultar_saldo(numero_conta)
	
	limpatela
	se   saldo <> -1 entao
		mostre "Operação realizada com suesso\nSaldo: ", saldo,"\n\n"
	senao
		mostre "Falha na operação\nRepita o processo!"
	fimse
	 
 caso 7: //Modulo transferir  dinheiro
 	operacao_sucedida <- falso
	inteiro conta_enviar, conta_receber
	real valor
					
	mostre "Informe o numero de conta a enviar: "
		leia conta_enviar
	mostre "Informe o numero de conta a receber: "
		leia conta_receber
	mostre "Informe o valor: "
		leia valor
	operacao_sucedida  <- transferir_dinheiro(conta_enviar, conta_receber, valor)
	limpatela
	sms_resultado(operacao_sucedida)	
	 	 	
 caso 8: //Modulo actualizar Dados do cliente
 	Pessoa cliente_actualizado
	operacao_sucedida <- falso
	inteiro codigo_cliente

	mostre  "Informe o codigo: "
		receba codigo_cliente
	mostre "Informe o nome: "
		receba cliente_actualizado.nome
	mostre  "Informe a identificacao: "
		receba cliente_actualizado.identificacao
	mostre  "Informe o telefone: "
		receba cliente_actualizado.telefone
	operacao_sucedida <-  actualizar_dados(cliente_actualizado, codigo_cliente)   
	limpatela
	sms_resultado(operacao_sucedida)
 
  fimescolha
 fimenquanto
fimAlgoritmo