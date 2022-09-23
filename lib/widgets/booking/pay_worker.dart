import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../provider/booking_provider.dart';
import '../../services/booking_service.dart';
import '../sc_button.dart';
import '../sc_text.dart';

class PayWorker extends StatefulWidget {
  final Booking booking;
  const PayWorker({super.key, required this.booking});

  @override
  State<PayWorker> createState() => _PayWorkerState();
}

class _PayWorkerState extends State<PayWorker> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //  SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: ScText(
            "Booking Id: ${widget.booking.id}\n\nProfessional ${widget.booking.customerName} has requested ₹${widget.booking.bookingTotal}.00\n\nHours Worked:${durationToString(widget.booking.bookingDuration)} Hr.",
            align: TextAlign.center,
            color: Colors.white,
            height: 1.5,
            size: 18,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
            child: ScButton(
                text: "Pay Cash",
                color: Colors.white70,
                textColor: Colors.black,
                func: () async {
                  var bookingData = await BookingService().updateBooking(
                      widget.booking.id,
                      "completed",
                      widget.booking.workerId,
                      widget.booking.customerId,
                      bookingProvider.socket);
                  if (bookingData != null) {
                    bookingProvider.setBooking(bookingData);
                    bookingProvider.completeBooking();
                  }
                },
                isLoading: false)),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: ScButton(
                text: "Pay Online",
                color: Colors.white70,
                textColor: Colors.black,
                func: () async {
                  var bookingData = await BookingService().updateBooking(
                      widget.booking.id,
                      "completed",
                      widget.booking.workerId,
                      widget.booking.customerId,
                      bookingProvider.socket);
                  if (bookingData != null) {
                    bookingProvider.setBooking(bookingData);
                    bookingProvider.completeBooking();
                  }
                },
                isLoading: false))
      ]),
    );
  }
}
