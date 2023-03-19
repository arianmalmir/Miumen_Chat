import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  const keyApplicationId = '56q6hLG0Qj4vjM0RzqIET035xJ9IqWsIWbrV7imM';
  const keyClientKey = 'Illw3SUbeAi3Z6KIjgs7dbZeGzsG1pR0VoN32yoQ';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
}

void newMessage(String sender, String message) async {
  var msg = ParseObject('Message');
  msg.set('sender', sender);
  msg.set('text', message);

  await msg.save();
}

void checkMessage() async {
  final QueryBuilder<ParseObject> parseQuery =
      QueryBuilder<ParseObject>(ParseObject('Message'));

  final ParseResponse apiResponse = await parseQuery.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      print((o as ParseObject).toString());
    }
  }
}