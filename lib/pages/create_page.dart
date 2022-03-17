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
  TextEditingController usernamerController =
  TextEditingController();
  TextEditingController commentController =
  TextEditingController();
  TextEditingController objectnameController =
  TextEditingController();
  TextEditingController somethingController =
  TextEditingController();
  TextEditingController firstnameController =
  TextEditingController();
  TextEditingController lastnameController =
  TextEditingController();


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
      appBar: AppBar(
        title: Text("CreatePage"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
controller: usernamerController,
              decoration: InputDecoration(
                hintText: "username"
              ),
            ),SizedBox(height: 20,),
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                  hintText: "comment"
              ),
            ),SizedBox(height: 20,), TextFormField(
              controller: objectnameController,
              decoration: InputDecoration(
                  hintText: "objectname"
              ),
            ),SizedBox(height: 20,), TextFormField(
              controller: somethingController,
              decoration: InputDecoration(
                  hintText: "something"
              ),
            ),SizedBox(height: 20,), TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(
                  hintText: "firstname"
              ),
            ),SizedBox(height: 20,), TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                  hintText: "lastname"
              ),
            ),SizedBox(height: 50,),
            MaterialButton(onPressed: (){
              createList();
            },color: Colors.orange,
            child: Text("Create"),)
          ],
        ),
      ),
    );
  }
}
