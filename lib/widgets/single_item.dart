import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/config/colors.dart';
import 'package:food_delivery/providers/review_cart_provider.dart';
import 'package:food_delivery/widgets/count.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  //const SearchItem({Key key}) : super(key: key);

  bool isBool = false;
  bool wishList = false;
  String productImage;
  String productName;
  int productPrice;
  String productId;
  int productQuantity;
  Function onDelete;
  var productUnit;

  SingleItem(
      {this.wishList,
      this.productUnit,
      this.onDelete,
      this.isBool,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productId,
      this.productQuantity});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider reviewCartProvider;

  int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  // @override
  // void initState() {
  //   getCount();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
   // print(count);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(widget.productImage),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rs.${widget.productPrice}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: new Text('50 gram'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('250 gram'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('500 gram'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: new Text('1 kg'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.productUnit,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: Color(0xffd1ad17),
                                    )),
                                  ],
                                ),
                              ),
                            )
                          : Text(widget.productUnit),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  padding: widget.isBool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  child: widget.isBool == false
                      ? Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: widget.onDelete,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              widget.wishList == false
                                  ? Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if(count==1) {
                                                  Fluttertoast.showToast(msg: "You reach minimum limit");
                                                } else {
                                                  setState(() {
                                                    count--;
                                                  });
                                                  reviewCartProvider.updateReviewCartData(
                                                    cartImage: widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName: widget.productName,
                                                    cartQuantity: count,
                                                    cartPrice: widget.productPrice,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: Color(0xffd1ad17),
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              "$count",
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if(count < 10) {
                                                  setState(() {
                                                    count++;
                                                  });
                                                  reviewCartProvider.updateReviewCartData(
                                                    cartImage: widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName: widget.productName,
                                                    cartQuantity: count,
                                                    cartPrice: widget.productPrice,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xffd1ad17),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }
}
