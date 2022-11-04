class Agenda
{
    // Lê as linhas do arquivo especificado no caminho.
    public static string[] contatos = File.ReadAllLines(@"C:\Users\Suporte\OneDrive - Fatec Centro Paula Souza\Confidencial\Viotti\N2 - Viotti\contatosTelefone.txt");

    public static string validarCaminhoArquivo()
    {
        // Frescura do C# pro caminho que o user digitar ser lido e não dar erro.
        // Ignorar, por favor.
        Console.Write("Digite o caminho do arquivo: ");
        string path = Console.ReadLine();
        path = path.Replace("\"", "");
        return path.Replace("\\", "/");
    }

    public static void ImportarArquivo(string path)
    {
        if (File.Exists(path)) // Verifica se o caminho que o user digitou existe. 
        {
            contatos = File.ReadAllLines(path); // Lê todas as linhas do arquivo e põe no vetor "contatos".
            Console.WriteLine("Arquivo importado com sucesso!");
        }
        else
            Console.WriteLine("Arquivo não encontrado!");
        Console.WriteLine("\n");
    }

    public static void ExportarArquivo(string path)
    {
        File.Create(path).Close(); // Cria um arquivo no caminho especificado "File.Create(path)" e logo em seguida fecha ele ".Close()".
        foreach (string contato in contatos)
        {
            File.AppendAllText(path, contato + "\n"); // Append (adiciona ao texto já existente) o contato no arquivo.
        }
        Console.WriteLine("Arquivo exportado com sucesso!");
        Console.WriteLine("\n");
    }

    public static int validarOpcao(int min, int max) // Valida se o valor inserido está entre min e max, todos inclusivos ([min, max]).
    {
        do
        {
            Console.Write("Escolha uma opção: ");

            bool ehNumero;
            int opcao;
            ehNumero = int.TryParse(Console.ReadLine(), out opcao); // Essa função tenta transformar uma string em um inteiro.
                                                                    // Se der certo, ela retorna true. Senão, falso.

            if (opcao < min || opcao > max || !ehNumero) // Se o número não estiver entre min e max, ou se ela não for um número.
                Console.WriteLine("Opção inválida!");
            else
                return opcao;
        } while (true); // Loopa para sempre pois caso a opção seja válida, cairá no return opcao do else e sairá da função.
    }

    public static int opcaoArquivo()
    {
        Console.WriteLine("1 - Importar ");
        Console.WriteLine("2 - Exportar ");
        return validarOpcao(1, 2);
    }

    public static string[] CadastroValidadoParaRepeticao()
    {
        string[] contatoInfo;
        bool contatoRepetido;
        do
        {
            contatoRepetido = false;
            contatoInfo = getNovosDados();

            foreach (string contato in contatos)
            {
                string[] contatoSeparado = contato.Split(", ");
                if (contatoSeparado[0] == contatoInfo[0] || contatoSeparado[1] == contatoInfo[1])
                {
                    Console.WriteLine("Nome ou telefone já cadastrado!\n");
                    contatoRepetido = true;
                    break;
                }
            }
        } while (contatoRepetido);
        return contatoInfo;
    }

    public static void CadastrarContato()
    {

        if (contatos.Length >= 100) //Se já tiver 100 ou mais contatos na lista, prof disse que não podia mais cadastrar.
            Console.WriteLine("Limite de cadastro de 100 contatos excedido!");
        else
        {
            string[] dadosNovoContato = CadastroValidadoParaRepeticao(); // Valida que o contato já não existe, e recebe os dados do novo contato.
            List<string> contatosAtualizado = contatos.ToList(); // Cria uma lista com os contatos atuais.

            contatosAtualizado.Add($"{dadosNovoContato[0]}, {dadosNovoContato[1]}"); // Adiciona o novo contato à lista.

            contatos = contatosAtualizado.ToArray(); // Contatos recebe um vetor com o novo contato.
            Console.WriteLine("Contato adicionado com sucesso!");
            Console.WriteLine("\n");
        }
    }

    public static void ExibirOpcoesContato(List<int> indices)
    {
        foreach (int indice in indices)
        {
            Console.WriteLine($"{indice} - {contatos[indice]}"); // Exibe as opções: "1 - Contato Tal".
        }
    }

    public static int EscolherNumero()
    {
        Console.Write("Escolha o número do contato: ");
        return int.Parse(Console.ReadLine());
    }

    public static string[] getNovosDados()
    {
        // Pede pro user os novos dados do contato.
        string[] novosDados = new string[2];
        Console.Write("Digite o nome: ");
        novosDados[0] = Console.ReadLine();
        Console.Write("Digite o telefone: ");
        novosDados[1] = Console.ReadLine();
        return novosDados;
    }

    public static void AlterarContato()
    {
        string nome = getNomeParaPesquisar();
        List<int> indices = Pesquisar(nome); // Lista para os índices dos contatos que a pesquisa retornou.

        if (indices.Count > 0) // Se foi encontrado algum contato.
        {
            ExibirOpcoesContato(indices); // Exibe os contatos que o user pode escolher.

            int indiceAlteracao = EscolherNumero(); // Pega o número que o user escolheu.

            string[] dadosNovos = CadastroValidadoParaRepeticao(); // Essa função pede pro user digitar os dados e vê se eles já existem.
                                                                   // Se sim, pede de novo, senão retorna os novos dados.

            contatos[indiceAlteracao] = $"{dadosNovos[0]}, {dadosNovos[1]}"; // Registra o novo nome e telefone: "{Nome}, {telefone}".
            Console.Write("Contato alterado com sucesso!");
        }
        else
            Console.WriteLine("Contato não encontrado!");
        Console.WriteLine("\n");
    }

    public static void ApagarContatos()
    {
        string nome = getNomeParaPesquisar(); // Pede um nome pro usuário.
        List<int> indices = Pesquisar(nome); // Procura os contatos que batem com o nome e retorna seus índices.

        if (indices.Count > 0) // Se houver algum índice na lista.
        {
            List<string> novosContatos = contatos.ToList(); // Cria uma lista com os contatos atuais.

            ExibirOpcoesContato(indices); // Exibe os contatos que o user pode escolher.

            int indiceRemocao = EscolherNumero(); // Pega o número que o user escolheu.

            novosContatos.Remove($"{contatos[indiceRemocao]}"); // Apaga da nova lista o contato escolhido.

            contatos = novosContatos.ToArray(); // Contatos recebe um novo vetor (ToArray) com o contato apagado.

            Console.WriteLine("Contato removido com sucesso!");
        }
        else
            Console.WriteLine("Contato não encontrado!");
        Console.WriteLine("\n");
    }

    public static void ExibirResultadoDaBusca(List<int> indices)
    {
        if (indices.Count > 0) // Verifica se existem contatos.
        {
            foreach (int indice in indices) // Para cada índice, imprime o contato correspondente a ele.
            {
                Console.WriteLine($"{contatos[indice]}");
            }
        }
        else
            Console.WriteLine("Contato não encontrado!");
        Console.WriteLine("\n");
    }

    public static string getNomeParaPesquisar()
    {
        Console.Write("Digite um nome do contato: ");
        string nome = Console.ReadLine().ToLower().Trim(); // ToLower põe tudo em minúsculo pra não ter diferença.
                                                           // Trim tira os espaços em branco do que o user digitou.
        Console.Clear();
        return nome;
    }

    public static List<int> Pesquisar(string palavra_chave)
    {
        // Essa função ficou complicada. Sinto muito. Não sou responsável por danos morais.

        List<int> resultado = new List<int>(); // Lista para armazenar os índices de onde for encontrado o nome.
        for (int i = 0; i < contatos.Length; i++) // Loopa por todos os contatos.
        {
            string[] Nome_e_Telefone = contatos[i].ToLower().Split(", "); // Esse vetorzinho armazena o nome do contato no índice [0]
                                                                          // e o telefone no índice [1].
                                                                          // A função split(), separa uma string com base no separador especificado.
                                                                          // Usei a vírgula para separar.

            string[] nomes = Nome_e_Telefone[0].Split(" "); // Pega os nomes individuais no nome do contato.
                                                            // Ex.: "Ana Carolina Thomazini" ficaria "Ana", "Carolina", "Thomazini".
                                                            // Isso serve para a pesquisa funcionar melhor, daí ele vê se bate com algum nome individual,
                                                            // e não só o nome inteiro.
            for (int j = 0; j < nomes.Length; j++)
            // Loopa pela quantidade de nomes separados.
            {
                if (nomes[j] == palavra_chave) // Se algum desses nomes separados for igual à palavra chave,
                    resultado.Add(i);          // adiciona o índice desse contato à lista.
            }
            // Verifica se o nome ou o telefone é igual à palavra chave.
            if (Nome_e_Telefone[0] == palavra_chave || Nome_e_Telefone[1] == palavra_chave)
                resultado.Add(i);
        }
        return resultado; // Retorna os índices encontrados.
    }

    public static void ListarAlfabetico()
    {
        List<string> contatosOrdenados = contatos.ToList(); // Cria uma lista com todos os contatos.
        contatosOrdenados.Sort(); // Ordena os contatos por ordem alfabética.
        foreach (string contato in contatosOrdenados)
        {
            Console.WriteLine(contato); // Imprime em ordem alfabética.
        }
        Console.WriteLine("\n");
    }

    public static void ListarPorLetra()
    {
        string letra;
        bool ehNumero = false;
        do
        {
            Console.Write("Digite a letra: ");
            letra = Console.ReadLine().ToUpper(); // ToUpper pois daí não diferencia minúscula de maiúscula na hora de pesquisar.
            ehNumero = double.TryParse(letra, out _); // Vê se a "letra" na verdade é um número.

            if (letra.Length > 1 || ehNumero) // Se o tamanho da "letra" for maior que 1 ou se for um número, ela é inválida.
                Console.WriteLine("Letra inválida!");
        } while (letra.Length > 1 || ehNumero);
        Console.Clear();
        for (int i = 0; i < contatos.Length; i++) // Imprime todos os contatos que começam pela letra.
        {
            if (contatos[i].StartsWith(letra)) // Se um certo contato começar pela letra, exibe ele.
                Console.WriteLine($"{contatos[i]}");
        }
        Console.WriteLine("\n");
    }

    public static void ListarNormal()
    // Lista os contatos normalmente, na ordem em que estão no arquivo.
    {
        int max; // Serve para delimitar o máximo de contatos a ser exibido.

        if (contatos.Length > 20) // Verifica se existem mais que 20 contatos.
            max = 20; // Se sim, serão exibidos no máximo 20 contatos.
        else
            max = contatos.Length; // Senão, pode exibir todos os contatos.

        for (int i = 0; i < max; i++) // Exibe todos os contatos até o máximo definido.
        {
            Console.WriteLine(contatos[i]);
        }
        Console.WriteLine("\n");
    }

    public static int MenuListar()
    // Chama o menu com as opções adicionais e retorna a opção escolhida.
    {
        Console.Write("Deseja exibir os contados em ordem alfabética (s/n)? ");
        string ordenado = Console.ReadLine().ToLower();
        if (ordenado == "s")
        {
            return 2; // Números arbitrários pra representar as opções.
        }
        else
        {
            Console.Write("Deseja exibir somente os contatos que começam por uma letra (s/n)? ");
            string filtroPorLetra = Console.ReadLine().ToLower();
            if (filtroPorLetra == "s")
                return 1;
            return 0;
        }
    }

    public static int Menu()
    {
        Console.WriteLine("1 - Listar nome e telefone");
        Console.WriteLine("2 - Pesquisar contato por nome");
        Console.WriteLine("3 - Apagar um contato");
        Console.WriteLine("4 - Alterar um contato");
        Console.WriteLine("5 - Cadastrar um contato");
        Console.WriteLine("6 - Importar ou exportar contatos");
        return validarOpcao(1, 6); // Chama uma função para validar a escolha do usuário e retorna a escolha validada.
    }

    static void Main()
    {
        while (true) // While true pois o programa roda para sempre.
        {
            int opcaoMenu = Menu(); // Chama o menu e armazena a opção escolhida na váriavel.
            Console.Clear(); // Limpa o console.

            if (opcaoMenu == 1)
            {
                int opcaoListar = MenuListar(); // Chama o menu com as opções adicionais e armazena a opção escolhida na váriavel.
                Console.Clear();

                if (opcaoListar == 0)
                    ListarNormal(); // Lista 20 contatos na ordem em que estão no arquivo.
                else if (opcaoListar == 1)
                    ListarPorLetra(); // Lista somente os contatos que começam com uma letra.
                else
                    ListarAlfabetico(); // Lista em ordem alfabética.
            }
            else if (opcaoMenu == 2)
            {
                string nome = getNomeParaPesquisar(); // Pega o nome para pesquisar e armazena em uma variável.
                List<int> indices = Pesquisar(nome); // Pesquisa os contatos que correspondem ao nome e retorna uma lista com os índices deles.
                ExibirResultadoDaBusca(indices); // Imprime os contatos encontrados.
            }
            else if (opcaoMenu == 3)
                ApagarContatos();
            else if (opcaoMenu == 4)
                AlterarContato();
            else if (opcaoMenu == 5)
                CadastrarContato();
            else
            {
                int opcao = opcaoArquivo(); // Pergunta se é para importar ou exportar.
                string path = validarCaminhoArquivo(); // Pega o caminho do arquivo.
                if (opcao == 1)
                    ImportarArquivo(path); // Importa o arquivo de acordo com o caminho.
                else
                    ExportarArquivo(path); // Exporta o arquivo de acordo com o caminho.
            }
        }
    }
}