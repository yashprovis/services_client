import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:services_client/screens/ratings.dart';
import 'package:services_client/widgets/sc_button.dart';

import '../constants.dart';
import '../models/booking_model.dart';
import '../models/worker_model.dart';
import '../services/booking_service.dart';
import '../widgets/sc_text.dart';

class WorkerDetails extends StatefulWidget {
  final Worker worker;
  static const routeName = "/workerDetails";
  const WorkerDetails({Key? key, required this.worker}) : super(key: key);

  @override
  State<WorkerDetails> createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
  List<Booking>? bookings;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    bookings = await BookingService().fetchAllWorkerBookings(widget.worker.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const ScText(
                      "Details",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    )
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
                              // SizedBox(height: 2),
                              // ScText(
                              //   "${widget.worker.workingExperience}+ Experience",
                              //   size: 14,
                              //   color: Colors.grey,
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ScText(
                              'Specialisation',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height:
                                  widget.worker.workingTags.isNotEmpty ? 0 : 30,
                              child: Wrap(
                                children: widget.worker.workingTags
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: secondaryLight
                                                  .withOpacity(.3),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ScText(e,
                                                  size: 14,
                                                  weight: FontWeight.w500,
                                                  color: primaryColor),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ScText("₹${widget.worker.hourlyRate}",
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    const ScText('Hourly Rate',
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ScText(
                                        "${widget.worker.workingExperience}+",
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    const ScText('Experience',
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ScText(
                                        widget.worker.avgRating == null
                                            ? "-"
                                            : widget.worker.avgRating!
                                                .toStringAsFixed(1),
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    const ScText('Avg. Rating',
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ScText(
                                        bookings == null
                                            ? "-"
                                            : bookings!.length.toString(),
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    const ScText('Bookings',
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ScText(
                                'Description',
                                size: 14,
                                weight: FontWeight.w500,
                              ),
                              const SizedBox(height: 8),
                              ScText(
                                widget.worker.desc,
                                // style: const TextStyle(
                                size: 12,
                                color: primaryColor,
                                weight: FontWeight.w500,
                                spacing: 1,
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Reviews',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  widget.worker.ratings.isEmpty
                                      ? const SizedBox()
                                      : Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    RatingsScreen.routeName,
                                                    arguments:
                                                        widget.worker.ratings);
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: 16,
                                              ),
                                              style: ButtonStyle(
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          EdgeInsets.zero)),
                                              label: const Text(
                                                'View More',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )))
                                ],
                              ),
                              widget.worker.ratings.isEmpty
                                  ? const SizedBox(
                                      height: 80,
                                      child: Center(
                                        child: ScText('No Review Yet'),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: SizedBox(
                                        height: 130,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              widget.worker.ratings.length > 5
                                                  ? 5
                                                  : widget
                                                      .worker.ratings.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFABB2BA),
                                                      width: .5)),
                                              width: 220,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 6.0,
                                                        horizontal: 12),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        widget.worker.ratings[
                                                                        index][
                                                                    "userImage"] ==
                                                                ""
                                                            ? CircleAvatar(
                                                                radius: 22.5,
                                                                child: Text(
                                                                  widget
                                                                      .worker
                                                                      .ratings[
                                                                          index]
                                                                          [
                                                                          "userName"]
                                                                      .toString()
                                                                      .substring(
                                                                          0, 2),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          -.8,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 22.5,
                                                                backgroundImage:
                                                                    NetworkImage(widget
                                                                            .worker
                                                                            .ratings[index]
                                                                        [
                                                                        "userImage"]),
                                                              ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                widget.worker
                                                                            .ratings[
                                                                        index][
                                                                    "userName"],
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              child: Text(
                                                                intl.DateFormat
                                                                        .yMMMd()
                                                                    .format(DateTime.parse(widget
                                                                            .worker
                                                                            .ratings[index]
                                                                        [
                                                                        "ratingDate"])),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            RatingBar(
                                                              initialRating: widget
                                                                  .worker
                                                                  .ratings[
                                                                      index]
                                                                      ["stars"]
                                                                  .toDouble(),
                                                              minRating: 0,
                                                              glow: false,
                                                              ignoreGestures:
                                                                  true,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemSize: 12,
                                                              unratedColor:
                                                                  const Color(
                                                                      0xFF9FA8B0),
                                                              itemCount: 5,
                                                              ratingWidget:
                                                                  RatingWidget(
                                                                      empty:
                                                                          const Icon(
                                                                        Icons
                                                                            .star_border_outlined,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      half:
                                                                          const Icon(
                                                                        Icons
                                                                            .star_half_outlined,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      full:
                                                                          const Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber,
                                                                      )),
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          .0),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 18,
                                                            right: 12),
                                                    child: Text(
                                                        widget.worker
                                                                .ratings[index]
                                                            ["desc"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 4,
                                                        style: TextStyle(
                                                          height: 1.4,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[800],
                                                        )),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                            ],
                          ))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ScButton(text: "BOOK", func: () {}, isLoading: false),
              )
            ],
          ),
        ));
  }
}
