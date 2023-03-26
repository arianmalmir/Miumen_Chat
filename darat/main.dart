import 'dart:io';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:window_size/window_size.dart' as window_size;

final List<String> messages = [];
final List<String> senders = [];

checkMessage() async {
  final QueryBuilder<ParseObject> parseQuery =
      QueryBuilder<ParseObject>(ParseObject('Message'));

  final ParseResponse apiResponse = await parseQuery.query();

  if (apiResponse.success && apiResponse.results != null) {
    for (var o in apiResponse.results!) {
      final jsonData = (o as ParseObject).toString();
      final parsedJson = jsonDecode(jsonData);
      messages.add(parsedJson["text"]);
      senders.add(parsedJson["sender"]);
    }
  }
}

void main() async {
  // gaz
  WidgetsFlutterBinding.ensureInitialized();
  window_size.getWindowInfo();
  final frame = Rect.fromLTWH(0, 0, 950, 690);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.setWindowTitle('Miumen chat');
    window_size.setWindowFrame(frame);
    window_size.setWindowMinSize(const Size(950, 690));
    window_size.setWindowMaxSize(const Size(2000, 2000));
  }

  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '56q6hLG0Qj4vjM0RzqIET035xJ9IqWsIWbrV7imM';
  const keyClientKey = 'Illw3SUbeAi3Z6KIjgs7dbZeGzsG1pR0VoN32yoQ';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey,
      liveQueryUrl: 'https://miumenchat2o.b4a.io',
      debug: true);

  runApp(MaterialApp(
    home: LoginApp(),
  ));
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController namecontroller = TextEditingController();

  createuser() async {
    var path = Directory.current.path;
    Hive..init(path);

    var box = await Hive.openBox('Data');
    await box.put('username', namecontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Row(
          children: [
            Image.asset("assets/miumenbadkare.png"),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "!خوش آمدید به میومن الچت ",
                  style: PersianFonts.Samim.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 150,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 25, left: 500, top: 50),
              child: TextField(
                controller: namecontroller,
                maxLength: 14,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 80, 42)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Color.fromARGB(150, 0, 0, 0)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 150,
                      width: 420,
                      // color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 550,
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          " ! میومن باش و میامی کن",
                          style: TextStyle(
                              fontFamily: "AFSANEH",
                              fontWeight: FontWeight.bold,
                              fontSize: 42),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 125,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(150, 197, 45, 32),
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
                              children: [
                                Text(
                                  "گزازی کردی",
                                  style: TextStyle(
                                      fontFamily: "AFSANEH", fontSize: 20),
                                ),
                              ],
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "نام میومنی ات را بنویس",
                                  style: PersianFonts.Samim,
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    createuser();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatApp()));
                  }
                },
              ),
            ),
          ],
        ),
      ]),
    );
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
    messages.add(value["text"]);
  }

  void startLiveQuery() async {
    var sub = await liveQuery.client.subscribe(queryMessage);
    sub.on(LiveQueryEvent.create, (value) {
      print(value);
      Add(value);
      //
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const SizedBox(
                width: 660,
              ),
              SizedBox(
                child: Image.asset("assets/MiumenAbad.png"),
                width: 260,
                height: 107,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Color.fromARGB(150, 0, 0, 0)),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Color.fromARGB(50, 0, 0, 0)),
                    height: 50,
                    width: 800,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Color.fromARGB(150, 0, 0, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 400,
                    width: 800,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 135,
                      ),
                      SizedBox(
                        width: 660,
                        height: 50,
                        child: TextField(
                          controller: meesagecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 146, 55)),
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
                          var box = await Hive.openBox('Data');
                          String username = box.get("username");
                          var msg = ParseObject('Message');
                          msg..set('sender', username);
                          msg..set('text', meesagecontroller.text);
                          await msg.save();
                          meesagecontroller.text = "";
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
                    children: [
                      const SizedBox(
                        width: 139,
                      ),
                      SizedBox(
                        width: 799,
                        height: 340,
                        child: ListView.builder(
                            itemCount: messages.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.amber,
                                    child: Center(child: Text(messages[index])),
                                  ),
                                ),
                              );
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
    );
  }
}

// یه روز آقا خرگوشه
// رفت خونه ی اقا میومنه
// میومنه پرید تو سوراخ
// خرگوشه گفت آخ
