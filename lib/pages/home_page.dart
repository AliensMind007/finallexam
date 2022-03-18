import 'package:finallexam/models/exammodel.dart';
import 'package:finallexam/pages/create_page.dart';
import 'package:finallexam/pages/edit_page.dart';
import 'package:finallexam/services/hive.dart';
import 'package:finallexam/services/mockservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool isLoading = false;
  List<ExamMoadel> postes = [];
  List listimage = ["assets/images/boy1.jpg","assets/images/boy6.jpg","assets/images/mansProfile.png"];
  @override
  void initState() {
    // TODO: implement initState
    _apiPostList();
  }

  void _apiPostList() {
    // isLoading = true;
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          print(response!),
          _resPostList(response),
        });
  }

  void _resPostList(String response) {
    List<ExamMoadel> list = Network.parseResponse(response);
    postes.clear();
    setState(() {
      postes = list;
    });
  }

  void _apiPostDelete(ExamMoadel post) {
    Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => {
              _resPostDelete(response),
            });
  }

  void _resPostDelete(String? response) {
    setState(() {
      isLoading = false;
    });
    if (response != null) _apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){

        },
        icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Beneficiary"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric( horizontal: 10),
        child: isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade100,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Search",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
                SizedBox(height: 20,),
                Container(margin: EdgeInsets.symmetric(horizontal: 15,), child: Text("Recipients",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 30),)),
                    SizedBox(height: 20,),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: postes.length,
                        itemBuilder: (context, index) {
                          return cardUI(postes[index], index);
                        }),
                    SizedBox(height: 50,),
                    Center(child: Text("Long press for edit !",style: TextStyle(color: Colors.grey.shade200,fontSize: 30,fontWeight: FontWeight.bold),))
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, CreatePage.id);
                    //   },
                    //   child: Container(
                    //     height: 220,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey.shade200,
                    //         border: Border.all(color: Colors.grey.shade400),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           CupertinoIcons.add_circled,
                    //           size: 30,
                    //         ),
                    //         SizedBox(
                    //           height: 15,
                    //         ),
                    //         Text("Create new something")
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: (){
          Navigator.pushNamed(context, CreatePage.id);
        },child: Icon(Icons.add,size: 50,),

      ),
    );
  }

  Widget cardUI(ExamMoadel post, int index,) {
    return Dismissible(
      key: UniqueKey(),
        onDismissed: (_) async {
          postes.remove(post);
          HiveDB.storeSavedCards(postes);
          await Network.DEL(Network.API_DELETE + post.id!, Network.paramsEmpty());
        },
      child: GestureDetector(
        onTap: () {

        },
        onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditPage(examMoadel: postes[index]);
        }));},
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: <Widget>[
              Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                      post.username!.length>4 ? listimage[1]:listimage[0]),
                      fit: BoxFit.cover)),
                    ),

              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                 post.username.toString(),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width -
                        220,
                    child: Text(
                    post.something.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,fontWeight: FontWeight.bold),

                    ),
                  ),
                ],
              ),
             MaterialButton(onPressed: (){},
             child: Text("Send",style: TextStyle(color: Colors.white),),
               color: Colors.blueAccent,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
             )
            ],
          ),
        ),
      ),
    );
  }
}
