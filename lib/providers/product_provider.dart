
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/models/product_model.dart';

class ProductProvider with ChangeNotifier {

    ProductModel productModel;

  List<ProductModel> search = [];

    productModels(QueryDocumentSnapshot element) {
      productModel = ProductModel(
          productImage: element.get("productImage"),
          productName: element.get("productName"),
           productPrice: element.get("productPrice"),
           productId: element.get("productId"),
           productUnit: element.get("productUnit"),
      );
      search.add(productModel);
    }


//////////////  herbsProduct   /////////////////////////
  List<ProductModel> herbsProductList = [];

  fatchHerbsProductData() async {
      List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance.collection("HerbsProduct").get();
    value.docs.forEach(
      (element) { 
          productModels(element);
            newList.add(productModel);
    },
    );
     herbsProductList = newList;
     notifyListeners();
  }

   List<ProductModel>get getHerbsProductDataList {
     return herbsProductList;
  }


//////////////  Fruits   /////////////////////////

List<ProductModel> fruitsProductList = [];

  fatchFruitsProductData() async {
      List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance.collection("FruitsProduct").get();
    value.docs.forEach(
      (element) { 
        productModels(element);
          newList.add(productModel);
    },
    );
     fruitsProductList = newList;
     notifyListeners();
  }

   List<ProductModel>get getFruitsProductDataList {
     return fruitsProductList;
  }


  /////////////   Vegitable Products   ///////////////////////
  
  List<ProductModel> vegitablesProductList = [];

  fatchVegitablesProductData() async {
      List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance.collection("VegitablesProduct").get();
    value.docs.forEach(
      (element) { 
       // print(element.data());
         productModels(element);
          newList.add(productModel);
    },
    );
     vegitablesProductList = newList;
     notifyListeners();
  }

   List<ProductModel>get getVegitablesProductDataList {
     return vegitablesProductList;
  }

    List<ProductModel> get getAllProductSearch {
        return search;
    }

}
