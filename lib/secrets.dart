import 'dart:convert';

import 'package:flutter/services.dart';

class Secret {
  final String apiKey;

  Secret({this.apiKey = ""});

  Secret.fromJson(Map json)
      : this.apiKey = json["api_key"];
}

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath, (jsonStr) async {
      return Secret.fromJson(json.decode(jsonStr));
    });
  }
}