import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/config/colors.dart';
import 'package:food_delivery/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
 // const CustomGoogleMap({Key key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => Custom_GoogleMapState();
}

class Custom_GoogleMapState extends State<CustomGoogleMap> {

  LatLng _initialcameraposition = LatLng(22.5726,88.3639);
  GoogleMapController controller;
  Location _location = Location(); 
  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) { 
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.latitude,event.longitude),
            zoom: 15
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                mapToolbarEnabled: true,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 60,left: 10,bottom: 40,top: 40),
                    child: MaterialButton(
                      onPressed: () async{
                        await _location.getLocation().then((value) {
                          setState(() {
                            checkoutProvider.setLoaction =  value;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      color: primaryColor,
                      child: Text("Set Location"),
                      shape: StadiumBorder(),
                    ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}