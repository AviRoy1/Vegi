import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/config/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  //const SingleDeliveryItem({Key key}) : super(key: key);
  final String title;
  final String address;
  final String number;
  final String addressType;
  SingleDeliveryItem({this.address,this.addressType,this.number,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(addressType,style: TextStyle(fontSize: 13,color: Colors.white),),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(height: 5,),
              Text(number),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}