import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/screens/book_worker.dart';
import 'package:services_client/screens/worker_details.dart';
import 'package:services_client/services/worker_service.dart';

import '../constants.dart';

import '../provider/user_provider.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_text.dart';

class WorkerList extends StatefulWidget {
  static const routeName = "/workerList";
  final String categoryName;
  const WorkerList({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  List sortItems = ['Lowest Price', 'Highest Price'];
  String? selectedSortItem;
  List? workers;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Map body = {"workingSpecialisation": widget.categoryName};
    if (userProvider.getSelectedCity != null) {
      body["workingCity"] = userProvider.getSelectedCity;
    }
    workers = await WorkerService().fetchCategoryWorkers(body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: ListView(padding: EdgeInsets.zero, children: [
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
                    ScText(
                      "${widget.categoryName} ${userProvider.selectedCity == null ? "" : "in ${userProvider.selectedCity!}"}",
                      // color: Colors.white,
                      size: 19,
                      //   weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                customButton: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * .5 -
                                          30,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedSortItem ?? 'Sort ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                      const Icon(
                                          CupertinoIcons.arrow_up_arrow_down,
                                          color: Colors.white,
                                          size: 20)
                                    ],
                                  ),
                                ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                value: selectedSortItem,
                                onChanged: (value) {
                                  // setState(() {
                                  //   products = null;
                                  // });
                                  // if (value == "Highest Price") {
                                  //   fetchProducts(true);
                                  // } else {
                                  //   fetchProducts(false);
                                  // }
                                  // selectedSortItem = value as String;
                                  // setState(() {});
                                },
                                // dropdownPadding:
                                //     EdgeInsets.only(left: 20),

                                items: sortItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          )),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .5 - 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ScText(
                              'Filter ',
                              size: 14,
                              color: primaryColor,
                              weight: FontWeight.w500,
                            ),
                            Icon(CupertinoIcons.slider_horizontal_3,
                                color: primaryColor)
                          ],
                        ),
                      ),
                    ],
                  )),
              workers == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 220,
                      child: const Center(child: CircularProgressIndicator()))
                  : workers!.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 220,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ScText(
                              "No ${widget.categoryName} professionals found ${userProvider.selectedCity == null ? "" : "in ${userProvider.selectedCity!}"}",
                              align: TextAlign.center,
                              size: 18,
                              height: 1.5,
                              color: primaryColor,
                              weight: FontWeight.w500,
                            ),
                          )))
                      : ListView.builder(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: workers!.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 2, right: 16),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        WorkerDetails.routeName,
                                        arguments: workers![i]);
                                  },
                                  tileColor: Colors.grey[200],
                                  leading: Container(
                                    width: 78,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: (workers![i].image != "")
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    workers![i].image))
                                            : null),
                                    child: (workers![i].image != "")
                                        ? const SizedBox()
                                        : const CircleAvatar(
                                            child: Icon(
                                              Icons.person_outline,
                                              size: 28,
                                            ),
                                          ),
                                  ),
                                  horizontalTitleGap: 0,
                                  title: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child:
                                          ScText(workers![i].name, size: 14)),
                                  trailing: ScButton(
                                      text: "Book",
                                      func: () {
                                        Navigator.of(context).pushNamed(
                                            BookWorker.routeName,
                                            arguments: workers![i]);
                                      },
                                      textSize: 14,
                                      isLoading: false,
                                      width: 60,
                                      height: 30),
                                  subtitle: ScText(
                                      workers![i].workingSpecialisation,
                                      size: 12)),
                            );
                          }),
            ])));
  }
}
