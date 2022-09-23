import 'package:flutter/material.dart';

import '../models/address_model.dart';

import '../models/user_model.dart';
import '../services/address_service.dart';

import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser =>
      _user ??
      const User(
          name: "",
          uid: "",
          image: "",
          email: "",
          favourites: [],
          phone: "",
          gender: "");

  String? selectedCity;

  String? get getSelectedCity => selectedCity;

  Future<void> updateCity(String? city) async {
    selectedCity = city;

    notifyListeners();
  }

  Future<void> refreshUser() async {
    User user = await UserService().getUserDetails();
    _user = user;
    notifyListeners();
  }

  Future updateUser(
      {required String? name,
      required String? phone,
      required String? image,
      required String? gender,
      required BuildContext context}) async {
    await UserService().updateUserProfile(
        name: name,
        phone: phone,
        gender: gender,
        image: image,
        context: context);
    refreshUser();
  }

  Future addAddress({required Address address}) async {
    _user!.address!.add(address);
    notifyListeners();
  }

  Future removeAddress({required String id}) async {
    _user!.address!.removeWhere((e) => e.id == id);
    AddressService().removeAddressService(id: id);
    notifyListeners();
  }

  Future updateAddress({required Address address}) async {
    int i = _user!.address!.indexWhere((e) => e.id == address.id);
    _user!.address![i] = address;
    AddressService().updateAddressService(address: address);
    notifyListeners();
  }

  // Map filters = {};
  // Map get getFilters => filters;

  // bool searchFilters = false;
  // bool get getSearchFilters => searchFilters;

  // void setFilterSearch(bool value) {
  //   searchFilters = value;
  //   notifyListeners();
  // }

  // void addFilter([List? sizes, RangeValues? price]) {
  //   if (sizes != null) {
  //     filters['sizes'] = sizes;
  //   }
  //   if (price != null) {
  //     filters['startPrice'] = price.start;
  //     filters['endPrice'] = price.end;
  //   }
  //   notifyListeners();
  // }

  // void removeFilter({bool? removeSize, bool? removePrice}) {
  //   if (removeSize != null) {
  //     filters.remove("sizes");
  //   }
  //   if (removePrice != null) {
  //     filters.remove('startPrice');
  //     filters.remove('endPrice');
  //   }
  //   notifyListeners();
  // }

  // Future clearFilters() async {
  //   filters = {};
  //   notifyListeners();
  // }
}
