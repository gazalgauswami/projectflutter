// shree 1||
//shree Ganeshay Namah
//Jay Deriwala Bapu
//Om namah Shivay
import 'package:flutter/material.dart';
import 'package:projectflutter/colors.dart';
import 'package:projectflutter/Screen/signup.dart';
import 'package:projectflutter/Screen/signin.dart';
import 'package:projectflutter/detail/fruit.dart';
import 'package:projectflutter/main/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectflutter/main/profile.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.00),
            child:

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Order your \nfavorites fruits",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.00,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Eat fresh fruits and try to be healthy",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 18.00,
                  ),
                ),
                const Image(image: AssetImage(
                  "assets/image/more/fruit_gif.gif",
                ),
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                ),
                const SizedBox(
                  height: 30.00,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2.00),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(23.00),
                        ),
                        child: const Text("SIGN IN"
                          ,style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.00,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage() ,));
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
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}


