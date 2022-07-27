import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/models/review_cart_model.dart';
import 'package:food_delivery/providers/review_cart_provider.dart';
import 'package:food_delivery/screen/check_out/delivery_details/delivery_details.dart';
import 'package:food_delivery/widgets/count.dart';
import 'package:food_delivery/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  ReviewCartProvider reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Review Cart"),
      content: Text("Would you like delete the item from Review Cart?"),
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
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    // print(reviewCartProvider.getReviewCardDataList.length);
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "Rs. ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(color: Colors.green[900]),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text("Submit"),
            color: Color(0xffd1ad17),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              if(reviewCartProvider.getReviewCardDataList.isEmpty) {
                return Fluttertoast.showToast(msg: "No Cart data found");
              }
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DeliveryDetails()));
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "Review Cart",
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getReviewCardDataList.isEmpty
          ? Center(
              child: Text("No Data"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCardDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCardDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      wishList: false,
                      isBool: true,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      productUnit: data.cartUnit,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
