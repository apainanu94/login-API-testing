import 'package:api/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const  EdgeInsets.all(10.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                 controller: emailController,
                 decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email)),

                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.lock)),
                ),
                SizedBox(
                  height:  45,
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    login();
                  },
                  icon: Icon(
                      Icons.login,
                      size: 18,
                  ),
                  label:Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //CREATE FUNCTION TO CALL LOGIN API
  Future<void> login() async{

    var emailController;
    var passController;

    if(passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("https://api-nodejs-todolist.herokuapp.com"), body: ({
            'email':emailController.text,
            'password':passController.text
          }));
          if(response.statusCode==200){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));

          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
          }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Black FIeld Not ")));

    }
  }
}