import 'package:hive/hive.dart';

part 'friend_request_model.g.dart';

@HiveType(typeId: 2)
class FriendRequest {
  @HiveField(1)
  String? senderName;
  @HiveField(2)
  String? senderUUID;

  FriendRequest({
    required this.senderName,
    required this.senderUUID,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> data) {
    return FriendRequest(
      senderName: data["sendername"] as String?,
      senderUUID: data["senderuuid"] as String?,
    );
  }
}
