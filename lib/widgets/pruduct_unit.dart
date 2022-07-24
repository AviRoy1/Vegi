import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductUnit extends StatelessWidget {
  // const ProductUnit({Key key}) : super(key: key);
  final Function onTap;
  final String title;
  ProductUnit({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              '$title',
              style: TextStyle(fontSize: 9),
            )),
            Expanded(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
