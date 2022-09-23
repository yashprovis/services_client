import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:services_client/screens/booking_confirmed.dart';
import 'package:services_client/screens/ratings.dart';
import 'package:services_client/widgets/sc_button.dart';

import '../constants.dart';
import '../models/booking_model.dart';
import '../models/worker_model.dart';
import '../provider/user_provider.dart';
import '../services/booking_service.dart';
import '../widgets/sc_text.dart';
import '../widgets/tiles/address_tile.dart';

class BookWorker extends StatefulWidget {
  final Worker worker;
  static const routeName = "/bookWorker";
  const BookWorker({Key? key, required this.worker}) : super(key: key);

  @override
  State<BookWorker> createState() => _BookWorkerState();
}

class _BookWorkerState extends State<BookWorker> {
  int totalHours = 0;
  int totalMinutes = 0;
  int? selectedDeliveryAddressIndex;
  String? bookingDate;
  String? bookingTime;
  void setBookingDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (pickedDate != null) {
      String formattedDate = intl.DateFormat('dd-MM-yy').format(pickedDate);
      setState(() {
        bookingDate = formattedDate;
      });
    }
  }

  void setBookingTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0));

    if (pickedTime != null) {
      var pickedDate =
          DateTime(2022, 10, 10, pickedTime.hour, pickedTime.minute);
      String formattedDate = intl.DateFormat('hh:mm a').format(pickedDate);
      setState(() {
        bookingTime = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 48),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 24),
                      ),
                      const SizedBox(width: 16),
                      const ScText("Booking", size: 20)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 166,
                  child: ListView(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: (widget.worker.image != "")
                                  ? NetworkImage(widget.worker.image)
                                  : null,
                              child: (widget.worker.image != "")
                                  ? null
                                  : const Icon(
                                      Icons.person_outline,
                                      size: 34,
                                    ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ScText(
                                  widget.worker.name,
                                  size: 20,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(height: 5),
                                ScText(
                                  widget.worker.workingSpecialisation,
                                  size: 16,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ScText(
                                    'Booking Total',
                                    size: 16,
                                    weight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 14),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: secondaryLight.withOpacity(.3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ScText(
                                              "₹ ${totalHours == 0 && totalMinutes == 0 ? "-" : widget.worker.hourlyRate * totalHours + (widget.worker.hourlyRate * totalMinutes / 60)}",
                                              size: 17,
                                              weight: FontWeight.w500,
                                              color: primaryColor),
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ScText(
                                    'Hourly Rate',
                                    size: 16,
                                    weight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 14),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: secondaryLight.withOpacity(.3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ScText(
                                              "₹ ${widget.worker.hourlyRate}.0",
                                              size: 17,
                                              weight: FontWeight.w500,
                                              color: primaryColor),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox()
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ScText(
                              'Booking Date - Time',
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(height: 14),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: secondaryLight.withOpacity(.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: GestureDetector(
                                        onTap: () {
                                          setBookingDate();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              size: 16,
                                            ),
                                            ScText(" ${bookingDate ?? "Date"}",
                                                size: 15,
                                                spacing: 1.2,
                                                weight: FontWeight.w500,
                                                color: primaryColor),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 4),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: secondaryLight.withOpacity(.3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setBookingTime();
                                        },
                                        child: SizedBox(
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.more_time_rounded,
                                                size: 16,
                                              ),
                                              ScText(
                                                  " ${bookingTime ?? "Time"}",
                                                  size: 15,
                                                  spacing: 1,
                                                  weight: FontWeight.w500,
                                                  color: primaryColor),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          transform: Matrix4.translationValues(0, -10, 0),
                          height: 84,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ScText("Total work time:",
                                  weight: FontWeight.w500),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: ListWheelScrollView(
                                        itemExtent: 36,
                                        onSelectedItemChanged: (i) =>
                                            setState(() {
                                              totalHours = i;
                                            }),
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        children: List.generate(
                                            5,
                                            (index) => Center(
                                                    child: ScText(
                                                  index.toString(),
                                                  color: primaryColor,
                                                  size: 18,
                                                  weight: FontWeight.w500,
                                                )))),
                                  ),
                                  const ScText("Hrs. ", size: 14),
                                  SizedBox(
                                    width: 30,
                                    child: ListWheelScrollView(
                                        itemExtent: 36,
                                        onSelectedItemChanged: (i) =>
                                            setState(() {
                                              totalMinutes = i * 15;
                                            }),
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        children: List.generate(
                                            4,
                                            (index) => Center(
                                                    child: ScText(
                                                  ((index) * 15).toString(),
                                                  color: primaryColor,
                                                  size: 18,
                                                  weight: FontWeight.w500,
                                                )))),
                                  ),
                                  const ScText("Mins", size: 14),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ScText(
                              "Delivery Address",
                              weight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 184,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 18),
                                scrollDirection: Axis.horizontal,
                                itemCount: userProvider.getUser.address!.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          selectedDeliveryAddressIndex = index;
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: AddressTile(
                                              removable: true,
                                              size: 14,
                                              address: userProvider
                                                  .getUser.address![index]),
                                        ),
                                      ),
                                      selectedDeliveryAddressIndex == index
                                          ? const Positioned(
                                              right: 26,
                                              top: 12,
                                              child: Icon(Icons.done_all))
                                          : const SizedBox()
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScButton(
                      text: "BOOK",
                      func: () {
                        BookingService().createBooking({
                          "bookingDate": DateTime.parse(
                                  "20${bookingDate!.substring(6, 8)}-${bookingDate!.substring(3, 5)}-${bookingDate!.substring(0, 2)} ${bookingTime!.substring(0, 5)}:00")
                              .toIso8601String(),
                          "bookingDuration": (totalHours * 60 + totalMinutes),
                          "bookingTotal": (widget.worker.hourlyRate *
                                  totalHours +
                              widget.worker.hourlyRate * totalMinutes ~/ 60),
                          "customerName": userProvider.getUser.name,
                          "customerId": userProvider.getUser.uid,
                          "workerName": widget.worker.name,
                          "workerId": widget.worker.id,
                          "workerPhone": widget.worker.phone,
                          "address": userProvider
                              .getUser.address![selectedDeliveryAddressIndex!]
                              .toJson(),
                        }).then((value) {
                          if (value != null) {
                            Navigator.of(context).pushReplacementNamed(
                                BookingConfirmed.routeName,
                                arguments: value);
                          }
                        });
                      },
                      isLoading: false),
                )
              ],
            ),
          ),
        ));
  }
}
