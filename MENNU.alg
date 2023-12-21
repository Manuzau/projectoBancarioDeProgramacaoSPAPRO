



// Registos 
 /*
registo Conta 
	literal numeroConta, codigoCliente
	inteiro tipoConta
	logico estado
fimregisto 

registo Pessoa
	literal codigo, nome, bi, nif
	inteiro telefone
	Conta contaCliente
fimregisto

	
	
	//	Modelo cadastrar Cliente 
	
	
	
	 funcao logico cadastrarCliente(Pessoa p)	 
			clientes[quantidade] <- p		
			quantidade <- quantidade + 1		
			retorne verdadeiro
	fimFuncao 
	*/


	
registo Conta 
	literal numeroConta, codigoCliente
	inteiro tipoConta
	logico estado
fimregisto 

registo Pessoa
	literal codigo, nome, bi, nif
	inteiro telefone
	Conta contaCliente
fimregisto


	inteiro tamanhoClienteNoFicheiro <- 0, espacoClienteNoArray <- 3
	
// ------------------   Modulos para o ficheiro ---------------------- //
	funcao fficheiro criarFicheiro()	
		fficheiro ficheiro
		literal caminho <- "E:\\Ambiente de trabalho\\classDocs\\2 ano\\Programação 1\\projecto de programaçao\\projectoexe\\BD.txt"
		logico ficheiroExiste <- fExiste(caminho)
			se nao ficheiroExiste entao
				fcriar(caminho)
			fimse
		fAbrir(ficheiro , caminho, FALSO)
		retorne ficheiro
	fimFuncao

	//	Este procedimento conta o numero de linhas do meu ficheiro
	procedimento contarLinhas(fficheiro file) 
		// A variavel tamanho diz o numero de clientes que estao no meu ficheiro
		enquanto ftemlinha(file) faca
	       fLerLinha(file)
	       tamanhoClienteNoFicheiro <- tamanhoClienteNoFicheiro + 1
		fimenquanto
		 ffechar(file)
	fimProcedimento

	
	// Esta funcao retorna um vector com todos os dados no ficheiro
	funcao pessoa[] lerFicheiro(fficheiro file)
		inteiro i

		contarLinhas(file)

		// Abrindo novamente o ficheiro
		file <- criarFicheiro()
		
		Pessoa clienteNoFicheiro[tamanhoClienteNoFicheiro + espacoClienteNoArray]
			
		enquanto ftemlinha(file) faca 
	     literal content <-  fLerLinha(file)
	     literal data[] <- strRepartir(content, ",")
	      
	      para i de 0 ate atamanho(data, 0)
			clienteNoFicheiro[i].nome <- data[0]
			clienteNoFicheiro[i].bi <- data[1]
			clienteNoFicheiro[i].nif <-  data[2]
	      fimpara

		fimenquanto
		ffechar(file)
		
		retorne clienteNoFicheiro
	fimFuncao

	procedimento salvarNoFicheiro(Pessoa p)
		fficheiro file <- criarFicheiro()	
			fescrever (file, p.nome+","+ p.bi+","+ p.nif +"\n")
		ffechar(file)
	fimprocedimento
	
//**--------------------------FINAL DOS MODELOS DO FICHEIRO ------------------------------------------------------------------------



	Pessoa clientes[] <- lerFicheiro(criarFicheiro())

// ----------- Modulo para cadastrar cliente -----------------  //

	
 	funcao logico cadastrarCliente(Pessoa p)
 		// Esta variavel nos permite achar a posicao do cliente a ser cadastrado
 		inteiro posicaoNoArray
 		logico clienteCadastrado
 		
 		se tamanhoClienteNoFicheiro >= espacoClienteNoArray entao 
 			// Isto nos permite registrar os clientes na linha a seguir dos que ja se encontram no ficheiro
			posicaoNoArray <- tamanhoClienteNoFicheiro + 1
 		senao
			posicaoNoArray <- tamanhoClienteNoFicheiro
		
 		fimse
 		
		se tamanhoClienteNoFicheiro = (atamanho(clientes,0)-1) entao
			mostre "Sem espaco\n"
			clienteCadastrado <- falso
		senao
			clientes[posicaoNoArray] <- p
			salvarNoFicheiro(p)
			tamanhoClienteNoFicheiro <- tamanhoClienteNoFicheiro + 1
			clienteCadastrado <- verdadeiro
		fimse
		
		retorne clienteCadastrado
	fimFuncao 

	
	// Modelo Abertura de Conta
	funcao logico abrirConta(Pessoa p, inteiro tipoConta)
	//1 com base no codigo encontrar o cliente
	//2 procurar no meu vector um cliente onde o seu codigo seja igual ao ID informado
		
		conta contaCliente
		
		contaCliente.codigoCliente <- p.codigo
		contaCliente.estado <- verdadeiro
		contaCliente.tipoConta <- tipoConta 

	 	//	Para cliente particular
		se contaCliente.tipoConta  = 0 entao 
			contaCliente.numeroConta <- "2000" + p.codigo
		senao
		
		//Para cliente Empresa
			se contaCliente.tipoConta  = 1 entao 
				contaCliente.numeroConta <- "1000" + p.codigo
			fimse
		fimse
		
		inteiro i <- 0 
		
		repita 
			se clientes[i].codigo = p.codigo entao  
  				clientes[i].contaCliente <- contaCliente
			fimse
			i <- i + 1
		ate i = tamanhoClienteNoFicheiro
		
		retorne verdadeiro 
	fimFuncao

//-------------------------------------------------------------------------

inicio

	inteiro tecla, tipo
	Pessoa cliente

	enquanto tecla <> 9 faca
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
		
		
		leia tecla

		escolha(tecla)
		caso 1:  					//Modulo cadastrar cliente
			mostre "Digite o nome: "
			receba cliente.nome
			mostre "Digite o Bi/Nif: "
			receba cliente.bi
			mostre "Digite o telefone: "
			receba cliente.telefone
			cliente.nif <- cliente.bi
			cliente.codigo <- strIntParaStr(tamanhoClienteNoFicheiro)
		
			limpatela
			mostre cadastrarCliente(cliente)
			
		caso 2:   					//Modulo Listar clientes
			mostre "Operacao 2\n\n"
		caso 3:						//Modulo Abertura de conta
			mostre "Informe o Tipo de Conta"
			leia tipo
			mostre "O estado: ", cliente.contaCliente.estado,"\n"
			mostre "O numero de Conta: ", cliente.contaCliente.numeroConta,"\n"	
			mostre "O tipo de Conta: ", cliente.contaCliente.tipoConta, "\n\n"
			mostre "conta aberta: ", abrirConta(cliente, tipo)
		
		caso 4:						//Modulo Depositar dinheiro
			mostre "Operacao 4\n\n"
		caso 5:						//Modulo Levantar dinheiro
			mostre "Operacao 5"
		caso 6:						//Modulo Consultar dinheiro
			mostre "Operacao 6"
		caso 7:						//Modulo Transferir dinheiro
			mostre "Operacao 7"
		caso 8:						//Modulo Actualizar Dados do cliente
			mostre "Operacao 8"
		caso 9:						//TERMINAR
			
		defeito:
			limpatela
			
		fimescolha
	fimenquanto

fimalgoritmo