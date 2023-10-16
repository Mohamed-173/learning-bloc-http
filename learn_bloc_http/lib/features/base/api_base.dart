// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart';
// import 'package:learn_bloc_http/features/constant/app_const.dart';

// class ApiBase {
//   Future<dynamic> postLogin(String apiKey, dynamic body) async {
//     final response =
//         await post(Uri.parse(AppConst.baseApi + apiKey), body: body);
//     var result = _returnResponse(response);
//     log(result.toString());
//     return result;
//   }

//   _returnResponse(Response response) {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = jsonDecode(response.body);
//         return responseJson["token"];

//       case 400:
//         var responseErorre = jsonDecode(response.body);
//         return responseErorre;

//       default:
//         return Exception("The error is ${response.body}");
//     }
//   }
// }
