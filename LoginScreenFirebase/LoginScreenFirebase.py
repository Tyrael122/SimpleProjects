import tkinter
from tkinter import Tk
from ManageUsersFirebase import manageUsers


def callDatabase():
    manageUsers(username_input.get(), password_input.get(), 0)


def signIn():
    manageUsers(username_input.get(), password_input.get(), 1)


window = Tk()
window.title("Start screen")
window.geometry('400x400')

login_label = tkinter.Label(window, text="Login")
username_input = tkinter.Entry(window)
password_label = tkinter.Label(window, text="Password")
password_input = tkinter.Entry(window, show="*")
login_button = tkinter.Button(window, text="Login", command=callDatabase)
signin_button = tkinter.Button(window, text="Sign in", command=signIn)


login_label.pack()
username_input.pack()
password_label.pack()
password_input.pack()
login_button.pack()
signin_button.pack()

window.mainloop()
