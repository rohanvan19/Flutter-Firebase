import 'package:firebase_database/firebase_database.dart';

String? validateEmail(String? value){
  String pattern = r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}';
  RegExp regExp = RegExp(pattern);
  if(value!.isEmpty){
    return "E-mail cannot be empty";
  }
  else if(!regExp.hasMatch(value)){
    return "Enter proper E-mail";
  }
  else{
    DatabaseReference testref = FirebaseDatabase.instance.reference().child('Username');
    testref.set(value);
  }
  return null;
}

String? validatePhone(String? value){
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Please enter valid phone number";
  }
  else if (value.length != 10) {
    return "Phone number has to be 10 digits";
  }
  else if (!regExp.hasMatch(value)) {
    return "Phone Number must be numeric digits only";
  }
  else{
    DatabaseReference testrefe = FirebaseDatabase.instance.reference().child('Phone Number');
    testrefe.set(value);
  }
  return null;
}

String? validatePassword(String? value){
  String passwordpattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
  RegExp passwordregExp = RegExp(passwordpattern);
  if(value!.isEmpty){
    return "Password cannot be empty";
  }
  else if(!passwordregExp.hasMatch(value)){
    return "Enter valid password";
  }
  else{
    DatabaseReference testrefer = FirebaseDatabase.instance.reference().child('Password');
    testrefer.set(value);
  }
  return null;
}