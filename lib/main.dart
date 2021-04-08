import 'package:flutter/material.dart';

import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const api_key = String.fromEnvironment('API_KEY', defaultValue: 'API_KEY');
const request = "https://api.hgbrasil.com/finance?format=json&key=" + api_key;

void main() async {
  print(await getData());
  runApp(Home());
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
