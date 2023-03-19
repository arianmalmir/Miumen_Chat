# بکاک باش

from os import name
import firebase_admin
import threading
import pymsgbox

from firebase_admin import credentials
from firebase_admin import firestore
from rich.console import Console
from rich.table import Column, Table

f = open("core/username.txt" , "r").read()
Login_names = ['miumen', 'miumen haghag', 'miumen dole', 'miumen ol saltane', 'giv', 'sharifi', 'arian', 'malmir']

# فرانت اراج باش

import flet
from flet import (
    ElevatedButton, Page, Text , Column , Row , colors , Container ,
    TextField , ButtonStyle  , icons , IconButton , Stack , Image 
)

# فرانتی که موسو ازش دوری میکنه

m = 0
messages = []

# صفحه ی اراج لاگین
def Login_SignUp(page: Page):
    global m
    global messages

    page.theme_mode = "light"
    page.title = "Miumen Chat"
    page.window_resizable = False
    page.window_width = 1080 
    page.window_height = 720


    img = Image(
        src=f"./assets/images/sikh.png",
        width=208,
        height=500
    )



    def Signup (e):  
        user = str(namesign.value)

        # if (' ' in user) or (user.lower() in Login_names) or 'cubic' in user.lower():
        #     pymsgbox.alert('نام کاربری آدمیزادی انتخاب کن اراج', 'افت')



        f = open("core/username.txt" , "w")
        f.write(user)
        f.close()

        print(str(namesign.value))

        Fire().add_user(user)

        f = open("core/username.txt" , "r").read()


        page.update()



    def Login (e): 
        user = str(namelog.value)
        password = str(passlog.value)

        if user.lower() in Login_names:
            if password == 'Miumen12345Ajaj':
                f = open("core/username.txt" , "w")
                f.write(user)
                f.close()

                f = open("core/username.txt" , "r").read()





            else:
                pymsgbox.alert('رمزت هرزه', 'افت')              

        else:
            pymsgbox.alert('نام کاربری آدمیزادی انتخاب کن اراج', 'افت')
        page.update()

    def new_message(msg: str):
        global m
        global messages

        if m < 10:
            m += 1

            messages.append(Text(str(msg)))
            page.update()

    for i in range(23):
        new_message("i")



    passlog =  TextField(
        password=True,
        label= "Enter Miumeni password",
        border_radius= 15.0,
        filled=True,
        bgcolor= "#E2792E",
        height=50 , 
        on_submit=Login
        )

    namelog =  TextField(
        label= "Enter Miumeni name",
        border_radius= 15.0,
        filled=True,
        bgcolor= "#E2792E",
        height=50,
        on_submit=Login
        )

    namesign = TextField(
        label= "Enter Miumeni name",
        border_radius= 15.0,
        filled=True,
        bgcolor= "#E2792E",
        height=50 ,
        on_submit=Signup
    )

    page.add(
        Column(
            [
                Row(
                    [
                        Container(
                            width=200
                        ),

                        Column(
                            [
                                Container(
                                    height=50
                                ),
                                Text("ثبت نام" , size = 34 , font_family= "Sahel" , weight="bold"),
                            ]
                        ),

                        Container(
                            width=510
                        ),

                        Column(
                            [
                                Container(
                                    height=50
                                    ),
                                Text("ورود" , size = 34 , font_family= "Sahel" , weight="bold"),
                            ]
                        ),
                    ]
                ),

                Row(
                    [
                        Column(
                        [
                        Row(
                            [
                                Container(
                                    width=100
                                ),
                                namelog,
                                Container(
                                    width=10
                                ),
                            ]
                        ),
                        Container(
                            height=100
                        ),
                        Container(
                            height=20
                        ),
                        Row(
                            [
                                Container(
                                    width=180
                                ),
                                ElevatedButton(
                                content = Container(
                                    content=Column(
                                        [
                                            Text(value="Sign up", size=15),
                                        ],
                                        alignment="center",
                                        spacing=5,
                                    ),
                                ),
                                style = ButtonStyle(
                                    color={
                                        "hovered": colors.ORANGE,
                                        "focused": colors.ORANGE_200,
                                        "": colors.BLACK,
                                    }
                                ),
                                on_click=Signup
                            ),
                            ]
                        ),
                    ]
                ),
                img,
                Column(
                    [
                        Row(
                            [
                                Container(
                                    width=30
                                ),
                                namesign
                            ]
                        ),
                        Container(
                            height=50
                        ),
                        Row(
                            [
                                Container(
                                    width=30
                                ),
                                passlog
                            ]
                        ),
                        Container(
                            height=20
                        ),
                        Row(
                            [
                                Container(
                                    width=150
                                ),
                                ElevatedButton(
                                content = Container(
                                    content=Column(
                                        [
                                            Text(value="Login", size=15),
                                        ],
                                        alignment="center",
                                        spacing=5,
                                    ),
                                ),
                                style = ButtonStyle(
                                    color={
                                        "hovered": colors.ORANGE,
                                        "focused": colors.ORANGE_200,
                                        "": colors.BLACK,
                                    }
                                ),

                                on_click = Login

                            ),
                            ]
                        ),

                    ]
                ),

                ]
            )

        ]
    ),
)

# میومن الچت المیومن الدوله السلطنه
def main (page: Page):
    global new_message

    page.title = "Miumen Chat"
    page.window_resizable = False
    page.window_width = 1080 
    page.window_height = 720
    page.theme_mode = "light"

    img = Image(
        src=f"./assets/images/logo.png",
        width=208,
        height=100
    )

    Miumen = Image(
        src=f"./assets/images/Miumen.png",
        width=50,
        height=50
    )

    moz = Image(
        src=f"./assets/images/moz.png",
        width=50,
        height=50
    )


    def add_clicked(e):                                                          
        Fire().send(f, str(new_task.value))

        if len(tasks_view.controls) > 8:
            for i in range(9):
                tasks_view.controls.pop()

        new_task.value = ""
        view.update()

    def new_message(msg):

        Split = msg.split(":")

        if f != Split[0] :
            tasks_view.controls.append(Container(content = Text(msg), height=30 , width=len(msg)*10 , bgcolor=colors.ORANGE, border_radius = 10.0  , padding=4 ))
        else:
            tasks_view.controls.append(Container(content = Text(Split[1]), height=30 , width=len(Split[1])*10 , bgcolor=colors.AMBER_300, border_radius = 10.0  , padding=4 ))
        if len(tasks_view.controls) > 8:
            for i in range(9):
                tasks_view.controls.pop()

        new_task.value = ""
        view.update()


    tasks_view = Column()
    new_task = TextField(hint_text="Enter your messages !", height= 56 , width= 800 , border_radius= 15.0,
                                filled=True,
                                bgcolor= "#E2792E", on_submit = add_clicked)
    view = Column(

        controls=[
            Stack(
                [
                    Container(
                        height=400
                    ),
                    Row(
                        [
                            Container(
                                width = 35
                            ),
                            tasks_view,
                        ]
                    ),


                ]
            ),
            Row(
                controls=[
                    Container(
                        width=35
                    ),
                    new_task,
                    Miumen,
                    moz,
                    IconButton(
                    icon=icons.SEND,
                    icon_color="blue",
                    icon_size=35,
                    tooltip="send",
                    on_click= add_clicked
                    ),
                ],
            ),

        ],
    )

    page.horizontal_alignment = "center"
    page.add(
        Column(
            [
                Container(
                    height=10
                ),
                Row(
                    [
                        Container(
                            width=820
                        ),
                        img
                    ]
                ),
                Column(
                    [
                        Container(
                            height=10
                        ),
                        view
                    ]
                ),

            ]
        )
    )

# بکاک حقاق

cred = credentials.Certificate("core/serviceAccountKey.json")
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
                new_message(msg=str(f"{doc.id}:{k}"))
                Fire().send(doc.id,"")


def bakak ():
    # من بکاکم

    while True:
        Fire().read()

# ترد باش
threading1 = threading.Thread(target=bakak)
threading1.daemon = True
threading1.start()

if f == '':
    flet.app(target=Login_SignUp , assets_dir="assets")

else:
    flet.app(target=main , assets_dir="assets")
