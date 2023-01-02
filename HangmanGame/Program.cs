namespace Default
{
    class Default
    {
        public static string getPalavraAleatoria()
        {
            Random randomNumber = new Random();
            string[] palavras = File.ReadAllLines(@"C:\Users\Suporte\OneDrive - Fatec Centro Paula Souza\palavrasJogoForca.txt");
            return palavras[randomNumber.Next(0, palavras.Length)];
        }

        public static void gameOver(string resposta)
        {
            Console.WriteLine($"Ops!\nA resposta era '{resposta}'.\nVocê perdeu o jogo! Parabéns!");
            Environment.Exit(0);
        }

        public static void gameWin()
        {
            Console.WriteLine("\nVocê ganhou o jogo! Parabéns!");
            Environment.Exit(0);
        }

        static void Main(string[] args)
        {
            Console.WriteLine("JOGO DA FORCA!");

            string palavra = getPalavraAleatoria();
            char[] letrasPalavraResposta = palavra.ToCharArray();

            //Lista usada para armazenar as letras digitadas pelo usuário.
            List<char> letrasDigitadas = new List<char>();

            int vidas = 6;
            int letrasFaltando;
            while (vidas > 0)
            {
                //Essa variável é usada para saber se o jogador completou a palavra ou não.
                letrasFaltando = palavra.Length;

                foreach (char letra in letrasPalavraResposta)
                {
                    //Se a letra já foi escolhida pelo jogador, escreva-a.
                    //Pode-se modularizar.
                    Console.ForegroundColor = ConsoleColor.Blue;
                    if (letrasDigitadas.Contains(letra))
                    {
                        Console.Write(letra);
                        letrasFaltando--;
                    }
                    //Senão, escreva um traço.
                    else
                    {
                        Console.Write("_ ");
                    }
                    Console.ForegroundColor = ConsoleColor.White;
                    
                }
                //Se o jogador tiver completado a palavra, ele ganhou o jogo.
                if (letrasFaltando == 0)
                {
                    gameWin();
                }

                bool letraRepetida = false;
                Console.Write("\nDigite uma letra ou a palavra inteira: ");
                string input = Console.ReadLine().ToLower();

                //Se o jogador tiver escrito uma letra.
                if (input.Length == 1)
                {
                    //Verifica se a letra é repetida ou não.
                    //Pode-se modularizar.
                    foreach (char letra in letrasDigitadas)
                    {
                        if (letra.Equals(Convert.ToChar(input)))
                        {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine("A letra já foi usada!");
                            letraRepetida = true;
                            Console.ForegroundColor = ConsoleColor.White;
                            break;
                        }
                    }
                    //Se a letra não for repetida, ela é adicionada à lista.
                    //Pode-se modularizar.
                    if (!letraRepetida)
                    {
                        letrasDigitadas.Add(Convert.ToChar(input));
                        //Se a letra não estiver na palavra, o jogador perde uma vida.
                        if (!palavra.Contains(input))
                        {
                            vidas--;
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine($"Você perdeu uma vida! Agora você tem {vidas}!");
                            Console.ForegroundColor = ConsoleColor.White;
                        }
                    }
                }
                //Verifica se a palavra digitada está correta.
                else if (input == palavra)
                {
                    gameWin();
                }
                else
                {
                    gameOver(palavra);
                }
            }
            gameOver(palavra);
        }
    }
}