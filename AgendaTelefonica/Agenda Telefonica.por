programa
{
	//inclusão de bibliotecas
	inclua biblioteca Arquivos --> a
	inclua biblioteca Texto --> txt
	inclua biblioteca Tipos --> tipos

	//inclusão de variáveis globais
	cadeia contatos[100][2]
	inteiro qtdeContatos = 0
	logico continuarNoPrograma = verdadeiro
	cadeia caminhoArquivo = "./contatosTelefone.txt"


	funcao inicio ()
	{
		carregarContatos()
		mostrarEquipe()
		faca
		{
			executarAgenda()
			aguardarParaContinuarPrograma()
		} enquanto (continuarNoPrograma)
	}




	//Funções para carregar contatos
	funcao carregarContatos ()
	{
		inteiro arquivo = a.abrir_arquivo(caminhoArquivo, a.MODO_LEITURA)

		qtdeContatos = 0
		inserirContatosNaMatriz(arquivo)
		
		a.fechar_arquivo(arquivo)
	}

	funcao extrairContatoDaLinha(cadeia linha)
	{
		inteiro indiceParaSeparar = txt.posicao_texto(", ", linha, 0)
		contatos[qtdeContatos][0] = txt.extrair_subtexto(linha, 0, indiceParaSeparar)
		contatos[qtdeContatos][1] = txt.extrair_subtexto(linha, indiceParaSeparar + 2, txt.numero_caracteres(linha))
	}

	funcao inserirContatosNaMatriz(inteiro arquivo)
	{
		cadeia linha = a.ler_linha(arquivo)
		se (linha != "")
		{
			extrairContatoDaLinha(linha)
			qtdeContatos++
			inserirContatosNaMatriz(arquivo)
		}
		retorne
	}



	
	//Funções principais

	funcao mostrarEquipe ()
	{
		cadeia temp
		escreva("\nJoão Vitor Ferreira Pereira, RA: 1680482222040")
		escreva("\nAna Carolyny Thomazini de Andrade, RA: 16804822222023")
		escreva("\nKauan Martins Borges, RA: 1680482222019")
		escreva("\n=============================")
		escreva("\nTecle 'enter' para iniciar a agenda. ")
		leia(temp)
	}

	
	funcao executarAgenda()
	{
		limpa()
		mostrarMenu()
		caracter opcaoEscolhida = getOpcaoMenu()
		limpa()
		executarOpcaoMenu(opcaoEscolhida)	
	}


	funcao mostrarMenu ()
	{
		escreva("\n███╗   ███╗███████╗███╗   ██╗██╗   ██╗")
		escreva("\n████╗ ████║██╔════╝████╗  ██║██║   ██║")
		escreva("\n██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║")
		escreva("\n██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║")
		escreva("\n██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝")
		escreva("\n╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝")
		escreva("\n=====================================")
		escreva("\n1 - Listar nome e telefone. ")
		escreva("\n2 - Pesquisar contato por nome. ")
		escreva("\n3 - Apagar um contato. ")
		escreva("\n4 - Alterar um contato. ")
		escreva("\n5 - Cadastrar um contato. ")
		escreva("\n6 - Importar ou exportar contatos. ")
		escreva("\n0 - Salvar e sair. ")
		escreva("\n=====================================")
	}
	

	funcao aguardarParaContinuarPrograma()
	{
		cadeia temp
		se (continuarNoPrograma == verdadeiro)
		{
			escreva("\nTecle 'enter' para voltar ao menu.")
			leia(temp)
		}
	}


	funcao caracter getOpcaoMenu ()
	{
		cadeia opcao
		escreva("\nDigite uma opção: ")
		leia(opcao)
		se (validarStringEntreMinMax(opcao, '0', '6'))
			retorne tipos.cadeia_para_caracter(opcao)
		limpa()
		mostrarMenu()
		escreva("\nOpção inválida!")
		retorne getOpcaoMenu()	
	}


	funcao executarOpcaoMenu (caracter opcaoEscolhida)
	{
		escolha (opcaoEscolhida)
		{
			caso '0':
				opcaoSair()
				pare
			caso '1':
				opcaoListar()
				pare
			caso '2':
				opcaoPesquisar()
				pare
			caso '3':
				opcaoApagarContatos()
				pare
			caso '4':
				opcaoAlterarContato() 
				pare
			caso '5':
				opcaoAdicionarContato() 
				pare
			caso '6':
				opcaoImportarExportar() 
		}
	}





	//Funções para Listar
	
	funcao opcaoListar()
	{
		mostrarOpcoesDeListagem()
		caracter opcao = validarOpcaoListagem()
		limpa()
		mostrarLogoContatos()
		executarOpcaoListagem(opcao)
	}


	funcao mostrarOpcoesDeListagem()
	{
		escreva("\n1 - Listar os nomes por ordem alfabética")
		escreva("\n2 - Exibir os contatos que começam por uma letra")
		escreva("\n3 - Listar os contatos normalmente")
		escreva("\n---------------------------------------------------")
	}


	funcao caracter validarOpcaoListagem()
	{
		cadeia letra
		escreva("\nDigite uma opção: ")
		leia(letra)
		se (validarStringEntreMinMax(letra, '1', '3'))
			retorne tipos.cadeia_para_caracter(letra)
		limpa()
		mostrarOpcoesDeListagem()
		escreva("\nOpção inválida!")
		retorne validarOpcaoListagem()	
	}


	funcao mostrarLogoContatos ()
	{
		escreva("\n ██████╗ ██████╗ ███╗   ██╗████████╗ █████╗ ████████╗ ██████╗ ███████╗")
		escreva("\n██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗╚══██╔══╝██╔═══██╗██╔════╝")
		escreva("\n██║     ██║   ██║██╔██╗ ██║   ██║   ███████║   ██║   ██║   ██║███████╗")
		escreva("\n██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║")
		escreva("\n╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║")
		escreva("\n ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝")
		escreva("\n")
		escreva("\n----------------------------------------------------------------------\n\n")
	}


	funcao executarOpcaoListagem(caracter opcao)
	{
		escolha (opcao)
		{
			caso '3':
				listarContatosNormalmente()
				pare
			caso '2':
				listarContatosPorLetra ()
				pare
			caso '1':
				listarContatosPorOrdemAlfabetica ()
				pare
		}
	}








	//Funções para Listar normalmente

	funcao listarContatosNormalmente ()
	{
		inteiro indiceDoContato = 0
		enquanto (indiceDoContato < qtdeContatos)
		{
			se (contatos[indiceDoContato][0] != "")
				escreva(retornarContatoOrganizado(indiceDoContato, contatos, falso))
			indiceDoContato++
		}
	}





	//Funções para listar por letra
	funcao listarContatosPorLetra ()
	{
		caracter letra = getLetraParaListar()
		limpa()
		mostrarLogoContatos()
		
		inteiro indicesEncontrados[100]
		inteiro numContatosEncontrados = retornarIndicesEncontradosPorLetra(letra, indicesEncontrados)	
		mostrarContatosEncontrados(numContatosEncontrados, indicesEncontrados, falso)
	}


	funcao caracter getLetraParaListar()
	{
		cadeia letra
		escreva("\nDigite uma letra: ")
		leia(letra)
		se (validarStringEntreMinMax(letra, 'a', 'z'))
			retorne tipos.cadeia_para_caracter(letra)
		limpa()
		mostrarLogoContatos()
		escreva("\nLetra inválida!")
		retorne getLetraParaListar()
	}






	//Funções para listar por ordem alfabética
	funcao listarContatosPorOrdemAlfabetica ()
	{
		cadeia contatosTemp[100][2]
		carregarContatosNaMatrizTemp(contatosTemp)
		ordenarContatos(contatosTemp)
		mostrarContatosOrdemAlfabetica(contatosTemp)
	}

	funcao carregarContatosNaMatrizTemp(cadeia contatosTemp[][])
	{
		para (inteiro linha = 0; linha < qtdeContatos; linha++)
		{
			para (inteiro coluna = 0; coluna < 2; coluna++)
			{
				contatosTemp[linha][coluna] = contatos[linha][coluna]	
			}
		}
	}

	funcao ordenarContatos(cadeia contatosTemp[][])
	{
		para (inteiro i = 0; i < qtdeContatos; i++)
		{
			para (inteiro linha = 0; linha < qtdeContatos - 1; linha++)
			{
				cadeia nomeContato1 = contatosTemp[linha][0]
				cadeia nomeContato2 = contatosTemp[linha + 1][0]
				
				inteiro resultado = compararContatos(nomeContato1, nomeContato2)

				se (resultado == 1)
					trocaContato(linha, contatosTemp)
			}
		}	
	}
	
	funcao inteiro compararContatos(cadeia nome1, cadeia nome2)
	{
		inteiro tamanhoMenorNome = retornarTamanhoMenorNome(nome1, nome2)
		
		para (inteiro indiceDaLetra = 0; indiceDaLetra < tamanhoMenorNome; indiceDaLetra++)
		{
			caracter letraContato1 = txt.obter_caracter(nome1, indiceDaLetra)
			caracter letraContato2 = txt.obter_caracter(nome2, indiceDaLetra)
			
			letraContato1 = retornarCaracterEmCaixaBaixa(letraContato1)
			letraContato2 = retornarCaracterEmCaixaBaixa(letraContato2)

			se (letraContato1 > letraContato2)
				retorne 1
			senao se (letraContato1 != letraContato2)
				retorne -1
		}
		
		se (txt.numero_caracteres(nome1) > txt.numero_caracteres(nome2))
			retorne 1
		senao
			retorne 0
	}

	funcao trocaContato(inteiro indice, cadeia contatosTemp[][])
	{
		cadeia telefoneContato2 = contatosTemp[indice + 1][1]
		cadeia nomeContato2 = contatosTemp[indice + 1][0]
		
		contatosTemp[indice + 1][0] = contatosTemp[indice][0]
		contatosTemp[indice + 1][1] = contatosTemp[indice][1]

		contatosTemp[indice][0] = nomeContato2
		contatosTemp[indice][1] = telefoneContato2
	}

	funcao inteiro retornarTamanhoMenorNome(cadeia nomeContato1, cadeia nomeContato2)
	{
		inteiro tamanhoPrimeiroNome = txt.numero_caracteres(nomeContato1)
		inteiro tamanhoSegundoNome = txt.numero_caracteres(nomeContato2)
		
		se (tamanhoPrimeiroNome > tamanhoSegundoNome)
			retorne tamanhoSegundoNome
		senao
			retorne tamanhoPrimeiroNome
	}

	funcao mostrarContatosOrdemAlfabetica(cadeia contatosTemp[][])
	{
		para (inteiro i = 0; i < qtdeContatos; i++)
		{
			escreva(retornarContatoOrganizado(i, contatosTemp, falso))
		}
	}





	//Funções para pesquisar
	funcao opcaoPesquisar ()
	{
		cadeia palavraChave = pedirNomeOuNumeroParaPesquisar()
		limpa()
		mostrarLogoPesquisar()

		inteiro indicesEncontrados[100]
		inteiro numContatosEncontrados = retornarIndicesEncontrados(palavraChave, indicesEncontrados)

		mostrarContatosEncontrados(numContatosEncontrados, indicesEncontrados, falso)
	}

	funcao mostrarLogoPesquisar()
	{
		escreva("\n██████╗ ██████╗ ███╗   ██╗████████╗ █████╗ ████████╗ ██████╗ ███████╗    ███████╗███╗   ██╗ ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  █████╗ ██████╗  ██████╗ ███████╗")
		escreva("\n██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗╚══██╔══╝██╔═══██╗██╔════╝    ██╔════╝████╗  ██║██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔════╝")
		escreva("\n██║     ██║   ██║██╔██╗ ██║   ██║   ███████║   ██║   ██║   ██║███████╗    █████╗  ██╔██╗ ██║██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝███████║██║  ██║██║   ██║███████╗")
		escreva("\n██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║    ██╔══╝  ██║╚██╗██║██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██╔══██║██║  ██║██║   ██║╚════██║")
		escreva("\n╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║    ███████╗██║ ╚████║╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║██║  ██║██████╔╝╚██████╔╝███████║")
		escreva("\n------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n")
	}







	//Funções para apagar um contato
     funcao opcaoApagarContatos ()
     {
		cadeia palavraChave = pedirNomeOuNumeroParaPesquisar()
		limpa()
		
		inteiro indicesEncontrados[100]
		inteiro numContatosEncontrados = retornarIndicesEncontrados(palavraChave, indicesEncontrados)
		mostrarContatosEncontrados(numContatosEncontrados, indicesEncontrados, verdadeiro)

		se (numContatosEncontrados > 0)
		{
			inteiro indiceEscolhido = pedirIndice(numContatosEncontrados, indicesEncontrados)

			removerContatoEscolhido(indicesEncontrados, indiceEscolhido)
			limpa()
			escreva("\nContato removido com sucesso! ")
		}
     }

	funcao removerContatoEscolhido(inteiro indicesEncontrados[], inteiro indiceEscolhido)
	{
		inteiro indiceDaRemocao = indicesEncontrados[indiceEscolhido - 1]
		esvaziarContato(indiceDaRemocao)
		moverContatoVazioParaFim(indiceDaRemocao)
		qtdeContatos--
	}

	funcao esvaziarContato(inteiro indiceDaRemocao)
	{
		contatos[indiceDaRemocao][0] = ""
		contatos[indiceDaRemocao][1] = ""
	}

	funcao moverContatoVazioParaFim(inteiro indiceDaRemocao)
	{
		para (inteiro n = indiceDaRemocao; contatos[n + 1][0] != ""; n++)
		{
			cadeia nomeAux = contatos[n][0]
			cadeia telefoneAux = contatos[n][1]

			contatos[n][0] = contatos[n + 1][0]
			contatos[n][1] = contatos[n + 1][1]

			contatos[n + 1][0] = nomeAux
			contatos[n + 1][1] = telefoneAux
		}
	}






	//Funções para alterar um contato
	funcao opcaoAlterarContato()
	{
		cadeia palavraChave = pedirNomeOuNumeroParaPesquisar()
		limpa()
		
		inteiro indicesEncontrados[100]
		inteiro numContatosEncontrados = retornarIndicesEncontrados(palavraChave, indicesEncontrados)
		mostrarContatosEncontrados(numContatosEncontrados, indicesEncontrados, verdadeiro)

		se (numContatosEncontrados > 0)
		{
			inteiro indiceEscolhido = pedirIndice(numContatosEncontrados, indicesEncontrados)
			
			inteiro indiceDoContatoParaAlterar = indicesEncontrados[indiceEscolhido - 1]
	
			limpa()
	
			escreva("\nPressione 'enter' para não mudar nada ou")
			cadeia novoNome = pedirNome()
			cadeia novoTelefone = retornarTelefoneValidado()
	
			alterarContatoPorNomeTelefone(novoNome, novoTelefone, indiceDoContatoParaAlterar)
			limpa()
			escreva("\nContato alterado com sucesso! ")
		}
	}

	funcao alterarContatoPorNomeTelefone (cadeia novoNome, cadeia novoTelefone, inteiro indiceDoContatoParaAlterar)
	{
		se (novoNome == "")
			novoNome = contatos[indiceDoContatoParaAlterar][0]
		se (novoTelefone == "")
			novoTelefone = contatos[indiceDoContatoParaAlterar][1]
		
		contatos[indiceDoContatoParaAlterar][0] = novoNome
		contatos[indiceDoContatoParaAlterar][1] = novoTelefone
	}






     //Funções para cadastrar um contato
	funcao opcaoAdicionarContato()
	{
		se (qtdeContatos == 100)
		{
			escreva("\nNúmero excedido de contatos.")
			retorne // Sai da função.
		}

		cadeia nome = pedirNomeValidado()
		cadeia telefone = retornarTelefoneValidado()

		adicionarContatoEmEspacoVazio(nome, telefone)
		limpa()
		escreva("\nContato adicionado com sucesso! ")
	}

	funcao cadeia pedirNomeValidado()
	{
		cadeia novoNome = pedirNome()
		se (novoNome != "")
			retorne novoNome
		limpa()
		escreva("Nome inválido!")
		retorne pedirNomeValidado()
	}

	funcao adicionarContatoEmEspacoVazio(cadeia nome, cadeia telefone)
	{
		para (inteiro indiceDoContato = 0; indiceDoContato < 100; indiceDoContato++)
		{						
			se (contatos[indiceDoContato][0] == "") 
			{
				contatos[indiceDoContato][0] = nome
				contatos[indiceDoContato][1] = telefone
				qtdeContatos++
				pare
			}
		}
	}






	//Funções para importar ou exportar contatos
	funcao opcaoImportarExportar()
	{		
		cadeia opcao = validarOpcaoImportarExportar()
		limpa()
		se (opcao == "0")
			importarContatos()
		senao
		{
			cadeia endereco = pedirEndereco()
			exportarContatos(endereco)
			limpa()
			escreva("Contatos exportados com sucesso!")
		}
	}

	funcao cadeia validarOpcaoImportarExportar()
	{
		cadeia opcao
		mostrarOpcoesImportarExportar()
		leia(opcao)

		se (validarStringEntreMinMax(opcao, '0', '1'))
			retorne opcao

		limpa()
		escreva("\nOpção Inválida! ")
		retorne validarOpcaoImportarExportar()
	}

	funcao mostrarOpcoesImportarExportar()
	{
		escreva("\n0 - Importar")
		escreva("\n1 - Exportar")
		escreva("\n----------------------")
		escreva("\nEscolha uma opção: ")
	}

	funcao cadeia pedirEndereco()
	{
		cadeia endereco
		escreva("\nDigite o endereço do arquivo: ")
		leia(endereco)

		se (endereco != "")
			retorne endereco
			
		limpa()
		escreva("Endereço inválido!")
		retorne pedirEndereco()
	}
	



	//Funções para importar
	funcao importarContatos ()
	{
		validarEndereco()
		carregarContatos()
		limpa()
		escreva("\nArquivo importado com sucesso!")
	}

	funcao validarEndereco()
	{
		cadeia arquivoTxt[] = {"Arquivos de texto|txt"}
		
		cadeia endereco = a.selecionar_arquivo(arquivoTxt, falso)

		se (endereco == "")
			executarAgenda()
		senao
			caminhoArquivo = endereco
	}






	//Funções para exportar
	funcao exportarContatos (cadeia enderecoArquivo)
	{	
		inteiro arquivo = a.abrir_arquivo(enderecoArquivo, a.MODO_ESCRITA)

		escreverContatosNoArquivo(arquivo)

		a.fechar_arquivo(arquivo)
	}

	funcao escreverContatosNoArquivo(inteiro arquivo)
	{
		para (inteiro i = 0; i < qtdeContatos; i++)
		{
			cadeia linha = contatos[i][0] + ", " + contatos[i][1]
			a.escrever_linha(linha, arquivo)
		}
	}



	//Função para sair
	funcao opcaoSair ()
	{
		continuarNoPrograma = falso
		exportarContatos(caminhoArquivo)
	}




	//Funções de solicitação
	funcao cadeia pedirNome()
	{
		cadeia novoNome
		escreva("\nDigite o nome para o contato: ")
		leia(novoNome)	
		retorne novoNome
	}

	funcao cadeia pedirTelefone()
	{
		cadeia novoTelefone
		escreva("\nDigite o telefone para o contato: ")
		leia(novoTelefone)
		
		cadeia telefoneLimpo = retornarSomenteDigitosDoTelefone(novoTelefone)
		
		inteiro tamanhoTelefone = txt.numero_caracteres(telefoneLimpo)
		se (telefoneLimpo == "")
			retorne ""
			
		se (tamanhoTelefone < 8 ou tamanhoTelefone >= 12)	
			retorne telefoneLimpo
		senao
			retorne inserirMascaraNoTelefone(telefoneLimpo, tamanhoTelefone)
	}

	funcao inteiro pedirIndice(inteiro numContatosEncontrados, inteiro indicesEncontrados[])
	{
		cadeia indiceEscolhido
		escreva("\n----------------------------")
		escreva("\nEscolha um contato: ")
		leia(indiceEscolhido)
		se (validarStringEntreMinMax(indiceEscolhido, '1', tipos.inteiro_para_caracter(numContatosEncontrados)))
			retorne tipos.cadeia_para_inteiro(indiceEscolhido, 10)
		limpa()
		mostrarContatosEncontrados(numContatosEncontrados, indicesEncontrados, verdadeiro)
		escreva("\nÍndice inválido!")
		retorne pedirIndice(numContatosEncontrados, indicesEncontrados)
	}

	funcao cadeia pedirNomeOuNumeroParaPesquisar ()
	{
		cadeia nome
		escreva("\nQual o nome ou número do contato?\n")
		leia(nome)

		se (nome == "")
		{
			limpa()
			retorne pedirNomeOuNumeroParaPesquisar()
		}
		
		retorne limparEspacosInicioFim(txt.caixa_baixa(nome))
	}





	//Funções para validar
	funcao logico ehTelefoneRepetido(cadeia telefone)
	{
		para (inteiro i = 0; i < qtdeContatos; i++)
		{		
			se (contatos[i][1] == telefone)
				retorne verdadeiro
		}
		retorne falso
	}

	funcao logico ehTelefone (cadeia texto)
	{
		caracter char
		para (inteiro i = 0; i < txt.numero_caracteres(texto) - 1; i++)
		{
			char = retornarLetraDaCadeiaEmCaixaBaixa(texto, i)
			
			logico charEhNumero = char >= '0' e char <= '9'
			logico charEhLetra = char >= 'a' e char <= 'z'
			
			se (nao (charEhNumero) e char != ' ' e charEhLetra)
				retorne falso
		}
		retorne verdadeiro
	}

	funcao logico estaEntreMaxMin(cadeia texto, caracter minimo, caracter maximo)
	{
		se (tipos.cadeia_e_caracter(texto))
		{
			caracter textoCaracter = tipos.cadeia_para_caracter(texto)
			se (textoCaracter >= minimo e textoCaracter <= maximo)
				retorne verdadeiro	
		}
		retorne falso
	}

	funcao logico validarStringEntreMinMax (cadeia texto, caracter minimo, caracter maximo)
	{
		se (estaEntreMaxMin(texto, minimo, maximo))
			retorne verdadeiro
		retorne falso
	}





	//Funções para comparação
	funcao inteiro compararPalavraChaveComNomesSeparados(cadeia palavraChave, inteiro indiceDoContato, inteiro indicesEncontrados[], inteiro numContatosEncontrados)
	{
		cadeia nomesSeparados[10]
		inteiro numeroDeNomes = retornarNomeSeparados(indiceDoContato, nomesSeparados)
		se (numeroDeNomes > 1)
		{
			para (inteiro i = 0; i < numeroDeNomes; i++)
			{
				se (nomesSeparados[i] == palavraChave)
				{ 
					indicesEncontrados[numContatosEncontrados] = indiceDoContato
					retorne 1
				}
			}
		}
		retorne 0
	}

	funcao inteiro compararPalavraChaveComNomeInteiro(cadeia palavraChave, inteiro indiceDoContato, inteiro indicesEncontrados[], inteiro numContatosEncontrados)
	{
		se (txt.caixa_baixa(contatos[indiceDoContato][0]) == palavraChave)
		{
			indicesEncontrados[numContatosEncontrados] = indiceDoContato
			retorne 1 // Foi encontrado um contato
		}	
		retorne 0 // Foram encontrados 0 contatos
	}

	funcao inteiro compararPalavraChaveComTelefone(cadeia palavraChave, inteiro indiceDoContato, inteiro indicesEncontrados[], inteiro numContatosEncontrados)
	{
		palavraChave = retornarSomenteDigitosDoTelefone(palavraChave)	
		
		cadeia telefone = retornarSomenteDigitosDoTelefone(contatos[indiceDoContato][1])
		cadeia telefoneSemDDD = txt.extrair_subtexto(telefone, 2, txt.numero_caracteres(telefone))
		
		se (telefoneSemDDD == palavraChave ou telefone == palavraChave)
		{
			indicesEncontrados[numContatosEncontrados] = indiceDoContato
			numContatosEncontrados++
			retorne 1
		}
		retorne 0
	}








	//Funções que retornam algum valor
	funcao cadeia retornarTelefoneValidado()
	{
		cadeia telefone = pedirTelefone()
		se (ehTelefoneRepetido(telefone))
		{
			limpa()
			escreva("Número já cadastrado!")
			retorne retornarTelefoneValidado()
		}
		retorne telefone
	}

	funcao cadeia retornarSomenteDigitosDoTelefone (cadeia texto)
	{
		cadeia caractere
		inteiro i = 0
		enquanto (i < txt.numero_caracteres(texto))
		{
			caractere = txt.extrair_subtexto(texto, i, i + 1)
			se (validarStringEntreMinMax(caractere, '0', '9'))
				i++
			senao
				texto = txt.substituir(texto, caractere, "")
		}
		retorne texto
	}

	funcao inteiro retornarNomeSeparados(inteiro indiceDoContato, cadeia nomesSeparados[])
	{
		cadeia nomeCompleto = txt.caixa_baixa(contatos[indiceDoContato][0])
		inteiro numeroDeNomes = 0	
		para (inteiro posicaoDoEspaco = 0; posicaoDoEspaco != -1; numeroDeNomes++)
		{
			posicaoDoEspaco = txt.posicao_texto(" ", nomeCompleto, 0)
			se (posicaoDoEspaco != -1) // -1 é quando não foi encontrado
			{
				nomesSeparados[numeroDeNomes] = txt.extrair_subtexto(nomeCompleto, 0, posicaoDoEspaco)
				nomeCompleto = txt.extrair_subtexto(nomeCompleto, posicaoDoEspaco + 1, txt.numero_caracteres(nomeCompleto))
			}
			senao
				nomesSeparados[numeroDeNomes] = nomeCompleto
		}	
		retorne numeroDeNomes
	}

	funcao inteiro retornarIndicesEncontrados(cadeia palavraChave, inteiro indicesEncontrados[])
	{
		inteiro numContatosEncontrados = 0
		para (inteiro indiceDoContato = 0; indiceDoContato < qtdeContatos; indiceDoContato++)
		{
			se (ehTelefone(palavraChave))
				numContatosEncontrados += compararPalavraChaveComTelefone(palavraChave, indiceDoContato, indicesEncontrados, numContatosEncontrados)
			senao
			{
				numContatosEncontrados += compararPalavraChaveComNomesSeparados(palavraChave, indiceDoContato, indicesEncontrados, numContatosEncontrados)
				numContatosEncontrados += compararPalavraChaveComNomeInteiro(palavraChave, indiceDoContato, indicesEncontrados, numContatosEncontrados)
			}
		}
		retorne numContatosEncontrados
	}

	funcao cadeia retornarContatoOrganizado(inteiro indiceDoContato, cadeia matrizContatosTemp[][], logico mostrarIndice)
	{
		cadeia linha = matrizContatosTemp[indiceDoContato][0]

		linha += retornarEspacos(indiceDoContato, matrizContatosTemp, mostrarIndice)
		
		linha += matrizContatosTemp[indiceDoContato][1] + "\n"
		
		retorne linha
	}

	funcao cadeia retornarEspacos (inteiro indiceDoContato, cadeia matrizContatosTemp[][], logico mostrarIndice)
	{
		inteiro tamanhoIndice = 0
		se (mostrarIndice)
			tamanhoIndice = 4
		inteiro tamanhoDoTextoEscrito = txt.numero_caracteres(matrizContatosTemp[indiceDoContato][0]) + tamanhoIndice
		
		inteiro numEspacos = 48 - tamanhoDoTextoEscrito

		cadeia linha = ""
		enquanto (numEspacos > 0)
		{
			linha += " "
			numEspacos--	
		} 
		
		retorne linha
	}

	funcao inteiro retornarIndicesEncontradosPorLetra(caracter letra, inteiro indicesEncontrados[])
	{
		inteiro indiceDoContato = 0, numContatosEncontrados = 0 
		
		enquanto (indiceDoContato < qtdeContatos)
		{
			se (retornarQualquerLetraDoNome(indiceDoContato, contatos, 0) == letra)
			{
				indicesEncontrados[numContatosEncontrados] = indiceDoContato
				numContatosEncontrados++
			}
			indiceDoContato++
		}
		retorne numContatosEncontrados
	}

	funcao caracter retornarQualquerLetraDoNome(inteiro indiceDoContato, cadeia contatosTemp[][], inteiro indiceLetra)
	{
		cadeia tempString = txt.extrair_subtexto(contatosTemp[indiceDoContato][0], indiceLetra, indiceLetra + 1)
		tempString = txt.caixa_baixa(tempString)
		retorne tipos.cadeia_para_caracter(tempString)
	}

	funcao caracter retornarLetraDaCadeiaEmCaixaBaixa(cadeia texto, inteiro i)
	{
		texto = txt.extrair_subtexto(texto, i, i + 1)
		texto = txt.caixa_baixa(texto)
		retorne tipos.cadeia_para_caracter(texto)
	}

	funcao caracter retornarCaracterEmCaixaBaixa(caracter letra)
	{
		cadeia letraEmCaixaBaixa = txt.caixa_baixa(tipos.caracter_para_cadeia(letra))
		retorne tipos.cadeia_para_caracter(letraEmCaixaBaixa)
	}

	funcao cadeia tirarEspacosInicio(cadeia texto)
	{
		cadeia subtexto
		faca
		{
			subtexto = txt.extrair_subtexto(texto, 0, 1)
			se (subtexto == " ")
				texto = txt.extrair_subtexto(texto, 1, txt.numero_caracteres(texto))
		} enquanto (subtexto == " ")
		retorne texto
	}

	funcao cadeia tirarEspacosFim(cadeia texto)
	{
		cadeia subtexto
		inteiro tamanhoString = txt.numero_caracteres(texto)
		faca
		{
			subtexto = txt.extrair_subtexto(texto, tamanhoString - 1, tamanhoString)
			se (subtexto == " ")
			{
				texto = txt.extrair_subtexto(texto, 0, tamanhoString - 1)
				tamanhoString = txt.numero_caracteres(texto)
			}	
		} enquanto (subtexto == " ")
		retorne texto
	}
	
	funcao cadeia limparEspacosInicioFim(cadeia texto)
	{		
		texto = tirarEspacosInicio(texto)
		texto = tirarEspacosFim(texto)
		retorne texto
	}

	funcao cadeia inserirMascaraNoTelefone(cadeia telefoneLimpo, inteiro tamanhoTelefone)
	{
		escolha (tamanhoTelefone)
		{
			caso 8:
				cadeia quatroPrimeirosDigitos = txt.extrair_subtexto(telefoneLimpo, 0, 4)
				cadeia quatroUltimosDigitos8 = txt.extrair_subtexto(telefoneLimpo, 4, tamanhoTelefone)
				retorne quatroPrimeirosDigitos + "-" + quatroUltimosDigitos8
			caso 9:
				cadeia cincoPrimeirosDigitos = txt.extrair_subtexto(telefoneLimpo, 0, 5)
				cadeia quatroUltimosDigitos9 = txt.extrair_subtexto(telefoneLimpo, 5, tamanhoTelefone)
				retorne cincoPrimeirosDigitos + "-" + quatroUltimosDigitos9
			caso 10:
				cadeia doisPrimeirosDigitos10 = txt.extrair_subtexto(telefoneLimpo, 0, 2)
				cadeia quatroDoMeio = txt.extrair_subtexto(telefoneLimpo, 2, 6)
				cadeia quatroUltimosDigitos10 = txt.extrair_subtexto(telefoneLimpo, 6, tamanhoTelefone)
				retorne "(" + doisPrimeirosDigitos10 + ")" + " " + quatroDoMeio + "-" + quatroUltimosDigitos10
			caso 11:
				cadeia doisPrimeirosDigitos11 = txt.extrair_subtexto(telefoneLimpo, 0, 2)
				cadeia cincoDoMeio = txt.extrair_subtexto(telefoneLimpo, 2, 7)
				cadeia quatroUltimosDigitos11 = txt.extrair_subtexto(telefoneLimpo, 7, tamanhoTelefone)
				retorne "(" + doisPrimeirosDigitos11 + ")" + " " + cincoDoMeio + "-" + quatroUltimosDigitos11
			caso contrario:
				retorne ""
		}
	}



	




	//função usada em quase todas as funções

	funcao mostrarContatosEncontrados(inteiro numContatosEncontrados, inteiro indicesEncontrados[], logico mostrarIndice)
	{
		se (numContatosEncontrados > 0)
			para (inteiro i = 0; i < numContatosEncontrados; i++)
			{
				se (mostrarIndice)
					escreva(i + 1, " - ")
				escreva(retornarContatoOrganizado(indicesEncontrados[i], contatos, mostrarIndice))
			}
		senao
			escreva("\nNenhum contato encontrado.")
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6832; 
 * @DOBRAMENTO-CODIGO = [29, 46, 63, 75, 85, 105, 116, 130, 163, 173, 182, 196, 209, 234, 250, 262, 281, 289];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */