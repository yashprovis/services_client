import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:services_client/screens/ratings.dart';
import 'package:services_client/widgets/sc_button.dart';

import '../constants.dart';
import '../models/review_model.dart';
import '../widgets/sc_text.dart';

class WorkerDetails extends StatefulWidget {
  final String workerId;
  static const routeName = "/workerDetails";
  const WorkerDetails({Key? key, required this.workerId}) : super(key: key);

  @override
  State<WorkerDetails> createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
  final List<String> tagList = [
    'Hair Stylist',
    'Hair Spa',
    'Hair Massage',
    'Hair Colour'
  ];

  List<Reviews> reviews = [
    Reviews(
        id: "R001",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
    Reviews(
        id: "R002",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
    Reviews(
        id: "R003",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
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
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height - 160,
                child: ListView(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/worker.png'),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              ScText(
                                "John Doe",
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 5),
                              ScText(
                                "Senior Worker",
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 70),
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
                              height: tagList.isEmpty ? 0 : 30,
                              child: Wrap(
                                children: tagList
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                    ScText('4.4',
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    ScText('Avg. Rating',
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                    ScText('160',
                                        size: 18,
                                        weight: FontWeight.w500,
                                        color: primaryColor),
                                    ScText('Bookings',
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
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              ScText(
                                'Description',
                                size: 14,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 8),
                              Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .7,
                                  )),
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
                                  reviews.isEmpty
                                      ? const SizedBox()
                                      : Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    RatingsScreen.routeName);
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
                              reviews.isEmpty
                                  ? const SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text('No Review Yet'),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: SizedBox(
                                        height: 130,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: reviews.length > 5
                                              ? 5
                                              : reviews.length,
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
                                                        reviews.isNotEmpty
                                                            ? const CircleAvatar(
                                                                radius: 22.5,
                                                                child: Text(
                                                                  // reviews[index]['node']
                                                                  //                 ['user']
                                                                  //             ['name']
                                                                  //         .substring(
                                                                  //             0, 1) +
                                                                  //     reviews[index]['node']
                                                                  //                 ['user']
                                                                  //             ['name']
                                                                  //         .substring(
                                                                  //             reviews[index]['node']['user']['name']
                                                                  //                 .indexOf(
                                                                  //                     ' '),
                                                                  //             reviews[index]['node']['user']['name']
                                                                  //                     .indexOf(' ') +
                                                                  //                 2),
                                                                  "YA",
                                                                  style: TextStyle(
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
                                                            : const CircleAvatar(
                                                                radius: 22.5,
                                                                // backgroundImage: NetworkImage(reviews[0]['node']
                                                                //                     ['user']
                                                                //                 ['userProfiles']
                                                                //             ['edges'][0]['node']
                                                                //         [
                                                                //         'profileImagesByProfileId']
                                                                //     [
                                                                //     'edges'][0]['node']['url']),
                                                              ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                "Yash",
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
                                                                    .format(reviews[
                                                                            index]
                                                                        .date),
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
                                                              initialRating:
                                                                  reviews[index]
                                                                      .rating,
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
                                                        reviews[index]
                                                            .description,
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
