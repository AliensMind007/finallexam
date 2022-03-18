import 'dart:convert';
import 'package:finallexam/models/exammodel.dart';
import 'package:hive/hive.dart';

class HiveDB {
  static String DB_NAME = "banking_app";
  static var box = Hive.box(DB_NAME);

// #store_saved_cards

  static Future<void> storeSavedCards(List<ExamMoadel> postes) async {
    List<String> list =
    List<String>.from(postes.map((post) => jsonEncode(post.toJson())));
    await box.put("cards", list);
  }

  // #load_saved_cards

  static List<ExamMoadel> loadSavedCards() {
    List<String> response = box.get("cards", defaultValue: <String>[]);
    List<ExamMoadel> list =
    List<ExamMoadel>.from(response.map((x) => ExamMoadel.fromJson(jsonDecode(x))));
    return list;
  }

  // store_noInternet_cards

  static Future<void> storeNoInternetCards(List<ExamMoadel> postes) async {
    List<String> list =
    List<String>.from(postes.map((post) => jsonEncode(post.toJson())));
    await box.put("no connection", list);
  }

  // #load_noInternet_cards

  static List<ExamMoadel> loadNoInternetCards() {
    List<String> response = box.get("no connection", defaultValue: <String>[]);
    List<ExamMoadel> list =
    List<ExamMoadel>.from(response.map((x) => ExamMoadel.fromJson(jsonDecode(x))));
    return list;
  }
}