import 'package:flutter/material.dart';
import 'package:food_delivery/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery/config/colors.dart';
import 'package:food_delivery/providers/product_provider.dart';
import 'package:food_delivery/providers/review_cart_provider.dart';
import 'package:food_delivery/providers/user_provider.dart';
import 'package:food_delivery/providers/wish_list_provider.dart';
import 'package:food_delivery/screen/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider<ProductProvider>(
      create: (context)=> ProductProvider(),),
      ChangeNotifierProvider< UserProvider>(
      create: (context)=> UserProvider(),),
      ChangeNotifierProvider< ReviewCartProvider>(
      create: (context)=> ReviewCartProvider(),),
      ChangeNotifierProvider<WishListProvider> (
        create: (context)=> WishListProvider(),
      ),
    ],
      child: MaterialApp(
         theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      ),
    );
  }
}
