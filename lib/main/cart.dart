import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/detail/sqflite_database.dart';
import 'package:projectflutter/main/home.dart';
import 'package:projectflutter/model/CartProvider.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBHelper? dbHelper = DBHelper();
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Badge(
                    badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.getCounter().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    position: BadgePosition.topEnd(),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart, color: Colors.pink),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.pink),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(
                      Icons.navigate_before,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (BuildContext context, provider, widget) {
                  if (provider.cart.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your Cart is Empty',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: provider.cart.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            height: 70,
                            color: Colors.pinkAccent[100],
                            child: Padding(
                              padding: EdgeInsets.all(4.00),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  Image(
                                    height: 80,
                                    width: 80,
                                    image:
                                        AssetImage(provider.cart[index].image!),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: 'Name: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.00),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${provider.cart[index].productName!}\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        RichText(
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: 'Price: ' r"$",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.00),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${provider.cart[index].productPrice!}\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  // ValueListenableBuilder<int>(
                                  //     valueListenable:
                                  //         provider.cart[index].quantity!,
                                  //     builder: (context, val, child) {
                                  //       return PlusMinusButtons(
                                  //         addQuantity: () {
                                  //           cart.addQuantity(
                                  //               provider.cart[index].id!);
                                  //           dbHelper!
                                  //               .updateQuantity(Cart(
                                  //                   id: index,
                                  //                   productId: index.toString(),
                                  //                   productName: provider
                                  //                       .cart[index]
                                  //                       .productName,
                                  //                   initialPrice: provider
                                  //                       .cart[index]
                                  //                       .initialPrice,
                                  //                   productPrice: provider
                                  //                       .cart[index]
                                  //                       .productPrice,
                                  //                   quantity: ValueNotifier(
                                  //                       provider.cart[index]
                                  //                           .quantity!.value),
                                  //                   unitTag: provider
                                  //                       .cart[index].unitTag,
                                  //                   image: provider
                                  //                       .cart[index].image))
                                  //               .then((value) {
                                  //             setState(() {
                                  //               cart.addTotalPrice(double.parse(
                                  //                   provider.cart[index]
                                  //                       .productPrice
                                  //                       .toString()));
                                  //             });
                                  //           });
                                  //         },
                                  //         deleteQuantity: () {
                                  //           cart.deleteQuantity(
                                  //               provider.cart[index].id!);
                                  //           cart.removeTotalPrice(double.parse(
                                  //               provider
                                  //                   .cart[index].productPrice
                                  //                   .toString()));
                                  //         },
                                  //         text: val.toString(),
                                  //       );
                                  //     }),
                                  IconButton(
                                      onPressed: () {
                                        dbHelper!.deleteCartItem(
                                            provider.cart[index].id!);
                                        provider.removeItem(
                                            provider.cart[index].id!);
                                        provider.removeCounter();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        // color: Colors.red.shade800,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            Consumer<CartProvider>(
              builder: (BuildContext context, value, Widget? child) {
                final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                for (var element in value.cart) {
                  totalPrice.value =
                      (element.productPrice! * element.quantity!.value) +
                          (totalPrice.value ?? 0);
                }
                return Column(
                  children: [
                    ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          return ReusableWidget(
                              title: 'Sub-Total',
                              value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                        }),
                  ],
                );
              },
            )
          ],
        ),
        // ]
        // ),
        bottomNavigationBar: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment Successful'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            color: Colors.yellow.shade600,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'Proceed to Pay',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
