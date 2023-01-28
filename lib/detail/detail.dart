import 'package:flutter/material.dart';
import 'package:projectflutter/detail/buy.dart';
import '../colors.dart';
import '../main/cart.dart';

class DetailPage extends StatefulWidget {
  Map data = {};
  DetailPage(this.data, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int n = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                // colors: [AppColors.dark_yellow,AppColors.light_yellow],
              colors: [widget.data["color"],widget.data["color2"]],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: <Widget>[
              SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                       _topBar(),
                       _itemImage(),
                    ],
                  )),
              const SizedBox(height: 20),
              Expanded(child: _bottomSheet()),
            ],
          ),
        ),
         bottomNavigationBar: _bottomAddToCart(),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: AppColors.gray,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Icon(
                Icons.navigate_before,
                color: AppColors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border:
              Border.all(color: widget.data["color2"], width: 2.0),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
              // color: colors_dark[widget.data["color"]],
            ),
          ),
        ],
      ),
    );
  }
  //
  Widget _itemImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image(
            height: 200, width: 200, image: AssetImage(widget.data["image"])),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            const SizedBox(width: 8),
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            const SizedBox(width: 8),
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ],
        )
      ],
    );
  }

  _bottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.data["name"],
            style: const TextStyle(
                fontFamily: "Raleway",
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                letterSpacing: 1.1),
          ),
          const SizedBox(height: 5),
          const Text(
            // widget.fruit.quantity,
            "1kg",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black38,
            ),
          ),
          const SizedBox(height: 10),
           _priceCart(),
          const SizedBox(height: 10),
          const Text(
            "Product Benefits are Below:",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.data["des"],
            style: const TextStyle(
              fontFamily: "Raleway",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
  //
  Widget _priceCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            IconButton(onPressed: (){
              if(n!>1){
                n--;
              }
              setState(() {

              });
            }, icon: const Icon(Icons.remove)),
            Text(n.toString()),
            IconButton(onPressed: (){
              n++;
              setState(() {

              });
            }, icon: const Icon(Icons.add))
            ,
          ],
        ),
        Text(
          "\u{20B9}${widget.data["price"]}",
          // widget.data["price"],
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: "Raleway",
              color: AppColors.black),
        )
      ],
    );
  }
  //
  Widget _bottomAddToCart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
            },
            child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: widget.data["color"],
                ),
                child: const Text(
                  "Add Cart",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontFamily: "Raleway",
                      color: AppColors.black),
                )),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPage(),));
            },
            child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: widget.data["color"],
                ),
                child: const Text(
                  "Buy Now!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontFamily: "Raleway",
                      color: AppColors.black),
                )),
          ),
        ],
      ),
    );
  }
}
