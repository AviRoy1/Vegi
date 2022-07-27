import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/models/review_cart_model.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  OrderItem({this.e});
  bool isTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(e.cartImage,
      width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(e.cartName,style: TextStyle(color: Colors.grey[600]),),
          Text(e.cartUnit,style: TextStyle(color: Colors.grey[600]),),
          Text("${e.cartPrice}",),
        ],
      ),
      subtitle: Text(e.cartQuantity.toString()),
    );
  }
}