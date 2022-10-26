using System.IO;

namespace Default
{
    class Default
    {
        public static string[] contatos = File.ReadAllLines(@"C:\Users\Suporte\OneDrive - Fatec Centro Paula Souza\Documents\Viotti-ALP\N2 - Viotti\contatosTelefone.txt");

        #region Declaracao de funções auxiliares

        public static string validarCaminhoArquivo()
        {
            Console.Write("Digite o caminho do arquivo: ");
            string path = Console.ReadLine();
            path = path.Replace("\"", "");
            return path.Replace("\\", "/");
        }

        public static void ImportarArquivo(string path)
        {
            if (File.Exists(path))
            {
                contatos = File.ReadAllLines(path);
                Console.WriteLine("Arquivo importado com sucesso!");
            }
            else
                Console.WriteLine("Arquivo não encontrado!");
            Console.WriteLine("\n");
        }

        public static void ExportarArquivo(string path)
        {
            File.Create(path).Close();
            foreach (string contato in contatos)
            {
                File.AppendAllText(path, contato + "\n");
            }
            Console.WriteLine("Arquivo exportado com sucesso!");
            Console.WriteLine("\n");
        }

        public static int validarOpcao(int min, int max) // Valida se o valor inserido está entre min e max, todos inclusivos ([min, max]).
        {
            do
            {
                Console.Write("Escolha uma opção: ");
                try
                {
                    int opcao = int.Parse(Console.ReadLine());
                    if (opcao < min || opcao > max)
                        Console.WriteLine("Opção inválida!");
                    else
                        return opcao;
                }
                catch
                {
                    Console.WriteLine("Opção inválida!");
                }
            } while (true);
        }

        public static int opcaoArquivo()
        {
            Console.WriteLine("1 - Importar ");
            Console.WriteLine("2 - Exportar ");
            return validarOpcao(1, 2);
        }

        public static void CadastrarContato()
        {
            string[] contatoInfo = getContatoInfo();
            List<string> contatosList = contatos.ToList();
            contatosList.Add($"{contatoInfo[0]}, {contatoInfo[1]}");
            contatos = contatosList.ToArray();
            Console.WriteLine("Contato adicionado com sucesso!");
            Console.WriteLine("\n");
        }

        public static void ImprimirOpcoesBusca(List<int> indices)
        {
            foreach (int indice in indices)
            {
                Console.WriteLine($"{indice} - {contatos[indice]}");
            }
        }

        public static int EscolherNumero()
        {
            Console.Write("Escolha o número do contato a ser alterado: ");
            return int.Parse(Console.ReadLine());
        }

        public static string[] getContatoInfo()
        {
            string[] contatoInfo = new string[2];
            Console.Write("Digite o nome: ");
            contatoInfo[0] = Console.ReadLine();
            Console.Write("Digite o telefone: ");
            contatoInfo[1] = Console.ReadLine();
            return contatoInfo;
        }

        public static void AlterarContato()
        {
            string nome = GetNameToSearch();
            List<int> indices = Pesquisar(nome);
            
            if (indices.Count > 0)
            {
                ImprimirOpcoesBusca(indices);

                int indiceAlteracao = EscolherNumero();

                string[] contatoInfo = getContatoInfo();

                contatos[indiceAlteracao] = $"{contatoInfo[0]}, {contatoInfo[1]}";
                Console.Write("Contato alterado com sucesso!");
            }
            else
                Console.WriteLine("Contato não encontrado!");
            Console.WriteLine("\n");
        }

        public static void ApagarContatos()
        {
            string nome = GetNameToSearch();
            List<int> indices = Pesquisar(nome); // Procura os índices do nome.

            if (indices.Count > 0)
            {
                List<string> novosContatos = contatos.ToList();

                ImprimirOpcoesBusca(indices);

                int indiceRemocao = EscolherNumero();

                novosContatos.Remove($"{contatos[indiceRemocao]}"); // Apaga da nova lista o contato escolhido.

                contatos = novosContatos.ToArray();

                Console.WriteLine("Contato removido com sucesso!");
            }
            else
                Console.WriteLine("Contato não encontrado!");
            Console.WriteLine("\n");
        }

        public static void ImprimirResultadoBusca(List<int> indices)
        {
            if (indices.Count > 0)
                foreach (int indice in indices)
                {
                    Console.WriteLine($"{contatos[indice]}");
                }
            else
                Console.WriteLine("Contato não encontrado!");
            Console.WriteLine("\n");

        }

        public static string GetNameToSearch()
        {
            Console.Write("Digite um nome do contato: ");
            string nome = Console.ReadLine().ToLower();
            Console.Clear();
            return nome;
        }

        public static List<int> Pesquisar(string pesquisa)
        {
            List<int> resultado = new List<int>(); // Lista para armazenar os índices de onde for encontrado a string.
            for (int i = 0; i < contatos.GetLength(0); i++)
            {
                string[] contatoSeparado = contatos[i].ToLower().Split(", ");
                string[] nomes = contatoSeparado[0].Split(" ");
                for (int j = 0; j < nomes.Length; j++)
                {
                    if (nomes[j] == pesquisa)
                        resultado.Add(i);
                }
                if (contatoSeparado[0] == pesquisa || contatoSeparado[1].Contains(pesquisa))
                    resultado.Add(i);
            }
            return resultado;
        }

        public static void ListarAlfabetico()
        {
            List<string> contatosOrdenados = new List<string>();
            foreach (string linha in contatos)
            {
                contatosOrdenados.Add(linha);
            }
            contatosOrdenados.Sort();
            foreach (string contato in contatosOrdenados)
            {
                Console.WriteLine(contato);
            }
            Console.WriteLine("\n");
        }

        public static void ListarPorLetra()
        {
            string letra;
            do
            {
                Console.Write("Digite a letra: ");
                letra = Console.ReadLine().ToUpper();
                if (letra.Length > 1)
                    Console.WriteLine("Letra inválida!");
            } while (letra.Length > 1);
            Console.Clear();
            for (int i = 0; i < contatos.Length; i++)
            {
                if (contatos[i].StartsWith(letra))
                    Console.WriteLine($"{contatos[i]}");
            }
            Console.WriteLine("\n");
        }

        public static void ListarNormal()
        {
            for (int i = 0; i < 20; i++)
            {
                try
                {
                    Console.WriteLine(contatos[i]);
                }
                catch (IndexOutOfRangeException)
                {
                    break;
                }
            }
            Console.WriteLine("\n");
        }

        public static int MenuListar()
        {
            Console.Write("Deseja exibir os contados em ordem alfabética (s/n)? ");
            string ordenado = Console.ReadLine().ToLower();
            if (ordenado == "s")
            {
                return 2;
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


        #endregion

        public static int Menu()
        {
            Console.WriteLine("1 - Listar nome e telefone");
            Console.WriteLine("2 - Pesquisar contato por nome");
            Console.WriteLine("3 - Apagar um contato");
            Console.WriteLine("4 - Alterar um contato");
            Console.WriteLine("5 - Cadastrar um contato");
            Console.WriteLine("6 - Importar ou exportar contatos");
            return validarOpcao(1, 6);
        }


        #region Programa Principal

        static void Main(string[] args)
        {
            while (true)
            {
                int opcaoMenu = Menu();
                Console.Clear();

                if (opcaoMenu == 1)
                {
                    int opcaoListar = MenuListar();
                    Console.Clear();

                    if (opcaoListar == 0)
                        ListarNormal();
                    else if (opcaoListar == 1)
                        ListarPorLetra();
                    else
                        ListarAlfabetico();
                }
                else if (opcaoMenu == 2)
                {
                    string nome = GetNameToSearch();
                    List<int> indices = Pesquisar(nome);
                    ImprimirResultadoBusca(indices);
                }
                else if (opcaoMenu == 3)
                    ApagarContatos();
                else if (opcaoMenu == 4)
                    AlterarContato();
                else if (opcaoMenu == 5)
                    CadastrarContato();
                else
                {
                    int opcao = opcaoArquivo();
                    string path = validarCaminhoArquivo();
                    if (opcao == 1)
                        ImportarArquivo(path);
                    else
                        ExportarArquivo(path);
                }
            }
        }

        #endregion
    }
}