import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 3)
class ContactData {
  @HiveField(1)
  String name;
  @HiveField(2)
  String contactUUID;
  @HiveField(3)
  String imageName;

  ContactData({
    required this.name,
    required this.imageName,
    required this.contactUUID,

  });

  @override
  String toString() {
    return "ContactData:<username: $name , imageName: $imageName , contactUUID: $contactUUID >";
  }

  factory ContactData.fromJson(Map<String, dynamic> json) {
    // Default to 'Unknown' if username is not present
    return ContactData(
      name: json["username"] ?? "Unknown",
      contactUUID: json["frienduserid"],
      imageName: json["profileImageName"] ?? "no image",
    );
  }
}