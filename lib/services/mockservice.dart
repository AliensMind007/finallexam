import 'dart:convert';
import 'package:finallexam/models/exammodel.dart';
import 'package:http/http.dart';



class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "6209f38092946600171c5618.mockapi.io";
  static String SERVER_PRODUCTION = "6209f38092946600171c5618.mockapi.io";

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response =
    await post(uri, headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response =
    await put(uri, headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response =
    await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> DEL(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /* Http Apis */
  static String API_LIST = "/posts";
  static String API_ONE_ELEMENT = "/posts/"; //{id}
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/"; //{id}
  static String API_DELETE = "/posts/"; //{id}

  /* Http Params */
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> params = {};
    return params;
  }

  /* Http Bodies */
  static Map<String, dynamic> bodyCreate(ExamMoadel post) {
    Map<String, dynamic> params = {};
    params.addAll({
      // CreatedTime;
      // String? cardNumber;
      // String? name;
      // String? sv;
      // String? id;
      "id":post.id,
      "comment":post.comment,
      "objectname":post.objectname,
      "something":post.something,
      "username":post.username,
      "firstname":post.firstname,
      "lastname":post.lastname,
    });
    return params;
  }

  static Map<String, dynamic> bodyUpdate(ExamMoadel post) {
    Map<String, dynamic> params = {};
    params.addAll({
      "id":post.id,
      "comment":post.comment,
      "objectname":post.objectname,
      "something":post.something,
      "username":post.username,
      "firstname":post.firstname,
      "lastname":post.lastname,
    });
    return params;
  }

  /* Http parsing */

  static List<ExamMoadel> parseResponse(String response) {
    List json = jsonDecode(response);
    List<ExamMoadel> postes = List<ExamMoadel>.from(json.map((x) => ExamMoadel.fromJson(x)));
    return postes;
  }
}