import 'package:services_client/models/user_model.dart';

class Reviews {
  final String id;
  final String title;
  final double rating;
  final String description;
  // final User user;
  final DateTime date;

  const Reviews({
    required this.id,
    required this.rating,
    required this.title,
    required this.date,
    required this.description,
    //required this.user
  });
}
