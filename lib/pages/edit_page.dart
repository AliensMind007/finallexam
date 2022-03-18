import 'package:finallexam/models/exammodel.dart';
import 'package:finallexam/pages/home_page.dart';
import 'package:finallexam/services/mockservice.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, required this.examMoadel}) : super(key: key);
  static const String id = "edit_page";
  ExamMoadel examMoadel;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isLoading = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController objectNameController = TextEditingController();
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
    String username = userNameController.text.trim().toString();
    String something = somethingController.text.trim().toString();
    String objectname = objectNameController.text.trim().toString();
    String comment = commentController.text.trim().toString();
    String firstname = firstnameController.text.trim().toString();
    String lastname = lastnameController.text.trim().toString();
    ExamMoadel note = ExamMoadel(
        id: widget.examMoadel.id,
        username: username,
        comment: comment,
        objectname: objectname,
        something: something,
        firstname: firstname,
        lastname: lastname);
    await Network.PUT(Network.API_UPDATE+widget.examMoadel.id!, Network.bodyUpdate(note))
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
    userNameController.text = widget.examMoadel.username!;
    objectNameController.text = widget.examMoadel.objectname!;
    somethingController.text = widget.examMoadel.something!;
    commentController.text = widget.examMoadel.comment!;
    firstnameController.text = widget.examMoadel.firstname!;
    lastnameController.text = widget.examMoadel.lastname!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit page"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/boy6.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: userNameController,
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
                controller: objectNameController,
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
                "Edit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
