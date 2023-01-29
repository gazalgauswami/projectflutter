import 'package:flutter/material.dart';
import 'package:projectflutter/main/home.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({Key? key}) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Container(
            color: Colors.white,
            width: 400,
            height: 450,
            margin: EdgeInsets.all(16.00),
            padding: EdgeInsets.all(16.00),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: Duration(seconds: 2),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: Icon(Icons.done, color: Colors.white, size: 50),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Your Order \nHas Been Placed!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Your Confirmation Email has \nbeen send soon. \nCheck your mail",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.00),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.00),
                    ),
                    child: const Text(
                      "Continue Shopping",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
