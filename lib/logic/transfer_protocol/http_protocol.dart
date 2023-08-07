// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class HttpProtocol<T> {
  Future<T> getData();

  Future<void> sendData(Object? data);
}


class UserAgentClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;

  UserAgentClient(this.userAgent, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _inner.send(request);
  }
}
class TransferProtocolTransaction{

  final String url;
  final http.Client client;


  TransferProtocolTransaction(this.url): client = http.Client();

  Future<void> _clientTest() async {
     //client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('http://127.0.0.1:8000/api/csv'),);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (kDebugMode) {
        print(decodedResponse.runtimeType);
      }
      //var uri = Uri.parse(decodedResponse['uri'] as String);
      //print(await client.get(uri));

    } finally {
      client.close();
    }
  }

  void close() => client.close();

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


class TransferProtocol {
  final String url;
  final CRUD? mode;
  final MethodProtocol method;
  final Map<String, dynamic> data;
  final String? message;

  const TransferProtocol( this.url,{
    this.data = const <String,dynamic>{},
    this.message,
    this.mode,
    this.method = MethodProtocol.GET,
  });

  Uri get _uri => Uri.parse(url);
  //Uri get _uri => Uri.parse('http://127.0.0.1:8000/api/test_post');

  //Uri? get _uriFromUrl => (url != null) ? Uri.parse(url!) : null;

  Future<void> send() async {
    //http://127.0.0.1:8000/api/test_post


  }

  Future<void> post() async {

    final response = await http.post(_uri, body: {
      'data': data,
      'message': message,
      'mode': mode?.name,
    });

    debugPrint('post() => response.statusCode : ${response.statusCode} \n'
        'post() => response.body: ${response.body}');

    //return response.statusCode;
  }

  Future<List<Map<String, dynamic>>> get() async {
    final response = await http.get(_uri);
    List<Map<String, dynamic>> dataList = [];
    if (response.statusCode == 200) {
      var value = jsonDecode(response.body) as Map;
      for (var element in value['data']){
        dataList.add(Map.from(element));
      }
      debugPrint("get() => response.statusCode : ${response.statusCode} \n ");
      return dataList;
    } else {
      throw Exception('Failed to load');
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
