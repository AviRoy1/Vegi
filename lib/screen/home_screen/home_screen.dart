// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/providers/product_provider.dart';
import 'package:food_delivery/providers/user_provider.dart';
import 'package:food_delivery/screen/home_screen/drawer_screen.dart';
import 'package:food_delivery/screen/home_screen/singleProducts.dart';
import 'package:food_delivery/screen/product_overview/product_overview.dart';
import 'package:food_delivery/screen/review_cart/review_cart.dart';
import 'package:food_delivery/screen/search/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key key}) : super(key: key);

  ProductProvider productProvider;

  @override
  Widget _buildHerbsProducts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Herbs Seasonings',
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Search(
                          search: productProvider.getHerbsProductDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getHerbsProductDataList.map(
              (herbsProductData) {
                return singleProducts(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductOverView(
                          
                              productName: herbsProductData.productName,
                              productPrice: herbsProductData.productPrice,
                              productImage: herbsProductData.productImage,
                            )));
                  },
                  productId: herbsProductData.productId,
                  productPrice: herbsProductData.productPrice,
                  productImage: herbsProductData.productImage,
                  productName: herbsProductData.productName,
                  productUnit: herbsProductData,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFruitsProducts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Fresh Fruits',
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Search(
                          search: productProvider.getFruitsProductDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getFruitsProductDataList.map(
              (fruitsProductData) {
                return singleProducts(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductOverView(
                              productId: fruitsProductData.productId,
                              
                              productName: fruitsProductData.productName,
                              productImage: fruitsProductData.productImage,
                              productPrice: fruitsProductData.productPrice,
                            )));
                  },
                  productId: fruitsProductData.productId,
                  productName: fruitsProductData.productName,
                  productImage: fruitsProductData.productImage,
                  productPrice: fruitsProductData.productPrice,
                  productUnit: fruitsProductData,
                );
              },
            ).toList(),

            // children: [
            //

            // ],
          ),
        ),
      ],
    );
  }

  Widget _buildVegitablesProducts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Fresh Fruits',
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Search(
                          search: productProvider.getVegitablesProductDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getVegitablesProductDataList
                .map((vegitablesProductData) {
              return singleProducts(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductOverView(
                            productId: vegitablesProductData.productId,
                            productName: vegitablesProductData.productName,
                            productImage: vegitablesProductData.productImage,
                            productPrice: vegitablesProductData.productPrice,
                          )));
                },
                productId: vegitablesProductData.productId,
                productName: vegitablesProductData.productName,
                productImage: vegitablesProductData.productImage,
                productPrice: vegitablesProductData.productPrice,
                productUnit: vegitablesProductData,

              );
            }).toList(),
            // children: [
            //

            // ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();
    productProvider.fatchFruitsProductData();
    productProvider.fatchVegitablesProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      drawer: DrawerSide(userProvider: userProvider),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffd1ad17),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      search: productProvider.getAllProductSearch,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: GestureDetector(
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReviewCart()));
            },
              child: CircleAvatar(
                backgroundColor: Color(0xffd1ad17),
                radius: 20,
                child: Icon(
                  Icons.shop_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 199, 170, 51),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://media.istockphoto.com/photos/vegetarian-food-in-string-bag-picture-id1311051864?k=20&m=1311051864&s=612x612&w=0&h=Y2RT33vB22QtNWFbcRSaesd_D8CEoW1wbR5r4e8rCuk='),
                  ),
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // color: Colors.red,
                        child: Column(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 130, bottom: 10),
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Vegi',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.green,
                                          blurRadius: 3,
                                          offset: Offset(3, 3),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '30% Off',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.green[100],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'On all fruits and vegetables',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          // _buildHerbsProducts(context),
            _buildFruitsProducts(context),
            _buildVegitablesProducts(context),
            _buildFruitsProducts(context),
          ],
        ),
      ),
    );
  }
}
