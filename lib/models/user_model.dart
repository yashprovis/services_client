import 'address_model.dart';

class User {
  final String name;
  final String uid;
  final String phone;
  final String email;
  final String city;
  final List<Address>? address;

  final String image;
  const User(
      {required this.name,
      required this.city,
      required this.uid,
      required this.image,
      required this.email,
      this.address,
      required this.phone});
}
