import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:services_client/models/worker_model.dart';

import '../constants.dart';

class WorkerService {
  Future<List<Worker>> fetchTopRatedWorkers() async {
    List<Worker> workers = [];
    http.Response response =
        await http.get(Uri.parse("$baseUrl/worker/topRated"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      workers.add(Worker.fromJson(element));
    }
    return workers;
  }

  Future<Worker?> fetchAllWorker() async {
    Worker? worker;
    http.Response response = await http.get(Uri.parse("$baseUrl/workers"));
    if (response.statusCode == 200) {
      worker = Worker.fromJson(jsonDecode(response.body)['data']);
      return worker;
    }
    return null;
  }

  Future<List<Worker>> fetchCategoryWorkers([Map? body]) async {
    List<Worker> workers = [];
    http.Response response = await http.post(
        Uri.parse("$baseUrl/worker/categoryWorkers"),
        headers: headerApiMap,
        body: body == null ? null : jsonEncode(body));

    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      for (var element in data) {
        workers.add(Worker.fromJson(element));
      }
    }
    return workers;
  }
}
