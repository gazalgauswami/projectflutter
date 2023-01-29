import 'package:flutter/material.dart';
import 'package:projectflutter/colors.dart';
import 'package:projectflutter/main/home.dart';
import 'package:projectflutter/Screen/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  // List <Map> info = [];

  // FirebaseDatabase database = FirebaseDatabase.instance;
  // String selectedKey = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.light_p,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.00,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Login To Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                  fontSize: 18.00,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 370,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.00),
                        color: Colors.transparent,
                        // shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.00),
                      ),
                      child: TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'8+-/=?^_`{|}`]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Enter Correct Email";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _email.text = value!;
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Email:  ",
                          border: InputBorder.none,
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
                        border: Border.all(color: Colors.black, width: 2.00),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5.00),
                      ),
                      child: TextFormField(
                        controller: _pass,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.length < 8 ||
                              value.isEmpty ||
                              !RegExp(r'^.{8,}$').hasMatch(value)) {
                            return "Password must be at least 8 characters long";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _pass.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Password:  ",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  signin(_email.text, _pass.text);

                  // if(_formKey.currentState!.validate()){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
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
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Image(
                image: AssetImage(
                  "assets/image/fruit/fruits-chop.png",
                ),
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
  //login function

  void signin(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((key) => {
                  Fluttertoast.showToast(msg: "Login Successfully"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ))
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Youe Email Address appears to be malformed.";
            break;

          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;

          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;

          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;

          case "too-many-requests":
            errorMessage = "Too many requests";
            break;

          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;

          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
