import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/Screen/signin.dart';
import 'package:projectflutter/colors.dart';
import 'package:projectflutter/detail/sqflite_database.dart';
import 'package:projectflutter/main/cart.dart';
import 'package:projectflutter/model/CartProvider.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import 'detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({Key? key}) : super(key: key);

  @override
  State<FruitPage> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage> {
  DBHelper dbHelper = DBHelper();

  List <Map> data = [
    {
      "name":"Orange",
      "price":100,
      "image":"assets/image/fruit/orange.png",
      "color":AppColors.light_yellow,
      "color2":AppColors.dark_yellow,
      "des":"High in Vitamin C \nBoost immunity \nPrevents skin damage\nKeeps blood pressure in control \nBrings down cholesterol"
    },
    {
      "name": "Avocado",
      "price": 200,
      "image": "assets/image/fruit/Avocado.png",
      "color": AppColors.light_green,
      "color2":AppColors.dark_green,
      "des":"1. Avocados are nutrient rich\n2. Healthy for the heart\n3. Great for vision\n4. Osteoporosis prevention\n5. Cancer"
    },
    {
      "name": "Blackberry",
      "price": 70,
      "image": "assets/image/fruit/Blackberry.png",
      "color": AppColors.light_blue,
      "color2": AppColors.dark_blue,
      "des":"1. They're packed with vitamin C\n2. They're high in fiber\n3. Great source of vitamin K\n4. High in manganese\n5. May boost brain health"
    },
    {
      "name":"Apple",
      "price":150,
      "image":"assets/image/fruit/apple.png",
      "color":AppColors.light_r,
      "color2":AppColors.dark_r,
      "des":"1. Apples Are Nutritious\n2. Apples May Be Good for Weight Loss\n3. Apples May Be Good for Your Heart\n4. They're Linked to a Lower Risk of Diabetes\n5. They May Have Prebiotic Effects and Promote Good Gut Bacteri"
    },
    {
      "name": "Blueberry",
      "price": 90,
      "image": "assets/image/fruit/Blueberry.png",
      "color":AppColors.dark_blue,
      "color2":AppColors.light_blue,
      "des":"1. Low in Calories But High in Nutrients\n2. The King of Antioxidant Foods\n3. Reduce DNA Damage, Which May Help Protect Against Aging and Cancer\n4. Protect Cholesterol in Your Blood From Becoming Damaged\n5. May Lower Blood Pressure"
    },
    {
      "name": "Cherry",
      "price": 120,
      "image": "assets/image/fruit/cherry.png",
      "color": AppColors.dark_green,
      "color2":AppColors.light_green,
      "des":"1Relives Insomnia\n2.Facilitates Weight Loss\n3.Lowers Hypertension\n4.Prevents Cardiovascular Diseases\n5.Anti-Ageing Properties"
    },
    {
      "name":"Coconut",
      "price": 100,
      "image":"assets/image/fruit/Coconut.png",
      "color":AppColors.light_green ,
      "color2":AppColors.dark_green,
      "des":"1. Provides Good Fats\n2. Coconuts Enhances Weight Loss\n3. Keeps You Hydrated\n4. Improves Skin Health\n5. Coconuts Fight Bacteria"
    },
    {
      "name":"Dragon",
      "price": 200,
      "image":"assets/image/fruit/Dragon.png",
      "color":AppColors.light_pink,
      "color2":AppColors.dark_pink,
      "des":"1.Dragon fruit benefits for diabetes\n2.Dragon fruit benefits to boost your body metabolism\n3. Dragon fruit benefits for improved cardiovascular health\n4. Dragon fruit benefits for cancer prevention\n 5.Dragon fruit benefits as an anti-aging"
    },
    {
      "name":"Grapes",
      "price": 50,
      "image":"assets/image/fruit/grapes.png",
      "color":AppColors.light_p,
      "color2":AppColors.dark_p,
      "des":"1. Packed with nutrients\n2. May aid heart health\n3. High in antioxidants\n4. May have anticancer effects\n5. May protect against diabetes and lower blood sugar levels"
    },
    {
      "name":"Kiwi",
      "price": 210,
      "image":"assets/image/fruit/Kiwi.png",
      "color":AppColors.light_green,
      "color2":AppColors.dark_green,
      "des":"1.Kiwi Fruits Prevents Blood clotting \n2.Kiwi Fruits Can Help Asthma \n3.Kiwi Fruits Improves Digestion \n4.Kiwi Fruits Helps Regulate Blood Pressure\n5.Kiwi Fruits Reduces DNA Damage",
    },
    {
      "name":"Mango",
      "price": 150,
      "image":"assets/image/fruit/mango.png",
      "color":AppColors.light_y,
      "color2":AppColors.dark_y,
      "des":"1. High in Antioxidants\n2. May Boost Immunity\n3. May Support Heart Health\n4. Weight management options have evolved\n5. May Improve Digestive Health"
    },
    {
      "name":"Pineapple",
      "price": 180,
      "image":"assets/image/fruit/pineapple.png",
      "color":AppColors.dark_y,
      "color2":AppColors.light_y,
      "des":"Great Source of Healthy Carbs\n2.Improves Immunity\n3.Lowers Risk of Cancer\n4.It May Help Heal Wounds.\n5.Improves Gut Health"
    },
    {
      "name":"Strawberry",
      "price": 80,
      "image":"assets/image/fruit/strawberry.png",
      "color":AppColors.light_r,
      "color2":AppColors.dark_r,
      "des":"1.Give your immunity a boost\n2.Maintain your healthy vision\n3.Ward off cancer\n4.Improve skin’s resilience\n5.Lower your cholesterol"
    },
    {
      "name":"Watermelon",
      "price": 60,
      "image":"assets/image/fruit/Watermelon.png",
      "color":AppColors.dark_green,
      "color2":AppColors.light_green,
      "des":"1. Helps You Hydrate\n2. Contains Nutrients and Beneficial Plant Compounds\n3. Contains Compounds That May Help Prevent Cancer\n4. May Improve Heart Health\n.5. May Lower Inflammation and Oxidative Stress"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    void saveData(int index){
      dbHelper
          .insert(
        Cart(
          id: index,
          productId : index.toString(),
          productName : data[index]['name'],
          initialPrice: data[index]['price'],
          productPrice: data[index]['price'],
          quantity: ValueNotifier(1),
          // unitTag: data[index]['unit'],
          image: data[index]['image'], unitTag: '',

        ),
      )
          .then(
              (value){
            cart.addTotalPrice(data[index]['price'].toDouble());
            cart.addCounter();
            print('Product Added to Cart');
          }
      ).
      onError((error , stackTrace){
        print(error.toString());
      });
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
           children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: AppColors.gray,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.pink,
                ),
              ),
            ),
           Badge(
             badgeContent: Consumer<CartProvider>(
               builder: (context , value, child){
                 return Text(
                   value.getCounter().toString(),
                   style: const TextStyle(
                     color: Colors.white, fontWeight: FontWeight.bold
                   ),
                 );
               }
             ),
             position: BadgePosition.topEnd(),
             child: IconButton(
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
               },
               icon: const Icon(Icons.shopping_cart),
             ),
           ),
          ],
        ),
             const Text(
               "All Fruits",
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 30,
                 color: Colors.black,
               ),
             ),
             const SizedBox(height: 10,),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.black),
                   borderRadius: const BorderRadius.all(Radius.circular(20)),
                   ),
               child: const TextField(
                 cursorColor: AppColors.black,
                 style: TextStyle(color: AppColors.black, fontSize: 16),
                 decoration: InputDecoration(
                     icon: Icon(
                       Icons.search,
                       color: AppColors.black,
                     ),
                     hintText: "Search",
                     hintStyle: TextStyle(color: Colors.black87),
                     border: InputBorder.none),
               ),
             ),
             sliderImage(),
             const SizedBox(height: 20,),
             // allFruits(),
             // allFruit(),
        Expanded(
          child: ListView.builder(
              padding:  const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 8.0),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder:(context , index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(data[index]),));
                  },
                  child: Card(
                    color:  data[index]['color'],
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize:  MainAxisSize.max,
                        children: [
                          Image(image: AssetImage(data[index]['image']),height: 80,width: 80,),
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5.0,),
                                RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text: 'Name: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.00
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '${data[index]['name'].toString()}\n',
                                          style: const TextStyle(
                                              fontWeight:  FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Price:  ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: '${data[index]['price'].toString()}\u{20B9}\n',
                                            style:  const TextStyle(
                                                fontWeight:  FontWeight.bold
                                            )
                                        )
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:  Colors.red[800]),
                              onPressed: () {
                                saveData(index);
                              },
                              child: const Text('Add to Cart')
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
          ],
        ),
      ),
    );
  }
  Widget dailyFruits(){
    return
      Expanded(
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) { return Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data[index]["color"],
              ),
              child:Image(image:  AssetImage(data[index]["image"]),
                fit:BoxFit.contain,),
            ),
          ],
        );
        },
      ),
    );
  }
  Widget allFruits(){
    return   Expanded(child:

    GridView.builder(
      itemCount:  data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.00,
        crossAxisSpacing: 4.00,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(data[index]),));
        },
        child:
        Padding(
          padding: const EdgeInsets.all(15.00),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(data[index]["image"]),
                    fit: BoxFit.contain,
                  ),
                  color: data[index]["color"],
                  borderRadius: BorderRadius.circular(15.00),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  ""+data[index]["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.00,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  textAlign: TextAlign.right,
                  "\u{20B9}${data[index]['price']}/Kg",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
  Widget sliderImage(){
    return
         CarouselSlider(
             items: [
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8.00),
                   image: const DecorationImage(
                     image: AssetImage("assets/image/more/sale1.jpg"),
                     fit: BoxFit.cover,
                   )
                 ),
               ),
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8.00),
                     image: const DecorationImage(
                       image: AssetImage("assets/image/more/sale2.jpg"),
                       fit: BoxFit.cover,
                     )
                 ),
               ),
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8.00),
                     image: const DecorationImage(
                       image: AssetImage("assets/image/more/sale3.jpg"),
                       fit: BoxFit.cover,
                     )
                 ),
               ),
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8.00),
                     image: const DecorationImage(
                       image: AssetImage("assets/image/more/sale4.jpg"),
                       fit: BoxFit.cover,
                     )
                 ),
               ),
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8.00),
                     image: const DecorationImage(
                       image: AssetImage("assets/image/more/sale5.jpg"),
                       fit: BoxFit.cover,
                     )
                 ),
               ),
               Container(
                 margin: const EdgeInsets.all(6.00),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8.00),
                     image: const DecorationImage(
                       image: AssetImage("assets/image/more/sale6.jpg"),
                       fit: BoxFit.cover,
                     )
                 ),
               ),
             ],
             options:CarouselOptions(

               height: 180.0,
               enlargeCenterPage: true,
               autoPlay: true,
               aspectRatio: 16/9,
               autoPlayCurve:  Curves.fastOutSlowIn,
               enableInfiniteScroll: true,
               autoPlayAnimationDuration: const Duration(microseconds: 800),
               viewportFraction: 0.8,
             ),
    );
  }
   Widget allFruit(){
     return Expanded(
       child: ListView.builder(
          padding:  const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 8.0),
           shrinkWrap: true,
           itemCount: data.length,
           itemBuilder:(context , index){
            return Card(
              color:  data[index]['color'],
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize:  MainAxisSize.max,
                  children: [
                    Image(image: AssetImage(data[index]['image']),height: 80,width: 80,),
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0,),
                          RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.00
                                ),
                                children: [
                                  TextSpan(
                                    text: '${data[index]['name'].toString()}\n',
                                    style: const TextStyle(
                                      fontWeight:  FontWeight.bold
                                    ),
                                  ),
                                ],
                              )
                          ),
                          RichText(
                             maxLines: 1,
                              text: TextSpan(
                                text: 'Unit ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${data[index]['price'].toString()}\n',
                                    style:  const TextStyle(
                                      fontWeight:  FontWeight.bold
                                    )
                                  )
                                ]
                              ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:  data[index]['color2']),
                          onPressed: () {
                          // saveData(index);
                          },
                         child: const Text('Add to Cart')
                        ),
                  ],
                ),
              ),
            );
           }
       ),
     );
  }



}
