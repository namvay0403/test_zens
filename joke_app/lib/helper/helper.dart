import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  Future<String> _loadAVaultAsset() async {
    return await rootBundle.loadString('assets/data.json');
  }

  Future<List<dynamic>> loadVault() async {
    var jsonString = await _loadAVaultAsset();
    final jsonResponse = json.decode(jsonString);
    late List<int> idJokesAppear = [];

    idJokesAppear = await getJoke();
    List<dynamic> jokes = [];
    for (var i = 0; i < jsonResponse['jokes'].length; i++) {
      if (!idJokesAppear.contains(jsonResponse['jokes'][i]['id'])) {
        jokes.add(jsonResponse['jokes'][i]);
      }
    }
    return jokes;
  }

  Future<void> saveJoke({required int jokeId}) async {
    final prefs = await SharedPreferences.getInstance();
    await loadVault();
    prefs.setInt('$jokeId', jokeId);
  }

  Future<List<int>> getJoke() async {
    final prefs = await SharedPreferences.getInstance();
    var wishListString = prefs.getKeys();
    List<int> temp = [];
    if (wishListString.isEmpty) {
      return [];
    } else {
      wishListString.forEach((element) {
        var result = prefs.getInt(element);
        temp.add(result!);
      });
    }
    return temp;
  }

  void removeJoke() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
