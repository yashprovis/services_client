//""
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/address_model.dart';

class AddressService {
  Future<Map<String, dynamic>> addAddressService(
      {required Address address}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(address.toJson()),
        Uri.parse("$baseUrl/address"));

    List data = jsonDecode(response.body)['data']["address"];
    return data[data.length - 1];
  }

  Future removeAddressService({required String id}) async {
    await http.delete(headers: headerApiMap, Uri.parse("$baseUrl/address/$id"));
  }

  Future updateAddressService({required Address address}) async {
    await http.put(
        headers: headerApiMap,
        body: jsonEncode(address.toJson()),
        Uri.parse("$baseUrl/address/${address.id}"));
  }
}
