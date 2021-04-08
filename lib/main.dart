import 'package:flutter/material.dart';

import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const api_key = String.fromEnvironment('API_KEY', defaultValue: 'API_KEY');
const request = "https://api.hgbrasil.com/finance?format=json&key=" + api_key;

void main() async {

  http.Response response = await http.get(request);
  print(json.decode(response.body)['results']['currencies']['USD']);
  runApp(Home());
}
