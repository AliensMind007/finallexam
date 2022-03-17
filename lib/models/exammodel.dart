// import 'dart:convert';
// List<CardModel> imagejsonFromJson(String str) => List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));
// String imagejsonToJson(List<CardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ExamMoadel{
  String? comment;
  String? objectname;
  String? something;
  String? username;
  String? firstname;
  String? lastname;
  String? id;

  ExamMoadel({this.id,this.comment,this.objectname,this.something,this.username,this.firstname,this.lastname});
  ExamMoadel.fromJson(Map<String,dynamic>json):
        id = json['id'],
        comment = json['comment'],
        objectname = json['objectname'],
        something = json['something'],
        username = json['username'],
        firstname = json['firstname'],
        lastname = json['lastname'];
  Map<String, dynamic> toJson() => {
    "id":id,
    "comment":comment,
    "objectname":objectname,
    "something":something,
    "username":username,
    "firstname":firstname,
   "lastname":lastname,
  };
}