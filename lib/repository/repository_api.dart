import 'dart:convert';

import 'package:dio/dio.dart';

const request =
    'http://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL,BTC-BRL';

final Dio dio = Dio();

Future<Map<String, dynamic>> getData() async {
  Response response = await dio.get(request);
  return response.data;
}
