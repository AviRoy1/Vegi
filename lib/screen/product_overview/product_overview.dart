import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/providers/wish_list_provider.dart';
import 'package:food_delivery/screen/review_cart/review_cart.dart';
import 'package:food_delivery/widgets/count.dart';
import 'package:provider/provider.dart';

enum SigninCharacter { fill, outline }

class ProductOverView extends StatefulWidget {
  // const ProductOverView({Key? key}) : super(key: key);

  final String productName;
  final String productImage;
  final String productId;
  final int productPrice;

  ProductOverView(
      {this.productId, this.productName, this.productImage, this.productPrice});

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  SigninCharacter _character = SigninCharacter.fill;

  Widget bottomNavigatorBar(
      {Color iconColor,
      Color backgroundColor,
      Color color,
      String title,
      Function onTap,
      IconData iconData}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 22,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList").doc(widget.productId)
        .get().then((value)  {
          if(value.exists)
          if(this.mounted) {
            setState(() {
              wishListBool = value.get("WishList");
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    int x = widget.productPrice;
   // getWishListBool();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Row(
        children: [
          bottomNavigatorBar(
              backgroundColor: Colors.black87,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Add to WishList",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                    wishListId: widget.productId,
                    wishListImage: widget.productImage,
                    wishListName: widget.productName,
                    wishListPrice: widget.productPrice,
                    wishListQuantity: 2,
                  );
                } else  {
                  wishListProvider.deleteWishList(widget.productId);
                }
              }),
          bottomNavigatorBar(
            backgroundColor: Color(0xffd1ad17),
            color: Colors.black87,
            iconColor: Colors.white70,
            title: "Go to Cart",
            iconData: Icons.shop_outlined,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReviewCart()));
            }
          ),
        ],
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Product Overview",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName),
                    
                    subtitle: Text("Rs.$x / 50gram"),
                  ),
                  Container(
                      height: 250,
                      padding: EdgeInsets.all(40),
                      child: Image.network(
                        widget.productImage,
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: SigninCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (SigninCharacter value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Text("Rs.${widget.productPrice}"),
                        Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                            ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 30,
                        //     vertical: 10,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //     ),
                        //     borderRadius: BorderRadius.circular(
                        //       30,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add,
                        //         size: 17,
                        //         color: Color(0xffd1ad17),
                        //       ),
                        //       Text(
                        //         "ADD",
                        //         style: TextStyle(color: Color(0xffd1ad17)),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: ListView(
                children: [
                  Text(
                    "About This Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "of a customer. Wikipedi In marketing, a product is an object or system made available for consumer use; it is anything that can be offered to a market to satisfy the desire or need of a customer. Wikipedi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
