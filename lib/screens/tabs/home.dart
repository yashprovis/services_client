import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/models/worker_model.dart';
import 'package:services_client/provider/user_provider.dart';
import 'package:services_client/screens/worker_details.dart';
import 'package:services_client/screens/worker_list.dart';
import 'package:services_client/widgets/sc_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:services_client/widgets/sc_text.dart';

import '../../constants.dart';
import '../../services/worker_service.dart';
import '../book_worker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cityList = [
    "Jaipur",
    "Jodhpur",
    "Mumbai",
    "Pune",
    "Delhi"
  ];
  String? selectedCity;
  TextEditingController cityController = TextEditingController();
  List<Worker>? topRatedWorkers;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    topRatedWorkers = await WorkerService().fetchTopRatedWorkers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              customButton: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.map_outlined),
                          const SizedBox(width: 10),
                          ScText(selectedCity ??
                              userProvider.getSelectedCity ??
                              "Pick work location"),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down, color: primaryColor)
                    ],
                  ),
                ),
              ),
              items: cityList.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: ScText(
                      item,
                      size: 14,
                    ),
                  ),
                );
              }).toList(),
              searchController: cityController,
              searchMatchFn: (item, searchValue) {
                return (item.value
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()));
              },
              onChanged: (value) {
                selectedCity = value as String;
                userProvider.updateCity(selectedCity);
                setState(() {});
              },
              searchInnerWidget: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for a city...',
                    hintStyle: TextStyle(
                        color: primaryColor, fontSize: 12, letterSpacing: 1.3),
                  ),
                ),
              ),
              buttonHeight: 40,
              buttonWidth: 240,
              itemHeight: 40,
              itemPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ScText(
            "Services",
            size: 20,
            color: Colors.black,
          ),
        ),
        GridView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 110,
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(WorkerList.routeName,
                      arguments: servicesList[i]["name"]!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .3),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 78,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(servicesList[i]["image"]!))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ScText(servicesList[i]["name"]!, size: 12),
                      )
                    ],
                  ),
                ),
              );
            }),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ScText(
            "Top Professionals",
            size: 20,
            color: Colors.black,
          ),
        ),
        ListView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topRatedWorkers == null ? 0 : topRatedWorkers!.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 2, right: 16),
                    onTap: () {
                      Navigator.of(context).pushNamed(WorkerDetails.routeName,
                          arguments: topRatedWorkers![i]);
                    },
                    tileColor: Colors.grey[200],
                    leading: Container(
                      width: 78,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: (topRatedWorkers![i].image != "")
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(topRatedWorkers![i].image))
                              : null),
                      child: (topRatedWorkers![i].image != "")
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
                        width: MediaQuery.of(context).size.width - 100,
                        child: ScText(topRatedWorkers![i].name, size: 14)),
                    trailing: ScButton(
                        text: "Book",
                        func: () {
                          Navigator.of(context).pushNamed(BookWorker.routeName,
                              arguments: topRatedWorkers![i]);
                        },
                        textSize: 14,
                        isLoading: false,
                        width: 60,
                        height: 30),
                    subtitle: ScText(topRatedWorkers![i].workingSpecialisation,
                        size: 12)),
              );
            }),
      ],
    ));
  }
}
