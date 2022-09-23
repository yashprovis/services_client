import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../helpers/methods.dart';
import '../models/booking_model.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_text.dart';

class BookingConfirmed extends StatelessWidget {
  static const routeName = "/bookingConfirmed";
  final Booking booking;
  const BookingConfirmed({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: ScText("Booking", size: 20),
        ),
        const SizedBox(height: 30),
        Container(
          color: Colors.greenAccent[700],
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
          child: const ScText(
            "Your booking has been confirmed, Our professionals will make sure you have a pleasant and satisfactory experience.",
            align: TextAlign.center,
            color: Colors.white,
            height: 1.5,
            spacing: 1,
            size: 19,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.info,
                        color: primaryColor, size: 20),
                    const SizedBox(width: 10),
                    ScText(
                      "Booking Id: ${booking.id}",
                      align: TextAlign.center,
                      color: Colors.black87,
                      height: 1.5,
                      spacing: 1,
                      size: 17,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.person,
                          color: primaryColor, size: 20),
                      const SizedBox(width: 10),
                      ScText(
                        "Professional: ${booking.workerName}",
                        align: TextAlign.center,
                        color: Colors.black87,
                        height: 1.5,
                        spacing: 1,
                        size: 17,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.phone,
                        color: primaryColor, size: 20),
                    const SizedBox(width: 10),
                    ScText(
                      "Phone: ${booking.workerPhone}",
                      align: TextAlign.center,
                      color: Colors.black87,
                      height: 1.5,
                      spacing: 1,
                      size: 17,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.time,
                          color: primaryColor, size: 20),
                      const SizedBox(width: 10),
                      ScText(
                        "Duration:${durationToString(booking.bookingDuration)} hr.",
                        align: TextAlign.center,
                        color: Colors.black87,
                        height: 1.5,
                        spacing: 1,
                        size: 17,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.doc_plaintext,
                        color: primaryColor, size: 20),
                    const SizedBox(width: 10),
                    ScText(
                      "Total: ₹${booking.bookingTotal}.00",
                      align: TextAlign.center,
                      color: primaryColor,
                      height: 1.5,
                      size: 18,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ScButton(
                        text: "Back To Home",
                        func: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        isLoading: false))
              ],
            )),
      ]),
    );
  }
}
