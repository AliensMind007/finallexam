import 'dart:math';

import 'package:finallexam/models/exammodel.dart';
import 'package:finallexam/pages/home_page.dart';
import 'package:finallexam/services/mockservice.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);
  static const String id = "CreatePage";

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isLoading = false;
  TextEditingController usernamerController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController objectnameController = TextEditingController();
  TextEditingController somethingController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  void _apiPostList() async {
    await Network.GET(Network.API_LIST, Network.paramsEmpty())
        .then((response) => {
              print(response!),
              _showResponse(response),
            });
  }

  void createList() async {
    String username = usernamerController.text.trim().toString();
    String something = somethingController.text.trim().toString();
    String objectname = objectnameController.text.trim().toString();
    String comment = commentController.text.trim().toString();
    String firstname = firstnameController.text.trim().toString();
    String lastname = lastnameController.text.trim().toString();
    ExamMoadel note = ExamMoadel(
        username: username,
        comment: comment,
        objectname: objectname,
        something: something,
        firstname: firstname,
        lastname: lastname);
    await Network.POST(Network.API_CREATE, Network.bodyCreate(note))
        .then((value) => {
              if (value != null) {_apiPostList()}
            });
    Navigator.pushNamed(context, HomePage.id);
  }
  // _random(){
  // var rng = Random();
  // for(var i = 0;i<=listimage.length;i++){
  //   var img = (rng.nextInt(100));
  // }
  // }
  // List listimage = ["assets/images/boy1.jpg","assets/images/boy6.jpg","assets/images/mansProfile.png"];

  void _showResponse(String response) {
    setState(() {
      // list = Network.parseResponse(response);
    });
  }

  String comment = '';
  String objectname = '';
  String something = '';
  String username = '';
  String firstname = '';
  String lastname = '';

  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("CreatePage"),
        elevation: 0,
        backgroundColor: Colors.white,
foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children:[ Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: AssetImage("assets/images/boy6.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(height: 30,width: 30, margin: EdgeInsets.only(top: 70,left: 70),
                    decoration: BoxDecoration(
borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade300,

                    ),
                    child: Icon(Icons.photo_camera_rounded)),
                ]
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: usernamerController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: "Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  // suffixIcon: Icon(Icons.star_border),
                  isCollapsed: false,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: objectnameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: "Relationship",
                  hintStyle: TextStyle(color: Colors.grey),
                  // suffixIcon: Icon(Icons.star_border),
                  isCollapsed: false,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: somethingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(15)),
                    // suffixIcon: Icon(Icons.remove_red_eye),
                    labelText: "number",
                    hintStyle: TextStyle(color: Colors.grey),
                    isCollapsed: false,
                  ),
                )),
            SizedBox(
              height: 150,
            ),
            MaterialButton(
              onPressed: () {
                createList();
              },
              color: Colors.blueAccent,
              height: 50,
              minWidth: 350,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
