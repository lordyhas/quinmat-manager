// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

abstract class HttpProtocol<T> {
  Future<T> getData();

  Future<void> sendData(Object? data);
}

class TransferProtocol {
  final String? url;

  const TransferProtocol({this.url});

  //final _url = "https://jsonplaceholder.typicode.com/albums/1";
  Uri get _uri => Uri.https('jsonplaceholder.typicode.com', '/albums/1');

  Uri? get _uriFromUrl => (url != null) ? Uri.parse(url!) : null;

  Future<void> send(Map data) async {
    final response = await http.post(_uriFromUrl ?? _uri, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //return response.statusCode;
  }

  Future<Map?> get({required GetProtocol getp}) async {
    // Url of the website where we get the data from.
    //getp.toString();
    var uri = Uri.https(
      'jsonplaceholder.typicode.com',
      '/albums/1',
      {'where': getp.query, 'table': getp.table, },
    );
    //_uriFromUrl ?? _uri; //Uri.parse(_url);
    var request = http.Request('GET', uri); // Set to GET
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
  MethodProtocol method;

  GetProtocol({
    required this.query,
    required this.where,
    required this.table,
    this.url,
    this.method = MethodProtocol.POST,
  });
}

class SendProtocol {}

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
