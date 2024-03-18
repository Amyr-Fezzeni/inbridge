// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ServiceChat {
//   // static var parse;
//   // static var response;

//   // static Future<http.Response> getConversations() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.getString('token');
//   //   var tokenuser = prefs.getString('token');

//   //   const base_url = "${Api.assetsURi}/";
//   //   String url = "${base_url}api/messages/home";
//   //   return await http.get(
//   //     Uri.parse(url),
//   //     headers: {
//   //       'Authorization': 'Bearer $tokenuser',
//   //     },
//   //   );
//   // }

//   // static Future<http.Response> getMessagesConversation() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.getString('token');
//   //   print("saaaaaaaaaaaaaa${prefs.getInt("idConv")}");

//   //   int? idconversation = prefs.getInt('idConv');

//   //   var tokenuser = prefs.getString('token');

//   //   String url = "${Api.assetsURi}/api/messages/contact/$idconversation";
//   //   return await http.get(
//   //     Uri.parse(url),
//   //     headers: {
//   //       'Authorization': 'Bearer $tokenuser',
//   //     },
//   //   );
//   // }

//   // static Future<void> sendConversationId(
//   //     String conversationId, int userId) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String baseUrl = "$API_PROD";
//   //   var tokenuser = prefs.getString('token');
//   //   log(tokenuser.toString());
//   //   final response = await http.post(
//   //       Uri.parse("$baseUrl/api/messages/create-conversation/$userId"),
//   //       headers: <String, String>{'Authorization': 'Bearer $tokenuser'},
//   //       body: <String, String>{'firebase_id': conversationId});

//   //   log("create conversation status code:${response.statusCode}");

//   //   log(response.statusCode.toString());
//   //   log(response.toString());
//   //   log(response.body.toString());
//   // }

//   // static Future<String?> addFileConversation( String conversationId, File filepath) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   var tokenuser = prefs.getString('token');
//   //   Map<String, String> headers = {
//   //     'Content-Type': 'multipart/form-data',
//   //     'Authorization': 'Bearer $tokenuser',
//   //     'Accept': 'application/json',
//   //   };

//   //   var request = http.MultipartRequest( 'POST', Uri.parse("$API_PROD/api/messages/upload-file/$conversationId"))
//   //     ..headers.addAll(headers)
//   //     ..files.add(await http.MultipartFile.fromPath('file', filepath.path));
//   //   var response = await request.send();
//   //   log("upload file to server status code:${response.statusCode}");
//   //   log(request.toString());
//   //   log(response.statusCode.toString());
//   //   log(response.toString());
//   //   final d = await response.stream.bytesToString();
//   //   log(d);
//   //   if (response.statusCode == 201 || response.statusCode == 200) {
//   //     return json.decode(d)['url'];
//   //   } else {
//   //     return null;
//   //   }
//   // }


// }
