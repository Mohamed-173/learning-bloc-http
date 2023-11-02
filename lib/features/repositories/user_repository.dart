import 'dart:developer';

import 'package:learn_bloc_http/features/base/api_base.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:learn_bloc_http/features/constant/app_const.dart';

class UserRepository {
  final apiKeyLogin = "/api/login";
  final apiKeyLogin2 = "/auth/login/";
  final apiKeyLogin3 = "/auth/login/";

  final apiKeyCheck = "/users/is-available";
  final apiKeyCheck3 = "/auth/registered";
  final apiKeyRegister = "/api/register";
  final apiKeyRegister3 = "/auth/register/try";
  final apiKeyRegister4 = "/users/";

  // final ApiBase apiBase = ApiBase();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(
      key: "token",
    );
    // this line for deleting entire saved value and key
    await storage.deleteAll();
  }

  Future<String> login(String? email, String? password) async {
    final response = await _dio.post(AppConst.baseApi + apiKeyLogin,
        data: {"email": email, "password": password});

    return response.data["token"];
  }

  Future<String> loginByPhoneNo(String? phonNo) async {
    final response = await _dio
        .post(AppConst.baseApi + apiKeyLogin, data: {"phoneNo ": phonNo});

    return response.data["token"];
  }

  Future<String> login2(String? email, String? password) async {
    final response = await _dio.post(AppConst.baseApi2 + apiKeyRegister,
        data: {"email": email, "password": password});
    return response.data["access_token"];
  }

  Future<bool> checkEmail(String? email) async {
    final response = await _dio.post(AppConst.baseApi2 + apiKeyCheck, data: {
      "email": email,
    });
    return response.data["isAvailable"];
  }

  checkRegistered3({String? phoneNo}) async {
    final response = await _dio.post(AppConst.baseApi3 + apiKeyCheck3, data: {
      "phone": phoneNo,
    });
    log(response.data);
    log("message");
    return response.data;
  }

  register({
    required String phonNo,
    required String rePassword,
    required String email,
    required String password,
    required String name,
  }) async {
    final response =
        await _dio.post(AppConst.baseApi4 + apiKeyRegister4, data: {
      "name": name,
      "email": email,
      "password": password,
      "avatar": "https://api.lorem.space/image/face?w=640&h=480&r=867"
    });

    return response;
  }
}
