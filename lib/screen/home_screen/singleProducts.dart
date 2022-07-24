import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/config/colors.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/widgets/count.dart';
import 'package:food_delivery/widgets/pruduct_unit.dart';

class singleProducts extends StatefulWidget {
  // const singleProducts({Key? key}) : super(key: key);

  final String productImage;
  final String productName;
  final int productPrice;
  final Function onTap;
  final String productId;
  final ProductModel productUnit;

  singleProducts(
      {this.productUnit,
        this.productName,
      this.productImage,
      this.onTap,
      this.productPrice,
      this.productId});

  @override
  State<singleProducts> createState() => _singleProductsState();
}

class _singleProductsState extends State<singleProducts> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 230,
            width: 165,
            decoration: BoxDecoration(
                color: Color(0xffd9dad9),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(widget.productImage),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rs.${widget.productPrice}/ ${unitData==null ? firstValue : unitData}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                       context: context,
                                       builder: (context) {
                                         return Column(
                                           mainAxisSize: MainAxisSize.min,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: widget.productUnit.productUnit.map<Widget>((data){
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                  child: InkWell(
                                                    onTap: () async{
                                                      setState(() {
                                                        unitData = data;
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      data,
                                                      style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                           }).toList(),
                                          
                                         );
                                       });
                                },
                                title: unitData==null ? firstValue : unitData,
                              ),
                              
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                              productUnit: unitData==null ? firstValue : unitData,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
