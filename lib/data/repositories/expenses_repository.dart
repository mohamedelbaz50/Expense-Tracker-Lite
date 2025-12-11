import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ExpensesRepository {
  Future<double?> convertCurrency({
    required String from,
    required double amount,
  }) async {
    final url = Uri.parse(
      'https://api.exchangerate.host/convert?access_key=eee50de6a8fd22e59cbf150c46c602e7&from=$from&to=USD&amount=$amount',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          return data['result']?.toDouble();
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Conversion Error: $e");
      }
      return null;
    }
  }
}
