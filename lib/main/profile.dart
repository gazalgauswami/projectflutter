import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectflutter/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  String? bdate;
  String? phone;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.pink,
                  border: Border.all(color: Colors.pink, width: 3)),
              child: const Center(
                child: Text(
                  "My Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Image(
                image: AssetImage("assets/image/more/20230116_231522_0000.png"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                getData();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.pink, width: 3)),
                child: Center(
                  child: Text(
                    "Email: $email",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                getData();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.pink, width: 3)),
                child: Center(
                  child: Text(
                    "Birth-Date: $bdate",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 5,),
            // InkWell(
            //   onTap: (){
            //       getData();
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         border: Border.all(color: Colors.pink,width: 3)
            //     ),
            //     child:  Center(
            //       child: Text(
            //         "Phone-Number: $phone ",
            //         style: const TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Colors.pink,
            //             fontSize: 20
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 5,),
            //      InkWell(
            //        onTap: (){
            //           getData();
            //        },
            //        child: Container(
            //          width: double.infinity,
            //          height: 50,
            //          decoration: BoxDecoration(
            //              borderRadius: BorderRadius.circular(5),
            //              border: Border.all(color: Colors.pink,width: 3)
            //          ),
            //          child:  Center(
            //            child: Text(
            //              "Password: $pass",
            //              style: const TextStyle(
            //                  fontWeight: FontWeight.bold,
            //                  color: Colors.pink,
            //                  fontSize: 20
            //              ),
            //            ),
            //          ),
            //        ),
            //      ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ));
                Fluttertoast.showToast(msg: "Sign Out Succesfully");
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
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                delete();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ));
                Fluttertoast.showToast(msg: "Account Delete Succesfully");
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
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  delete() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    user?.delete();
  }

  getData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      email = vari.data()!['email'];
      bdate = vari.data()!['bdate'];
      phone = vari.data()!['phone'];
      pass = vari.data()!['pass'];
    });
  }
}
