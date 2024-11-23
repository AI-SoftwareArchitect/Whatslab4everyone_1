import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 4)
class Settings {

  @HiveField(1)
  String profileImageName;
  @HiveField(2)
  String chatBackgroundImageName;
  @HiveField(3)
  bool applyEncryptionForSavedLocalMessages;
  
  Settings({
    required this.profileImageName,
    required this.chatBackgroundImageName,
    required this.applyEncryptionForSavedLocalMessages
  });

}