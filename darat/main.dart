import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:window_size/window_size.dart' as window_size;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  window_size.getWindowInfo();
  final frame = Rect.fromLTWH(0, 0, 950, 690);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.setWindowTitle('Miumen chat');
    window_size.setWindowFrame(frame);
    window_size.setWindowMinSize(const Size(10, 10));
    window_size.setWindowMaxSize(const Size(2000, 2000));
  }

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: LoginApp(),
  ));
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {
    Size sizescreen = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: Image.asset("assets/miumenah.png"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "!خوش آمدید به میومن الچت ",
                    style: PersianFonts.Samim.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 10, top: 10),
                child: TextField(
                  controller: namecontroller,
                  maxLength: 14,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 235, 80, 42)),
                ),
              ),
              const SizedBox(
                height: 125,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(150, 197, 45, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'ورود',
                    style: PersianFonts.Samim.copyWith(fontSize: 20),
                  ),
                  onPressed: () {
                    if (namecontroller.text == "") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "گزازی کردی",
                                    style: TextStyle(
                                        fontFamily: "AFSANEH", fontSize: 20),
                                  ),
                                ],
                              ),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "نام میومنی ات را بنویس",
                                    style: PersianFonts.Samim,
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatApp()));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  List<ParseObject> Messages = [];
  final QueryBuilder<ParseObject> queryMessage =
      QueryBuilder<ParseObject>(ParseObject('Message'))
        ..orderByAscending('text');

  final LiveQuery liveQuery = LiveQuery(debug: true);
  late Subscription<ParseObject> subscription;

  TextEditingController meesagecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkMessage();
    startLiveQuery();
  }

  void Add(value) {
    setState(() {
      messages.add(value["text"]);
    });
  }

  void startLiveQuery() async {
    var sub = await liveQuery.client.subscribe(queryMessage);
    sub.on(LiveQueryEvent.create, (value) {
      Add(value);
      //
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Image.asset("assets/MiumenAbad.png"),
                    width: 260,
                    height: 107,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              Stack(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(150, 0, 0, 0)),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: const Color.fromARGB(50, 0, 0, 0)),
                        height: 50,
                        width: size.width - 100,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(150, 0, 0, 0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            height: size.height / 1.5,
                            width: size.width - 100,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: size.width - 250,
                            height: size.height / 15,
                            child: TextField(
                              controller: meesagecontroller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 146, 55)),
                              onSubmitted: (value) async {
                              },
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: 50,
                              height: 46,
                              child: Image.asset(
                                'assets/moz.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: 47,
                              height: 50,
                              child: Image.asset(
                                'assets/miumen.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                            ),
                            iconSize: 35,
                            color: Colors.black,
                            onPressed: () async {
                              if (meesagecontroller.text != "") {

                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width - 100,
                            height: size.height / 1.75,
                            child: ListView.builder(
                                itemCount: messages.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OutBubble(message: messages[index]);
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class OutBubble extends StatelessWidget {
  final String message;
  const OutBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 10, bottom: 5),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}

// یه روز آقا خرگوشه
// رفت خونه ی اقا میومنه
// میومنه پرید تو سوراخ
// خرگوشه گفت آخ
