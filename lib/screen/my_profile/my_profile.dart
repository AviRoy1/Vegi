import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/providers/user_provider.dart';
import 'package:food_delivery/screen/home_screen/drawer_screen.dart';


class MyProfile extends StatefulWidget {
  UserProvider userProvider;
  MyProfile({this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile({IconData icon,String title}) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Scaffold(
      backgroundColor: Color(0xffd1ad17),
      appBar: AppBar(
        backgroundColor: Color(0xffd1ad17),
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      drawer: DrawerSide(userProvider: widget.userProvider ),
      body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: Color(0xffd1ad17),
                ),
                Container(
                  height: 484,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffcbcbcb),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end ,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: EdgeInsets.only(left: 20),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                      userData.userName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    SizedBox(height: 10,),
                                    Text(userData.userEmail),
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor:  Color(0xffd1ad17),
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.edit,color:  Color(0xffd1ad17),),
                                  backgroundColor: Color(0xffcbcbcb),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      listTile(
                        icon: Icons.shop_outlined,
                        title: "My Orders",
                      ),
                      listTile(
                        icon: Icons.location_on_outlined,
                        title: "My Delivery Address",
                      ),
                      listTile(
                        icon: Icons.person_outlined,
                        title: "Refer Friends",
                      ),
                      listTile(
                        icon: Icons.file_copy_outlined,
                        title: "Terms & Conditions",
                      ),
                      listTile(
                        icon: Icons.policy_outlined,
                        title: "Privacy Policy",
                      ),
                      listTile(
                        icon: Icons.add_card_outlined,
                        title: "About",
                      ),
                      listTile(
                        icon: Icons.exit_to_app_outlined,
                        title: "Log Out",
                      ),

                    ],
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 30),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffd1ad17),
                // ignore: prefer_const_constructors
                child: CircleAvatar(
                  backgroundImage: NetworkImage( userData.userImage ?? "https://s3.envato.com/files/328957910/vegi_thumb.png"),
                  radius: 45,
                  backgroundColor: Color(0xffcbcbcb),
                ),
              ),
            ),
          ],
      ),
    );
  }
}