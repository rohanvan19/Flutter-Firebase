import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
          future: fbApp,
          builder: (context,snapshot){
            if(snapshot.hasError){
              print('You have an error ! ${snapshot.error.toString()}');
              return Text('Something went wrong');
            } else if(snapshot.hasData){
              return MyHome();
            } else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }
}

class MyHome extends StatefulWidget {

  @override
  State<MyHome> createState() => _MyHomeState();

}

class _MyHomeState extends State<MyHome> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController phonecontroller = new TextEditingController();
  final TextEditingController peoplecontroller = new TextEditingController();
  final TextEditingController tablecontroller  = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  void clearText() {
    emailcontroller.clear();
    phonecontroller.clear();
    passwordcontroller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text('Restaurant Booking System',
          style: GoogleFonts.sahitya(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Image(
                image: NetworkImage('https://s3.amazonaws.com/thumbnails.venngage.com/template/6114cd0a-e706-4e1b-85b5-8aca4c480570.png'), //https://www.shareicon.net/data/2016/07/08/117547_developer_512x512.png
                width: 500,
                height: 150,
              ),
              TextFormField(
                controller: namecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Customer Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your e-mail',
                  labelText: 'Customer E-mail',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phonecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter your phone number',
                  labelText: 'Customer contact',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: peoplecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter the number of people',
                  labelText: 'Number of people',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: tablecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter the table number',
                  labelText: 'Table Number',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: passwordcontroller ,
                decoration: const InputDecoration(
                  icon: Icon(Icons.remove_red_eye_sharp),
                  hintText: 'Enter your Password',
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed:() {
                      String pattern = r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}';
                      RegExp regExp = RegExp(pattern);
                      String phonepattern = r'(^[0-9]*$)';
                      RegExp phoneregExp = RegExp(phonepattern);
                      String passwordpattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
                      RegExp passwordregExp = RegExp(passwordpattern);

                      // namevalidation
                      if(namecontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter name';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testref = FirebaseDatabase.instance.reference().child('Customer Name');
                        testref.set(namecontroller.text);
                      }

                      //E-mail Validation
                      if(emailcontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter email';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else if(!regExp.hasMatch(emailcontroller.text)){
                        setState(() {
                          final text = 'Please enter proper email';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testref = FirebaseDatabase.instance.reference().child('Customer E-mail');
                        testref.set(emailcontroller.text);
                      }

                      //Phone Number Validation
                      if(phonecontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter phone number';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else if(!phoneregExp.hasMatch(phonecontroller.text)){
                        setState(() {
                          final text = 'Phone number must be numeric';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else if(phonecontroller.text.length != 10){
                        setState(() {
                          final text = 'Phone number must have 10 numbers';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testrefe = FirebaseDatabase.instance.reference().child('Customer Contact');
                        testrefe.set(phonecontroller.text);
                      }

                      //
                      if(peoplecontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter the number of people';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testref = FirebaseDatabase.instance.reference().child('Number of people');
                        testref.set(peoplecontroller.text);
                      }

                      //table controller
                      if(tablecontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter table number';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testref = FirebaseDatabase.instance.reference().child('Table Number');
                        testref.set(tablecontroller.text);
                      }

                      //Password Validation
                      if(passwordcontroller.text.isEmpty){
                        setState(() {
                          final text = 'Please enter password';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else if(!passwordregExp.hasMatch(passwordcontroller.text)){
                        setState(() {
                          final text = 'Password must have minimum eight characters, at least one letter, one number and one special character';
                          final snackBar = SnackBar(content: Text(text, textAlign: TextAlign.center),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      else{
                        DatabaseReference testrefer = FirebaseDatabase.instance.reference().child('Password');
                        testrefer.set(passwordcontroller.text);
                      }
                    },
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    child: const Text('Clear'),
                    onPressed: clearText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}