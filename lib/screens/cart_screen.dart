import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/provider/CartProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double price = 0;
    double sumPrice = 0;
    double taxAndService = 0;
    double sumPayment = 0;

    return Consumer<CartProvider>(builder: (context, value, child) {
      for (var cartModel in value.cart) {
        price = double.parse(cartModel.quantity.toString()) *
            double.parse(cartModel.price.toString());
        sumPrice = price;

        taxAndService = (sumPrice * 0.11).toDouble();
        sumPayment = (sumPrice + taxAndService).toDouble();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: [
            IconButton(
                onPressed: () {
                  value.clearCart();
                  setState(() {
                    price = 0;
                    sumPrice = 0;
                    taxAndService = 0;
                    sumPayment = 0;
                  });
                },
                icon: Row(
                  children: [
                    Text('Clear Cart'),
                    SizedBox(width: 10),
                    Icon(Icons.delete),
                  ],
                ))
          ],
        ),
        body: value.cart.isEmpty
            ? Center(child: Text('Cart is Empty'))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: value.cart.length,
                    itemBuilder: (context, index) {
                      final sushi = value.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(sushi.imgPath.toString()),
                                      fit: BoxFit.cover),
                                )),
                            title: Row(children: [
                              Text(sushi.name.toString()),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    value.removeItem(value.cart[index]);
                                    if (value.cart.isEmpty) {
                                      price = 0;
                                      sumPrice = 0;
                                      taxAndService = 0;
                                      sumPayment = 0;
                                      setState(() {});
                                    } else {
                                      context.read<CartProvider>();
                                    }
                                  },
                                  icon:
                                      Icon(Icons.remove_circle_outline_rounded))
                            ]),
                            subtitle: Row(
                              children: [
                                Text('IDR ' + '${sushi.price}'),
                                Spacer(),
                                Text(' x' + '${sushi.quantity}'),
                                SizedBox(width: 14),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        bottomNavigationBar: price == 0
            ? null
            : Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price'),
                              Text('IDR ' + '$price'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax and Service'),
                              Text('IDR ' + '$taxAndService'),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Price'),
                              Text('IDR ' + '$sumPayment'),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.red,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay Now',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
      );
    });
  }
}
