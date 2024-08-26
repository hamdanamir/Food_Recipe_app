import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:food_recipe_app/modal.dart';
import 'package:food_recipe_app/recipeview.dart';
import 'package:food_recipe_app/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}
class _homeState extends State<home> {
  bool isloading = true;
  List<RecipeModal> recipeList = <RecipeModal>[];
  TextEditingController searchcontroller = new TextEditingController();
  List recipecatlist = [
    {
      "ImageUrl":
          "https://images.unsplash.com/photo-1680993032090-1ef7ea9b51e5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGFhbCUyMGNod2FsfGVufDB8fDB8fHww",
      "heading": "Chilli Food"
    }
  ];
  getrecipe(String querry) async {
    String url =
        "https://api.edamam.com/search?q=$querry&app_id=23c0621e&app_key=67c36c533bc7f157a49448dae09c348e"; // Replace with your URL
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data.toString());
    // developer.log(data.toString());
    data["hits"].forEach((element) {
      RecipeModal recipemodal = new RecipeModal();
      recipemodal = RecipeModal.fromMap(element["recipe"]);
      recipeList.add(recipemodal);
      setState(() {
        isloading = false;
      });
      // developer.log(recipeList.toString());
    });
    recipeList.forEach((recipe) {
      print(recipe.applable);
      // print(recipe.appclories);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getrecipe("ice cream");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //stack use in this purpose for background
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff213A50),
              Color(0xff071938),
            ])),
          ),
          //inkwell used for tap double tap gestures etc. or gesture detetctor
          //card = elevation properity.background color or border radius properity
          //cliprreact= clip round rectangle use for clip any thing in round
          //clippath=use for different types of frames like circle rectangles or custom clips
          //positioned= use at specific positioned and use in stack
          SingleChildScrollView(
            child: Column(
              children: [
                //search bar
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchcontroller.text).replaceAll(" ", "") ==
                                "") {
                              print("blank search");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          search(searchcontroller.text)));
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: Icon(
                                Icons.search,
                                color: Colors.blue,
                              )),
                        ),
                        Expanded(
                            child: TextField(
                          controller: searchcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Let,s cock something"),
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What Do You Want To Cook Today?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's CookSomething New!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: isloading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => recipeview(
                                            recipeList[index].appurl??'')));
                              },
                              child: Card(
                                margin: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        recipeList[index]?.appimageurl ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            recipeList[index].applable!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurpleAccent,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size: 25,
                                                  ),
                                                  Text(
                                                    recipeList[index]
                                                        .appclories
                                                        .toString()
                                                        .substring(0, 6),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
                Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: recipecatlist.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => search(recipecatlist[index]["heading"])));
                            },
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: Image.network(
                                      recipecatlist[index]["ImageUrl"],
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: 250,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            recipecatlist[index]["heading"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget hamdan() {
  return Text("hello hamdan");
}
