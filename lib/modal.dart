import 'package:flutter/cupertino.dart';

class RecipeModal {
   String? applable;
   String? appimageurl;
   double? appclories;
   String? appurl;
  RecipeModal({this.applable,this.appimageurl,this.appclories,this.appurl});
  factory RecipeModal.fromMap(Map recipe)
  {
    return RecipeModal(
      applable: recipe["label"],
      appclories: recipe["calories".toString()],
      appimageurl: recipe["image"],
      appurl: recipe["url"],
    );
  }
}