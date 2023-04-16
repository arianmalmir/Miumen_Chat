const Parse = require('parse/node');

Parse.initialize("", ""); //PASTE HERE YOUR Back4App APPLICATION ID AND YOUR JavaScript KEY
Parse.serverURL = "";

const sender = 'miumenak'

async function readMessage(){
  const query = new Parse.Query("User")
  const results = await query.find();

  try {
    for (const object of results) {
      // Access the Parse Object attributes using the .GET method
      const msgText = object.get('username');
      const msgSender = object.get('email');

      console.log(msgSender + ': ' + msgText);
    }
  }  catch (error) {
    console.error('Error while fetching MyCustomClassName', error);
  }
};

async function sendMessage(msg) {
    let user = new Parse.User();
    user.set("username", msg);
    user.set("password", sender);
    user.set("email", sender + "@miumen.com");

    try {
        user = await user.save();
    } catch (error) {
        console.log('Error while sending message', error);
    }
}

console.log("Welcom to Miumen Chat!");
console.log("Your id is " + sender + ".")
