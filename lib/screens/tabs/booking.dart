import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/models/booking_model.dart';
import 'package:services_client/services/booking_service.dart';
import 'package:services_client/widgets/booking/pay_worker.dart';

import 'package:services_client/widgets/sc_text.dart';
import '../../constants.dart';
import '../../provider/booking_provider.dart';
import '../../widgets/booking/booking_done.dart';
import '../../widgets/booking/booking_session.dart';
import '../../widgets/booking/created_booking.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Booking? nextBooking;
  io.Socket? socket;
  bool isLoading = true;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    nextBooking = await BookingService().fetchLatestBooking();
    if (nextBooking != null) {
      bookingProvider.socket = connectSocket(nextBooking!.id);

      bookingProvider.setBooking(nextBooking);
      bookingProvider.bookingStatus = nextBooking!.bookingStatus;
    }
    isLoading = false;
    setState(() {});
  }

  io.Socket? connectSocket(bookingId) {
    socket = io.io(
        'http://192.168.100.43:5000',
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({"bookingid": bookingId})
            .build());
    socket!.connect();
    socket!.on("receive-update-booking", (data) => subscribeSocket(data));
    return socket;
  }

  subscribeSocket(dynamic data) async {
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    if (data["bookingStatus"] != "completed") {
      bookingProvider.bookingStatus = (data["bookingStatus"]);
      nextBooking = await BookingService().fetchLatestBooking();
      bookingProvider.setBooking(nextBooking);
      bookingProvider.bookingStatus = nextBooking!.bookingStatus;
    } else {
      bookingProvider.completeBooking();
    }
  }

  @override
  void dispose() {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
        backgroundColor: bookingProvider.getBookingStatus == "completed"
            ? Colors.greenAccent[700]
            : bookingProvider.getBookingStatus == "requested"
                ? primaryLight
                : Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView(padding: const EdgeInsets.only(top: 10), children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScText(
                      "${bookingProvider.getBookingStatus == "created" ? "Next " : ""}Booking",
                      color: bookingProvider.getBookingStatus == "completed" ||
                              bookingProvider.getBookingStatus == "requested"
                          ? Colors.white
                          : null,
                      size: 20,
                      //   weight: FontWeight.w500,
                    ),
                    if (bookingProvider.getBookingStatus == "completed")
                      GestureDetector(
                        onTap: () {
                          bookingProvider.setBooking(null);
                          bookingProvider.resetBooking();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
              isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Center(child: CircularProgressIndicator()))
                  : bookingProvider.getBooking == null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: const Center(
                            child: ScText("No upcoming bookings."),
                          ),
                        )
                      : AnimatedContainer(
                          duration: Duration(seconds: 1),
                          child: bookingProvider.getBookingStatus == "created"
                              ? CreatedBooking(nextBooking: nextBooking!)
                              : bookingProvider.getBookingStatus == "started"
                                  ? BookingSession(booking: nextBooking!)
                                  : bookingProvider.getBookingStatus ==
                                          "requested"
                                      ? PayWorker(booking: nextBooking!)
                                      : BookingDone(
                                          booking: nextBooking!,
                                        ))
            ])));
  }
}
