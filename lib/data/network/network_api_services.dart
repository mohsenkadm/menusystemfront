import 'dart:convert';
import 'dart:io';
import 'dart:html' as html; // Import html package for web URL access
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menusystemfront/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:menusystemfront/utils/utils.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  final box = GetStorage();
  @override
  Future<dynamic> getApi(String url) async {
    
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      responseJson = returnResponse(response);

      if (responseJson['success'] == false) {
        if (responseJson['msg'] != null) {
          Utils.snackBar("", responseJson['msg'].toString());
        }
      } 
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  Map<String, String> _headers() {
    var authToken = box.read('token');
    var cookie = box.read('cookie');
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      'Cookie': '$cookie',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    var authToken = box.read('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken}',
    };
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 25));
      responseJson = returnResponse(response);
      if (responseJson['msg'] != null) {
        Utils.snackBar("", responseJson['msg'].toString());
      } //  }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApistream(http.MultipartRequest request) async {
    if (kDebugMode) {
      print(request.url);
      print("=============================request.url");

      print(request);
    }
    request.headers.addAll(_headers());
    dynamic responseJson;
    try {
      final response = await http.Response.fromStream(await request.send())
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
      //if (responseJson['success'] == true){
      if (responseJson['msg'] != null) {
        Utils.snackBar("", responseJson['msg'].toString());
      } //  }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
      print("=============================request.url");

    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiwithparamter(String url) async {
    if (kDebugMode) {
      print(url);
      print("3=============================request.url");

    }
    var authToken = box.read('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken}',
    };
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
      //if (responseJson['success'] == false){
      if (responseJson['msg'] != null) {
        Utils.snackBar("", responseJson['msg'].toString());
      }
      //}
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    if (kDebugMode) {
      print(responseJson);
      print("4=============================request.url");

    }
    return responseJson;
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      var cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      box.write('cookie', cookie);
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ' +
                response.statusCode.toString());
    }
  }


  @override
  Future<dynamic> deleteApi( String url) async {
    if (kDebugMode) {
      print(url);
      print("5=============================request.url");
    }
    var authToken = box.read('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken}',
    };
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url),  headers: headers)
          .timeout(const Duration(seconds: 25));
      responseJson = returnResponse(response);
      // if (responseJson['success'] == false){
      if (responseJson['msg'] != null) {
        Utils.snackBar("", responseJson['msg'].toString());
      } //  }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
      print("6=============================request.url");

    }
    return responseJson;
  }
}
