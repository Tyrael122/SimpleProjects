from tkinter import messagebox
import firebase_admin
from firebase_admin import credentials, firestore

firebase_admin.initialize_app(credentials.Certificate(
    {
        "type": "service_account",
        "project_id": "login-screen-f7efa",
        "private_key_id": "d30afaecf963ea834a32b45d0c9abc411fce1f2c",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDWBjel6gPrWcec\n9o/fyFAijP/WcAfE79sB+m3v5IyDJ8DoCjU6MxVUGNaJZuX7c8UgUiG0U+9VlrnJ\nU6nPkkiQQEiS+2Cb6M9mEvNPf9eOiX1IxI1J+eUusRNQr4X31OqkVn6Qw1MijoWn\nA9gUh/jkA489IR185D0PHF1wZp/TheZvuQYXmLAV3pfOn26Q0fZFuuSbYd69FNXG\npxzhwG6WoehBWQtGe+8RJ4FkREAVLPeBnAQwybxkLVHA8CAT1Bg68JXgEOBkleEf\n3QLwe1aF5z4rEpSo8AM69xdBW198GXNSs2fynvCLzTXM/60rs6Rx1PjpWWVEnpdZ\nxMfA25oJAgMBAAECggEAFy1wsNPNLVtZaebssUoe3YMCAL28pafpAoeViMVqLxjq\nw+Y5Ge6myGbxMsuVK9w/dI7YbhAp6s2qHIKmMN+xYofHpD07Wt8FONNkDI+2bw32\nJp98go6gsmQESLhdbHefGoFwbupsMiGXmTzqFV0dR8oX5MGVkS0hbKXAe7ftZolW\noaf0I0eXV1kkfc5QeUoLgyx1X8p63MFLCBkfqlSUfOJ26HhtPvlXFoPJ6dGc/VLS\nKpVLqUN5makLxM1l6Mh1VKJdowzqVmwSTe6HUCOqzB0weoFjdR1LlMZ+VtUYT70J\n/3R1mekSA+/vwhDAprfMFG4JrK8tBSdePpOpBad4lQKBgQD3zGqTmUOe0VkUxdxp\nvDoCORi8YJeNrvXfvNHGTKjQWUuoAMicaUTWRatFOyR88OSsIyo5Ls+C+c7oDswb\njTAXTtIwcuMAhlqqUgMFK/1GKcA0b7nwZKbQEq+sTwvfQTojrRS7AZIKis6MKe5I\n72ql1txWY+C9JdQw6z8MWgHwHQKBgQDdG6JINe5RGvN6XHX/qN3dXwvOK87v5nur\nYsSjHcD5izk0LhWIoYQIV8/wUaXqJ2+16kEgFiB2tkzwemEF4Y02S0YuVQTrsiy5\nQuM+VhvmndGoAFXkhFHU5OEAQb+u8nCDPJpILxN75M68dzJxMd8nTXFgXpMrh9KH\nVHAfUr3F3QKBgDyj87jnGts01B33RbdCbte4bUs8QBpWJKl6JcPnYrCKCa+1cWKF\niGj/Z6hrjsRclzlg6aZQxEuDIpU7ecuMQ6aQjXN5yf+I4YsowsBzQWn4MacjaFdh\n6kilKgR626bo6XdtldMl0T1vNpiqcju7C1hGOmmRy5++MC1AhI9bP3opAoGAVFyP\nzXduR1m+HiibCQG4LRdvnKlQWm4ZL2oO1qGqmEvLdqJCqw/dHYXLm8i7Qhzr3X/U\ne1aV6lViA7rdu+20AEw2KcVcjEU+FS11ILqgCJycerouC3OE+XKeeoebiDeOQDRm\nNTZo+7NwQa5E+7VojElbAcbz5f77j5Di+sCKEa0CgYAh+ux8tGxFSQGtIM3AT2RA\nHlkL28gW5vLfwlt8+BPlrd+2lYiamHaJPfZpN/kxh0hc8uuUda8VPo0FSM2ik8nF\nkcoHSAYOVAgxj6bwYquQjQ6n5SGC7TVQwJqST7yavpVM4avBILAe+i54HeyMdFcT\njjNedp3dIdyI01s6Uh18uw==\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-4jysl@login-screen-f7efa.iam.gserviceaccount.com",
        "client_id": "116203071632890661691",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-4jysl%40login-screen-f7efa.iam.gserviceaccount.com"
    }
))

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
