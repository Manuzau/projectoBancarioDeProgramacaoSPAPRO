
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

	inteiro tamanho <- 0, maisClientes <- 5

	
// ------------------   Modulos para o ficheiro ---------------------- //
	funcao fficheiro criarFicheiro()	
		fficheiro ficheiro
		literal caminho <- "E:\\Ambiente de trabalho\\classDocs\\2 ano\\Programação 1\\projecto de programaçao\\BD.txt"
		logico ficheiroExiste <- fExiste(caminho)
			se nao ficheiroExiste entao
				fcriar(caminho)
			fimse
		fAbrir(ficheiro , caminho, FALSO)
		retorne ficheiro
	fimFuncao

	//	Esta funcao conta o numero de linhas do meu ficheiro
	procedimento contarLinhas(fficheiro file) 
		enquanto ftemlinha(file) faca
	       fLerLinha(file)
	       tamanho <- tamanho + 1
		fimenquanto
		 ffechar(file)
	fimProcedimento
	
	// Esta funcao retorna um vector de 
	funcao pessoa[] lerFicheiro(fficheiro file)
		inteiro i

		contarLinhas(file)

		// Abrindo novamente o ficheiro
		file <- criarFicheiro()
		
		Pessoa clienteNoFicheiro[tamanho + maisClientes]
			
		enquanto ftemlinha(file) faca 
	     literal content <-  fLerLinha(file)
	     literal data[] <- strRepartir(content, ",")
	      
	      para i de 0 ate atamanho(data,0)
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
		fescrever (file, p.nome+","+p.bi+","+p.nif+"\n")
		ffechar(file)
	fimprocedimento

//**--------------------------------------------------------------------------------------------------

// ----------- Modulo para cadastrar cliente -----------------  //
	Pessoa clientes[] <- lerFicheiro(criarFicheiro())

	
 	funcao logico cadastrarCliente(Pessoa p)
 		inteiro posicao
 		se tamanho >= maisClientes entao 
			posicao <- tamanho + 1
 		senao
			posicao <- maisClientes-tamanho
 		fimse
 		
		se tamanho = (atamanho(clientes,0)-1) entao
			mostre "Sem espaco"
		senao
			clientes[posicao] <- p
			salvarNoFicheiro(p)
			tamanho <- tamanho + 1
		fimse
		retorne verdadeiro
	fimFuncao 

	
// ------------------  INICIO ---------------------- //
inicio
	faca 
	pessoa p 
	mostre "Informe o nome: "
 	receba p.nome
 	mostre "Informe o bi: "
 	receba p.bi
 	mostre "Informe o nif: "
 	receba p.nif
	cadastrarCliente(p)
	mostre tamanho,"\n"
	mostre atamanho(clientes, 0),"\n\n"
	enquanto tamanho <> (atamanho(clientes,0)-1) 
 
	/* Pessoa lukau
	fficheiro ficheiro <- criarFicheiro() 
		
		lukau.codigo <- "001"
		lukau.nome <- "Lukau Garcia"
		lukau.telefone <- 932403897
		lukau.bi <- "kjdsakjsjdsa"

		literal telefone <- strIntParaStr(lukau.telefone)
	
		fescrever(ficheiro,  lukau.nome + "," + lukau.bi + "," +  telefone + "\n" )
	lerficheiro(ficheiro)
	// Pessoa clientes[contlinha+10]
	//mostre contlinha
	*/
fimalgoritmo