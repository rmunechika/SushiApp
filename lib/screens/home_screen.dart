import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/model/Sushi.dart';
import 'package:sushi_app/provider/SushiCounter.dart';

import '../provider/CartProvider.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Sushi> sushi = [];

  Future<void> getSushi() async {
    try {
      String dataSushiJson = await rootBundle.loadString('assets/sushi.json');
      List<dynamic> jsonMap = json.decode(dataSushiJson);

      setState(() {
        sushi = jsonMap.map((e) => Sushi.fromJson(e)).toList();
      });

      // Debug print to check if data is loaded
      print('Loaded sushi data: ${sushi.length} items');
    } catch (e) {
      // Print error if loading fails
      print('Error loading sushi data: $e');
    }
  }

  @override
  void initState() {
    getSushi();
    super.initState();
  }

  void navToDetScreen(Sushi sushiItem) {
    final sushiCounter = Provider.of<SushiCounter>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          sushi: sushiItem,
          sushiCount: sushiCounter.sushiCount,
        ),
      ),
    );
  }

  void navToCart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sushiman',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    navToCart();
                  },
                  icon: Icon(
                    Icons.shopping_bag_rounded,
                    size: 30,
                    color: Colors.black54,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: cartProvider.cart.length.toInt() > 0
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
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Promo Banner
            Container(
              height: 200,
              margin: EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage('assets/Decor1.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text(
                        'Get 78% Promo Sushi Pack',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search food',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            // Best Seller Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Best Seller',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (sushi.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => navToDetScreen(sushi[4]),
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.all(16),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(sushi[4].imgPath ?? ''),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTile(
                          title: Text(
                            sushi[4].name ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${sushi[4].price} IDR',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Popular Food Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular Food',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (sushi.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sushi.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => navToDetScreen(sushi[index]),
                            child: Container(
                              width: 150,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      sushi[index].imgPath ?? '',
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sushi[index].name ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${sushi[index].price} IDR',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '${sushi[index].rating}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (starIndex) => Icon(
                                                  starIndex <
                                                          sushi[index]
                                                              .rating!
                                                              .toInt()
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.yellow,
                                                  size: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
