from tkinter import messagebox
import json
import firebase_admin
from firebase_admin import credentials, firestore

with open('firebaseCredentials.json', 'r') as f:
    data = json.load(f)
    
firebase_admin.initialize_app(credentials.Certificate(data))
database = firestore.client()


def checkPassword(password, passwordInput):
    if password == passwordInput:
        return True
    else:
        return False


def checkLogin(login, loginInput):
    if login == loginInput:
        return True
    else:
        return False


def create_Credential_List(codifiedUsers):
    credential_list = []
    for user in codifiedUsers:
        # Transforms the codified info into a dictionary.
        user = user.to_dict()
        # Appends a tuple (name, password) to a list
        credential_list.append((user["name"], user["password"]))
    return credential_list


def manageUsers(login, password, mode):
    '''mode 0 is the 'login in mode', mode 1 is the 'sign in mode'''
    # Gets the information of the users (name, password) from the Firebase in a codified form
    codifiedUsers = database.collection("User").stream()
    if mode == 0:
        status_login = False  # Used to track whether the user has successfully logged in
        credential_list = create_Credential_List(codifiedUsers)
        for credentials in credential_list:
            if checkLogin(credentials[0], login):
                if checkPassword(credentials[1], password):
                    messagebox.showinfo(
                        title="SUCESSO", message="Logado com sucesso!")
                    status_login = True
        if status_login == False:
            messagebox.showwarning(
                title="AVISO", message="Credenciais inválidas!")
    else:
        # Chama a funçao para cadastrar o usuário.
        create_user = True
        credential_list = create_Credential_List(codifiedUsers)
        for credentials in credential_list:
            if checkLogin(credentials[0], login):
                messagebox.showwarning(
                    title="AVISO", message="Login já existe!")
                create_user = False
        if create_user == True:
            codifiedUsers.document().set({"name": login, "password": password})
