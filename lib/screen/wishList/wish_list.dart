import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/models/review_cart_model.dart';
import 'package:food_delivery/providers/review_cart_provider.dart';
import 'package:food_delivery/providers/wish_list_provider.dart';
import 'package:food_delivery/widgets/count.dart';
import 'package:food_delivery/widgets/single_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
WishListProvider wishListProvider;
showAlertDialog(BuildContext context,ProductModel delete) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
      wishListProvider.deleteWishList(delete.productId);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("WishList Product"),
    content: Text("Would you like delete the item from WishList Product?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

 // const ReviewCart({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "WishList",
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
      ),
      body:  
       ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context,index) {
          ProductModel data =  wishListProvider.getWishList[index];
          return Column(
            children: [
              SizedBox(
            height: 10,
          ),
          
          SingleItem(
            productImage: data.productImage,
            productName: data.productName,
            productPrice: data.productPrice,
            productId: data.productId,
            productQuantity: data.productQuantity,
            onDelete: () {
              showAlertDialog(context,data);
            },
            isBool: true,
          ),
            ],
          );
        },
      ),
    );
  }
}
