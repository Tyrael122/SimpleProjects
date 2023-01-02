import unidecode

# Abre o arquivo.
with open("contatosTelefone100.txt", "r", encoding='utf-8') as file:
    contactsList = file.readlines()


# Cria uma matriz 'contacts' para armazenar o nome e o telefone do contato.
contacts = []
for contact in contactsList:
    contactInfo = contact.split(", ")
    contacts.append(contactInfo)

# Loopa por todos os contatos.
for i in range(0, len(contacts)):

    # Loopa por todos os contatos - 1, pois o contato o segundo contato a ser comparado será j + 1.
    # Se fosse todos os contatos, j + 1 daria 'arrayOutOfBounds'.
    for j in range(0, len(contacts) - 1):

        firstContactName = contacts[j][0]
        secondContactName = contacts[j + 1][0]

        # Vê qual o maior nome e define pra ver até a última letra daquele nome, senão dá 'arrayOutOfBounds'.
        if len(firstContactName) > len(secondContactName):
            maxIndex = len(secondContactName)
        else:
            maxIndex = len(firstContactName)

        # Para cada letra no nome.
        for n in range(0, maxIndex):

            secondContact = contacts[j + 1] # Varável auxiliar para fazer a troca.

            # Acessa a n - ésima letra do nome.
            letterContact1 = contacts[j][0][n]
            letterContact2 = contacts[j + 1][0][n]

            # Se as letras não forem um espaço.
            if letterContact1 != 32 and letterContact2 != 32:

                # Converte para minúsculo.
                letterContact1 = letterContact1.lower()
                letterContact2 = letterContact2.lower()

                # Tira os acentos.
                letterContact1 = unidecode.unidecode(letterContact1)
                letterContact2 = unidecode.unidecode(letterContact2)

                # Se a letra tiver um valor maior que a outra, troque elas. Lembrando que B = 66 que é maior que A = 65.
                if letterContact1 > letterContact2:
                    contacts[j + 1] = contacts[j]
                    contacts[j] = secondContact
                    # Para sair do loop. Já que já trocou, não precisa comparar o resto do nome.
                    break

                # Se as letras forem iguais, continue para a próxima iteração.
                elif letterContact1 == letterContact2:
                    continue

                # Se não forem iguais, nem na ordem errada, então estão na ordem certa.
                # Daí, não faça nada.
                else:
                    break

            else:  # Se for um espaço, pula a iteração.
                continue

# Escreve no arquivo final.
with open("contatosSorted.txt", "w") as finalFile:
    for contact in contacts:
        string = contact[0] + ", " + contact[1]
        finalFile.write(string)
