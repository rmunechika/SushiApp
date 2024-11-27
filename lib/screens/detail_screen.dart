import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/model/Sushi.dart';
import 'package:sushi_app/provider/CartProvider.dart';
import 'package:sushi_app/provider/SushiCounter.dart';
import 'package:sushi_app/screens/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final Sushi sushi;
  final int sushiCount;

  const DetailScreen({
    super.key,
    required this.sushi,
    required this.sushiCount,
  });

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFav = false;

  double? get price => null;

  void addToCart() {
    final sushiCounter = Provider.of<SushiCounter>(context, listen: false);
    if (sushiCounter.sushiCount > 0) {
      final cart = context.read<CartProvider>();
      cart.addToCart(widget.sushi, sushiCounter.sushiCount);
    }
    sushiCounter.reset();
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        showDragHandle: true,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Awesome !',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.sushi.name}' +
                        ' was added to cart, would you like add more ?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                            navToCart();
                          },
                          heroTag: 'toCart',
                          backgroundColor: Colors.redAccent,
                          elevation: 0,
                          child: Text(
                            'View Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          heroTag: 'pop',
                          backgroundColor: Colors.redAccent,
                          elevation: 0,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  void navToCart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final sushiCounter = Provider.of<SushiCounter>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.sushi.name.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    navToCart();
                  },
                  icon: Icon(Icons.shopping_bag_rounded,
                      color: Colors.white, size: 30)),
              Positioned(
                  right: 0,
                  child: cartProvider.cart.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints:
                              BoxConstraints(minHeight: 12, minWidth: 12),
                          child: Text(
                            '${cartProvider.cart.length}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container())
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.sushi.imgPath.toString(),
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.sushi.name.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFav = !isFav;
                          });
                        },
                        icon: Icon(
                          isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 32,
                        ),
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.sushi.price} IDR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${widget.sushi.rating}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < widget.sushi.rating!.toInt()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.sushi.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.redAccent,
        height: 70,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'a',
              backgroundColor: Colors.red,
              elevation: 0,
              onPressed: () {
                sushiCounter.removeItem(widget.sushi.price!.toDouble());
              },
              child: Icon(Icons.remove, color: Colors.white),
            ),
            SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'b',
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              child: Text(
                '${sushiCounter.sushiCount}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'c',
              backgroundColor: Colors.red,
              elevation: 0,
              onPressed: () {
                sushiCounter.addItem(widget.sushi.price!.toDouble());
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: FloatingActionButton(
                heroTag: 'd',
                onPressed: () {
                  addToCart();
                },
                backgroundColor: Colors.red,
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'IDR ${sushiCounter.sumPrice}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_right_alt_rounded,
                          size: 32, color: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
