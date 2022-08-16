import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/sc_text.dart';
import '../address.dart';
import '../profile/edit_profile.dart';
import '../profile/help_support.dart';
import '../profile/terms_conditions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const List profileItems = [
    {
      "name": "Address",
      "route": AddressScreen.routeName,
      "icon": CupertinoIcons.map
    },
    {
      "name": "Help and Support",
      "route": HelpSupport.routeName,
      "icon": CupertinoIcons.info
    },
    {
      "name": "Terms and Conditions",
      "route": TermsConditions.routeName,
      "icon": CupertinoIcons.doc
    },
    {
      "name": "Logout",
      //  "route": AddressScreen.routeName,
      "icon": CupertinoIcons.person_badge_minus
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView(padding: const EdgeInsets.only(top: 10), children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ScText(
                  "Profile",
                  size: 20,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(EditProfile.routeName),
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ScText("Client".substring(0, 2).toUpperCase(),
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  ScText("Client Name", size: 18),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child: ScText("client@email.com", size: 13),
                              ),
                              const ScText("+9199999999", size: 13)
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (index == 3) {
                        return;
                      }
                      Navigator.of(context)
                          .pushNamed(profileItems[index]["route"]);
                    },
                    minLeadingWidth: 30,
                    leading: Icon(profileItems[index]["icon"], size: 30),
                    title: ScText(profileItems[index]["name"]),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  );
                },
              )
            ])));
  }
}
