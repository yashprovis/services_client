import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/models/address_model.dart';

import '../widgets/sc_button.dart';
import '../widgets/sc_text.dart';
import '../widgets/sheets/address_sheet.dart';
import '../widgets/tiles/address_tile.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address";
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    //   UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 15, right: 20),
            child: Column(children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  const SizedBox(width: 12),
                  const ScText(
                    "Address",
                    size: 18,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const AddressTile(
                        address: Address(
                            id: "A001",
                            name: "Provis Technologies",
                            line1: "503, Signature Tower",
                            line2: "Tink Phatak",
                            city: "jaipur",
                            state: "raj",
                            pincode: "342001"));
                  },
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: ScButton(
                      text: "+ Add Address",
                      func: () {
                        addressSheet(context, null);
                      },
                      isLoading: false))
            ])));
  }
}
