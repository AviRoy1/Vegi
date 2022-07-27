import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/config/colors.dart';
import 'package:food_delivery/providers/check_out_provider.dart';
import 'package:food_delivery/screen/check_out/google_map/google_map.dart';
import 'package:food_delivery/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labelText: "First name",
              controller: checkoutProvider.firstName,
            ),
            CustomTextField(
              labelText: "Last name",
              controller: checkoutProvider.lastName,
            ),
            CustomTextField(
              labelText: "Mobile No",
              controller: checkoutProvider.mobileNo,
            ),
            CustomTextField(
              labelText: "Alternate Mobile No",
              controller: checkoutProvider.alternateMobileNo,
            ),
            CustomTextField(
              labelText: "Scoiety",
              controller: checkoutProvider.scoiety,
            ),
            CustomTextField(
              labelText: "Street",
              controller: checkoutProvider.street,
            ),
            CustomTextField(
              labelText: "Landmark",
              controller: checkoutProvider.landmark,
            ),
            CustomTextField(
              labelText: "City",
              controller: checkoutProvider.city,
            ),
            CustomTextField(
              labelText: "Aera",
              controller: checkoutProvider.aera,
            ),
            CustomTextField(
              labelText: "Pincode",
              controller: checkoutProvider.pincode,
            ),
            InkWell(
              onTap: () {
               Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CustomGoogleMap(),
                  ),
                );
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null? Text("Set Loaction"):
                    Text("Done!"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.work,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: Icon(
                Icons.devices_other,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}