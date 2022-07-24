import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/providers/user_provider.dart';
import 'package:food_delivery/screen/home_screen/home_screen.dart';
import 'package:food_delivery/screen/my_profile/my_profile.dart';
import 'package:food_delivery/screen/review_cart/review_cart.dart';
import 'package:food_delivery/screen/wishList/wish_list.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({this.userProvider});
  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  // const DrawerSide({Key? key}) : super(key: key);
  Widget listTile({String title, IconData icon, Function onTap}) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Color(0xffd1ad17),
        child: ListView(
          children: [
            DrawerHeader(
              // ignore: prefer_const_literals_to_create_immutables
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.yellow,
                        backgroundImage: NetworkImage(
                          userData.userImage ??
                          "https://s3.envato.com/files/328957910/vegi_thumb.png",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData.userName),
                        Text(userData.userEmail,overflow: TextOverflow.ellipsis,),
                      ],
                    )
                  ],
                ),
              ),
            ),
            listTile(
              icon: Icons.home,
              title: "Home",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => HomeScreen()),
                ));
              },
            ),
            listTile(
              icon: Icons.shopping_cart_checkout_rounded,
              title: "Review Card",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => ReviewCart()),
                ));
              },
            ),
            listTile(
              icon: Icons.person_outline,
              title: "My Profile",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyProfile(userProvider: widget.userProvider,)),
                );
              },
            ),
            listTile(
                icon: Icons.notification_add_outlined, title: "Notification"),
            listTile(icon: Icons.star_outlined, title: "Rating & Review"),
            listTile(
              icon: Icons.favorite_outline, 
              title: "Wishlist",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WishList()),
                );
              }
              ),
            listTile(
              icon: Icons.copy_outlined, 
              title: "Raise a Complaint",
              
              ),
            listTile(icon: Icons.format_quote_sharp, title: "FAQs"),
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Support",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Call us: "),
                      SizedBox(
                        width: 12,
                      ),
                      Text("+918442917090",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Mail us: "),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "ravijit512@gmail.com",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
