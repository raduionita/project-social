import 'package:project_social/app/extensions.dart';
import 'package:project_social/model/model.dart';

class UserModel extends Model {
  String id;

  String? name;
  double? birthdate; // 5.11 // 05.11
  int? birthyear; // 1986
  String? country; // "RO" ISO2
  String? city; // "Bucharest"
  String? gender; // "F" "M" "T" "O"
  String? bio;
  List<String> images = []; // ["site.com/...jpg"...]
  List<String> matches = []; // ["userId", "userId"]

  String? created; // "24011815" // YYMMDDHH
  String? updated; // "20240119" // YYYYMMDD

  UserModel({required this.id});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    final user = UserModel(id: map["id"] as String);

    return user;
  }

  DateTime getBirthday() => DateTime(birthyear!, birthdate!.toInt(), int.parse((birthdate! / 1000).toString().substring(5, 7)));
  void setBirthday(DateTime date) {
    birthyear = date.year;
    final mm = date.month;
    final dd = date.day > 10 ? "0${date.day}" : "${date.day}";
    birthdate = double.parse("$mm.$dd");
  }

  DateTime getCreated() => DateTime.parse("20${created}0000".insert(8, "T")); // 20240511T235900
  DateTime getUpdated() => DateTime.parse(updated ?? "1900-01-01");
}
