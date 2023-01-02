namespace Default
{
    class Default
    {
        public static IDictionary<int, int[]> numberCoord = new Dictionary<int, int[]>();
        public static string[,] boardValues = new string[3, 3];

        public static bool isDraw()
        {
            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    if (boardValues[i, j] != "X" && boardValues[i, j] != "O")
                        return false;
                }
            }
            return true;
        }

        public static bool isColumnEqual()
        {
            for (int i = 0; i < 3; i++)
            {
                if (boardValues[0, i] == boardValues[1, i])
                {
                    if (boardValues[1, i] == boardValues[2, i])
                        return true;
                }
            }
            return false;
        }

        public static bool isRowEqual()
        {
            for (int i = 0; i < 3; i++)
            {
                if (boardValues[i, 0] == boardValues[i, 1])
                {
                    if (boardValues[i, 1] == boardValues[i, 2])
                        return true;
                }
            }
            return false;
        }

        public static bool checkWin()
        {
            if (isColumnEqual() || isRowEqual())
                return true;

            if (boardValues[0, 0] == boardValues[1, 1])
            {
                if (boardValues[1, 1] == boardValues[2, 2])
                    return true;
            }
            if (boardValues[0, 2] == boardValues[1, 1])
            {
                if (boardValues[1, 1] == boardValues[2, 0])
                    return true;
            }
            return false;
        }

        public static bool isMarked(int[] coord)
        {
            if (boardValues[coord[0], coord[1]] == "X" || boardValues[coord[0], coord[1]] == "O")
                return true;
            else
                return false;
        }

        public static int pickNumber(int player)
        {
            Console.WriteLine($"PLAYER {player} TURN!");
            Console.Write("Choose the number you want to mark: ");
            return int.Parse(Console.ReadLine());
        }

        public static void showAlreadyMarkedInfo(int player)
        {
            Console.Clear();
            printBoard();
            Console.WriteLine("Spot already marked! Choose another, please!");
            markBoard(player);
        }

        public static string[,] markBoard(int player)
        {
            int number = pickNumber(player);
            int[] coord = { numberCoord[number][0], numberCoord[number][1] };
            if (isMarked(coord))
                showAlreadyMarkedInfo(player);
            else
                boardValues[coord[0], coord[1]] = player == 1 ? "X" : "O";
            return boardValues;
        }

        public static void printBoard()
        {
            Console.WriteLine("         |       |         ");
            Console.WriteLine("    {0}    |   {1}   |    {2}   ", boardValues[0, 0], boardValues[0, 1], boardValues[0, 2]);
            Console.WriteLine("         |       |         ");
            Console.WriteLine("---------|-------|---------");
            Console.WriteLine("         |       |         ");
            Console.WriteLine("    {0}    |   {1}   |    {2}   ", boardValues[1, 0], boardValues[1, 1], boardValues[1, 2]);
            Console.WriteLine("         |       |         ");
            Console.WriteLine("---------|-------|---------");
            Console.WriteLine("         |       |         ");
            Console.WriteLine("    {0}    |   {1}   |    {2}   ", boardValues[2, 0], boardValues[2, 1], boardValues[2, 2]);
            Console.WriteLine("         |       |         ");
        }



        static void Main(string[] args)
        {
            int number = 1;
            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    boardValues[i, j] = number.ToString();
                    numberCoord.Add(number, new int[] { i, j });
                    number++;
                }
            }
            printBoard();

            bool draw = false;
            bool hasWon = false;
            while (!draw && !hasWon)
            {
                int player = 1;
                boardValues = markBoard(player);
                Console.Clear();
                printBoard();

                if (!isDraw() && !checkWin())
                {
                    player = 2;
                    boardValues = markBoard(player);
                    Console.Clear();
                    printBoard();
                }
                draw = isDraw();
                hasWon = checkWin();

                if (draw)
                    Console.WriteLine("Draw! No one gets the prize!");
                else if (hasWon)
                    Console.WriteLine($"Cheers to Player {player}, the winner!");
            }
        }
    }
}