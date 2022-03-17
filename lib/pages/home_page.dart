import 'package:finallexam/models/exammodel.dart';
import 'package:finallexam/pages/create_page.dart';
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

  String greeting() {
    if (DateTime.now().hour >= 6 && DateTime.now().hour < 12) {
      return " Good Morning,";
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      return " Good Afternoon,";
    } else {
      return " Good Evening,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.cyanAccent,
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 30),
                        title: RichText(
                          text: TextSpan(
                              text: greeting(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "\n Abdulbariy",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500))
                              ]),
                        ),
                        trailing: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Text("hello"),
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: postes.length,
                        itemBuilder: (context, index) {
                          return cardUI(postes[index], index);
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CreatePage.id);
                      },
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.add_circled,
                              size: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Create new something")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
        ],
      ),
    );
  }

  Widget cardUI(ExamMoadel post, int index) {
    return Dismissible(
      key: const ValueKey(0),
      onDismissed: (_) async {
        postes.remove(post);
        // HiveDB.storeSavedCards(cards);
        await Network.DEL(Network.API_DELETE + post.id!, Network.paramsEmpty());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            border: Border.all(color: Colors.cyanAccent),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Text(post.comment.toString())),
                Text(post.comment.toString()),
              ],
            ),
            Text(
              post.username.toString(),
              style: TextStyle(color: Colors.grey.shade50, fontSize: 27),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.lastname.toString(),
                      style:
                          TextStyle(color: Colors.grey.shade50, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(post.something.toString(),
                        style:
                            TextStyle(color: Colors.grey.shade50, fontSize: 18))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.firstname.toString(),
                      style:
                          TextStyle(color: Colors.grey.shade50, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(post.lastname.toString(),
                        style:
                            TextStyle(color: Colors.grey.shade50, fontSize: 18))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
