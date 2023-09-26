// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../controller/authentication_bloc/auth_repository/setup.dart';

abstract class HttpProtocol<T> {
  final String url;
  final T data;
  const HttpProtocol(this.url, this.data);
  Future<List<T>> get();
  Future<bool> post();
  Future<bool> put();
  Future<bool> delete();

}


class Protocol {
  final String url;
  final CRUD? mode;
  final MethodProtocol method;
  final Map<String, dynamic> data;
  final String? message;

  Protocol(this.url, {
    this.mode,
    this.method = MethodProtocol.GET,
    required this.data,
    this.message,
  });

}


class BackendServer extends HttpProtocol<Map<String, dynamic>> {
  final String endUrl;
  final CRUD? mode;
  final MethodProtocol method;
  final Map<String, dynamic> data;
  final String? message;

  const BackendServer( String url,{
    this.data = const <String,dynamic>{},
    this.message,
    this.mode,
    this.method = MethodProtocol.GET,
  }): endUrl = url, super(url, data);

  static String weburl = "http://127.0.0.1:8000";
  //static String weburl = "https://exploress.org";

 // Uri get _uri => Uri.parse("http://127.0.0.1:8000/$url");
  Uri get _uri => Uri.parse("$weburl/api$endUrl");



  Future<bool> connection() async {

    final response = await http.post(
        Uri.parse("$weburl/api/connect"),
        body: {
          'id':"lordyhas",
          'data': "null",
          'message': message,
        }
    );

    debugPrint('### connection() => response.statusCode : ${response.statusCode} \n'
        '### connection() => response.body: ${response.body}');

    if (response.statusCode != 200) return false;
    return true;
  }

  @override
  Future<bool> post() async {
    var json = data;
    json['id'] = "lordyhas";
    final response = await http.post(_uri, body: json);/*(_uri, body: {
      'id':"lordyhas",
      'data': data,
      'message': message,
      'mode': mode?.name,
    });*/

    debugPrint('### send => post($json)');
    debugPrint('### post() => response.statusCode : ${response.statusCode} \n'
        '### post() => response.body: ${response.body}');

    return response.statusCode == 200;
    //return response.statusCode;
  }

  @override
  Future<List<Map<String, dynamic>>> get() async {
    final response = await http.get(_uri);
    List<Map<String, dynamic>> dataList = [];
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body) as Map;
      for (var element in value['data']){
        dataList.add(Map.from(element));
      }
      debugPrint("### get() => response.statusCode : ${response.statusCode} \n ");
      return dataList;
    } else {
      debugPrint("### get() => response.message : Failed to load  \n ");
      throw Exception('Failed to load');
    }
  }

  @override
  Future<bool> put() async {
    final response = await http.put(_uri, body: {
      'id':"lordyhas",
      'data': data,
      'message': message,
      'mode': mode?.name,
    });
    debugPrint(''
        '### put() => response.statusCode : ${response.statusCode} \n'
        '### put() => response.body: ${response.body}');

    return response.statusCode == 200;
  }

  @override
  Future<bool> delete() async {
    final response = await http.delete(_uri, body: {
      'id':"lordyhas",
      'data': data,
      'message': message,
      'mode': mode?.name,
    });
    debugPrint('### delete() => response.statusCode : ${response.statusCode} \n'
        '### delete() => response.body: ${response.body}');

    return response.statusCode == 200;
  }

  Future<User> login() async {
    //final response = await http.get(_uri);
    final response = await http.post(
      Uri.parse("$weburl/api/user"),
      body: data,
    ); /*({
      'id':"lordyhas",
      'data': data,
      'message': message,
      'mode': mode?.name,
    });*/
    List<Map<String, dynamic>> dataList = [];
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body) as Map;
      for (var element in value['data']){
        dataList.add(Map.from(element));
      }
      debugPrint("### login() => response.statusCode : ${response.statusCode}\n"
          "### login() => response.body : ${response.body}");
      return User.fromMap(dataList.first);
    } else {

      debugPrint("### login() => response.statusCode : ${response.statusCode}\n"
          "### login() => message : Failed "
          //"### login() => response.body : ${response.body}"
      );
      throw Exception('Login failed');
    }
  }




}


enum MethodProtocol {
  /// Most commonly "GET" or "POST", less commonly "HEAD", "PUT", or "DELETE".
  GET,
  POST,
  HEAD,
  PUT,
  DELETE
}

extension MethodHelper on MethodProtocol {
  String get name {
    switch (this) {
      case MethodProtocol.GET:
        return 'GET';
      case MethodProtocol.POST:
        return 'POST';
      case MethodProtocol.HEAD:
        return 'HEAD';
      case MethodProtocol.PUT:
        return 'PUT';
      case MethodProtocol.DELETE:
        return 'DELETE';
    }
  }
}

/*class TransferMode {
  final CRUD mode;
  final MethodProtocol method;
}*/

enum CRUD {
  create,
  read,
  update,
  delete,
}

extension CRUDHelper on CRUD {
  String get name {
    switch(this){
      case CRUD.create  : return "create";
      case CRUD.read    : return "read";
      case CRUD.delete  : return "delete";
      case CRUD.update  : return "update";
    }
  }
}


/*
mixin TransactionHttp {

  Future<void> send(Protocol protocol) async {
    //http://127.0.0.1:8000/api/test_post

    final response = await http.post(Uri.parse(protocol.url), body: {
      'data': protocol.data,
      'message': protocol.message,
      'mode': protocol.mode?.name,
    });
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    //return response.statusCode;
  }


  Future<Map<String, dynamic>> get(String url) async {
    //http://127.0.0.1:8000/api/csv
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var value = jsonDecode(response.body) as Map;
      return value['data'];
    } else {
      throw Exception('Failed to load');
    }
  }
}
*/
