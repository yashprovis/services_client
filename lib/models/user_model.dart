import 'address_model.dart';

class User {
  final String name;
  final String uid;
  final String phone;
  final String email;
  final String gender;
  final String? token;
  final List<Address>? address;
  final List? favourites;
  final String image;
  const User(
      {required this.name,
      this.token,
      required this.gender,
      this.favourites,
      required this.uid,
      required this.image,
      required this.email,
      this.address,
      required this.phone});

  static Future<User> fromSnap(Map json) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(tokenPref, json["token"]);
    return User(
      gender: json["gender"],
      name: json["name"],
      uid: json["_id"],
      phone: json["phone"],
      email: json["email"],
      address:
          List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      favourites: json["favourites"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "favourites": favourites,
        "image": image,
      };
}
