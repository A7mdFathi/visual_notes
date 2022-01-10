import 'package:floor/floor.dart';

@entity
class Item {
  @primaryKey
  final int id;
  final String title;
  final String img;
  final String description;
  final DateTime dateTime;
  final bool status;

  Item({
    required this.id,
    required this.title,
    required this.img,
    required this.description,
    required this.dateTime,
    required this.status,
  });
}
