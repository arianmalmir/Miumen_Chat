import firebase_admin
import threading

from firebase_admin import credentials
from firebase_admin import firestore
from rich.console import Console
from rich.table import Column, Table


cred = credentials.Certificate("serviceAccountKey.json")
app = firebase_admin.initialize_app(cred)


class Fire ():
    def __init__(self):

        db = firestore.client()
        self.chat = db.collection(u'miuchat')

    def add_user (self , name):

        docs = self.chat.stream()
        for doc in docs:
            if doc.id == name :
                return False

        Send = self.chat.document(name)
        Send.set({
            u'chats': ""
        })

    def send (self , name , message):

        Send = self.chat.document(name)
        Send.set(
            {
                u'chats' : message
            }
        )

    def read (self):

        docs = self.chat.stream()
        for doc in docs:
            j = doc.to_dict()
            k = j["chats"]
            if j["chats"] != "" : 
                print(f"{doc.id}:{k}")
                Fire().send(doc.id,"")

f = open("username.txt" , "r").read()

def bakak ():
    # من بکاکم

    while True:
        Fire().read()
        
    

threading1 = threading.Thread(target=bakak)
threading1.daemon = True
threading1.start()

if f != '':
    Input = ""
    console = Console()
    table = Table(show_header=True, header_style="bold magenta")
    table.add_column("Options", style="dim", width=15)
    table.add_column("Write" , style = "dim" , width=15)
    table.add_row(
        "send a message",
        "'message'"
    )
    table.add_row(
    "zabt",
    "zabt"
    )
    table.add_row(
        "exit",
        "EXIT"
    )

    console.print(table)

    while Input != "EXIT":
        Input = input()

        if Input != "EXIT" :
             
            Fire().send(f,Input)
            
else:
    console = Console()
    console.print("Hello", style="bold")
    console.print("What's your name ?" , style="#fb5662")

    miu = False

    while miu != True :
        username = input()

        n = Fire().add_user(username)

        if n != False:
            f = open("username.txt","w")
            f.write(username)
            f.close()

            miu = True

        else:
            console.print("Choose a other name.", style="bold #850000")

    console.print("Open the app again", style="italic #4056fb")    
