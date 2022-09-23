import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/widgets/sc_text.dart';
import 'package:services_client/widgets/tiles/add_rating_tile.dart';

import '../../models/booking_model.dart';
import '../../provider/booking_provider.dart';
import '../../services/booking_service.dart';
import '../sc_button.dart';

class BookingDone extends StatefulWidget {
  final Booking booking;
  const BookingDone({super.key, required this.booking});

  @override
  State<BookingDone> createState() => _BookingDoneState();
}

class _BookingDoneState extends State<BookingDone> {
  bool isRated = false;
  void alterRatings(Map rating, int i) {
    isRated = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.done_all,
          size: 60,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: ScText(
            "Booking Id: ${widget.booking.id}\n\nThank you for Paying ₹${widget.booking.bookingTotal} to ${widget.booking.customerName}.\n\nWe Hope you had a Great and Fulfilling Experience.",
            align: TextAlign.center,
            color: Colors.white,
            height: 1.5,
            size: 18,
          ),
        ),
        isRated
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ScButton(
                    text: "End Booking",
                    color: Colors.white,
                    textColor: Colors.black,
                    func: () {
                      bookingProvider.setBooking(null);
                      bookingProvider.resetBooking();
                    },
                    isLoading: false))
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: AddRatingTile(
                    booking: widget.booking, func: alterRatings, index: null)),
        SizedBox(height: 20)
        // Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //     child: ScButton(
        //         text: "Back To Home",
        //         color: Colors.white,
        //         textColor: Colors.black,
        //         func: () {
        //           Navigator.of(context).pop();
        //         },
        //         isLoading: false))
      ]),
    );
  }
}
