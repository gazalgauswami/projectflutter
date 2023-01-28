
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projectflutter/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectflutter/Screen/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectflutter/model/user_model.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  late String password;
  late String conpassword;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _cpass = TextEditingController();

  late DatabaseReference dbref;

  @override
  void initState(){
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('user');
  }

  String male = "MALE";
  String female = "FEMALE";
  String other = "OTHER";
  String gender = "MALE";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.light_pink,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.00,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Create An Account , It's Free",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 18.00,
                  ),
                ),
                const SizedBox(height: 10,),
                Form(
                  key:  _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 370,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child:  TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)  {
                            if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'8+-/=?^_`{|}`]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                              return "Enter Correct Email";
                            }

                            return null;
                          },
                          onSaved: (value){
                            _email.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Email  ",
                            border:  InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.00,
                      ),
                  RadioListTile(value: male,
                    activeColor: Colors.pinkAccent,
                    title: const Text("MALE"),
                    groupValue: gender,
                    onChanged: (value) => setState(() {
                      gender = value.toString();
                    },
                    ),
                  ),
                  RadioListTile(value: female,
                    activeColor: Colors.pinkAccent,
                    title: const Text("FEMALE"),
                    groupValue: gender,
                    onChanged: (value) => setState(() {
                      gender = value.toString();
                    }
                    ),
                  ),
                  RadioListTile(value: other,
                    activeColor: Colors.pinkAccent,
                    title: const Text("OTHER"),
                    groupValue: gender,
                    onChanged: (value) => setState(() {
                      gender = value.toString();
                    }
                    ),
                  ),
                      Container(
                        alignment: Alignment.center,
                        width: 370,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child:  TextFormField(
                          controller: _date,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          validator: (value)  {
                            if(value!.isEmpty ) {
                              return "Enter Correct BirthDate";
                            }
                            return null;
                          },
                          onSaved: (value){
                            _date.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          onTap: () async{
                            DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2024));

                            // if(date != null){
                            //   _date.text = date.toString();
                            // }
                            if(date != null){
                              _date.text = DateFormat("DD MMMM yyyy").format(date);
                            }
                          },

                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Choose Your BirthDate  ",
                            border:  InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.00,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 370,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child:  TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.number,
                          validator: (value)  {
                            if( value!.isEmpty) {
                              return "Enter correct phone-number";
                            }
                            return null;
                          },
                          onSaved: (value){
                            _phone.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Phone-number  ",
                            border:  InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.00,),
                      Container(
                        alignment: Alignment.center,
                        width: 370,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child:  TextFormField(
                          obscureText: true,
                          controller: _pass,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            password= value.toString();
                            setState(() {

                            });
                          },
                          validator: (value)  {
                            if(value!.length<8  || value.isEmpty || !RegExp(r'^.{8,}$').hasMatch(value)) {
                              return "Password must be at least 8 characters long";
                            }
                            return null;
                          },
                          onSaved: (value){
                            _pass.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Password  ",
                            border:  InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.00,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 370,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.00),
                        ),
                        child:  TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: (value)  {
                            if(value!=_pass.text || value!.isEmpty || !RegExp(r'^.{8,}$').hasMatch(value)) {
                              return "conform Password must be match with password";
                            }
                            return null;
                          },
                          onSaved: (value){
                            _cpass.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Enter Conform Password  ",
                            border:  InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               const SizedBox(
                 height: 20,
               ),
                GestureDetector(
                  onTap: (){
                    signUp(_email.text,_pass.text);
                    Map<String,String> user = {
                      'email': _email.text,
                      "bdate": _date.text,
                      "phone": _phone.text,
                      "pass": _pass.text,
                    };
                    dbref.push().set(user);
                    // if()
                    // signUp(_email.text,_pass.text);
                    // _formKey.currentState!.validate()){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
                    // }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black,width: 2.00),
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(23.00),
                    ),
                    child: const Text("SIGN UP"
                      ,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account ?",
                      style: TextStyle(

                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
                    }, child: const Text("Sign In",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //signup function
  signUp(String email , String password) async{
    if(_formKey.currentState!.validate()){
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError(
                (e) {
              Fluttertoast.showToast(msg: e!.message);
            }
        );
      }
        on FirebaseAuthException catch (error){
        switch(error.code){
          case "invalid-email":
            errorMessage = "Youe Email Address appears to be malformed.";
            break;

          case "wrong-password":
            errorMessage = "Your password is wrong.";break;

          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";break;

          case "user-disabled":
            errorMessage = "User with this email has been disabled.";break;

          case "too-many-requests":
            errorMessage= "Too many requests";break;

          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";break;

          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
 }
 postDetailsToFirestore() async {
    //calling our firestore
   //calling our user model
   //sending these values

   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   User? user = _auth.currentUser;

   UserModel userModel = UserModel();

   //writing all the values
   userModel.email = user!.email;
   userModel.uid = user!.uid;
   userModel.phone = _phone.text;
   userModel.bdate = _date.text;
   userModel.pass = _pass.text;

   await firebaseFirestore
   .collection('users')
   .doc(user.uid)
   .set(userModel.toMap());
   Fluttertoast.showToast(msg: "Account Create SuccessFully");

   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInPage(),), (route) => false);
 }
}
