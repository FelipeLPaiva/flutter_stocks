import 'dart:io';
import 'dart:convert';
import 'package:flutter_sample_app/src/data/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sample_app/src/data/network/base_api_service.dart';

class NetworkApiServices extends BaseApiServices{

@override
  Future getApiResponse(String url) async {
    dynamic responsejson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }


  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("achi request nhi hai yeh");
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}