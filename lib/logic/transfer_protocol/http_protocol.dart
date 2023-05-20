// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class HttpProtocol<T> {
  Future<T> getData();

  Future<void> sendData(Object? data);
}

class TransferProtocol {
  final String? url;
  final CRUD mode;
  final MethodProtocol method;

  const TransferProtocol({
    required this.mode,
    this.url,
    this.method = MethodProtocol.GET,
  });

  //final _url = "https://jsonplaceholder.typicode.com/albums/1";
  //Uri get _uri => Uri.https('jsonplaceholder.typicode.com', '/albums/1');
  Uri get _uri => Uri.http('http://127.0.0.1:8000', '/doctor_create');

  //Uri? get _uriFromUrl => (url != null) ? Uri.parse(url!) : null;

  Future<void> send(Map data) async {
    final response = await http.post(_uri, body: data);
    debugPrint('Response status: ${response.statusCode}');

    debugPrint('Response body: ${response.body}');


    //return response.statusCode;
  }

  Future<Map?> get() async {
    // Url of the website where we get the data from.
    //getp.toString();
    //var uri = Uri.https('jsonplaceholder.typicode.com','/albums/1',{'where':null,'table':null,},);

    var uri = _uri;
    var request = http.Request(method.name, uri); // Set to GET
    http.StreamedResponse response = await request.send(); // Send request.
    // Check if response is okay
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    }
    return null;
  }
}

/// [GetProtocol] is equivalent to  the query below
/// SELECT * FROM [table] WHERE ???
//todo : how to represent query for http
class GetProtocol {
  final String query;
  final String where;
  final String table;
  final String? url;
  final Map<String, dynamic> tag;


  GetProtocol({
    required this.query,
    required this.where,
    required this.table,
    this.url,
    this.tag = const <String,dynamic>{},
  });
}

class SendProtocol {
  final String query;
  final String where;
  final String table;
  final Map<String, dynamic> tag;


  SendProtocol({
    required this.query,
    required this.where,
    required this.table,
    this.tag = const <String,dynamic>{},
  });
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
