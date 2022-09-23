import 'dart:convert';

import 'package:services_client/models/booking_model.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../constants.dart';

class BookingService {
  Future<List<Booking>> fetchAllUserBookings() async {
    List<Booking> bookings = [];
    http.Response response = await http.get(
        // body: jsonEncode(),
        headers: headerApiMap,
        Uri.parse("$baseUrl/user/bookings"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      bookings.add(Booking.fromJson(element));
    }
    return bookings;
  }

  Future<List<Booking>> fetchAllWorkerBookings(String id) async {
    List<Booking> bookings = [];
    http.Response response = await http.get(
        // body: jsonEncode(),
        headers: headerApiMap,
        Uri.parse("$baseUrl/worker/completedBookings/$id"));
    List data = jsonDecode(response.body)['data'];
    for (var element in data) {
      bookings.add(Booking.fromJson(element));
    }
    return bookings;
  }

  Future<Booking?> fetchLatestBooking() async {
    Booking? booking;
    http.Response response = await http.get(
        headers: headerApiMap, Uri.parse("$baseUrl/user/latestBooking"));
    if (response.statusCode == 200) {
      booking = Booking.fromJson(jsonDecode(response.body)['data']);
      return booking;
    }
    return null;
  }

  Future<Booking?> updateBooking(String id, String status, String workerId,
      String userId, io.Socket? socket) async {
    Booking? booking;
    Map body = {
      "bookingStatus": status,
    };
    if (socket != null) {
      socket.emit("update-booking", {
        "senderId": userId,
        "receiverId": workerId,
        "bookingStatus": status
      });
    }
    http.Response response = await http.post(
        body: jsonEncode(body),
        headers: headerApiMap,
        Uri.parse("$baseUrl/updateBooking/$id"));
    // IO.io(uri)
    if (response.statusCode == 200) {
      booking = Booking.fromJson(jsonDecode(response.body)['data']);
      return booking;
    }
    return null;
  }

  Future<Booking?> createBooking(Map newBookingMap) async {
    http.Response response = await http.post(
        body: jsonEncode(newBookingMap),
        headers: headerApiMap,
        Uri.parse("$baseUrl/createBooking"));
    print(response.body);
    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }
}
