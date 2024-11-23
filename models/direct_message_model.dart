import 'package:hive/hive.dart';

part 'direct_message_model.g.dart';

@HiveType(typeId: 5)
class DirectMessage {

    @HiveField(1)
    String senderName;
    @HiveField(2)
    String content;
    @HiveField(3)
    DateTime date;
    @HiveField(4)
    String contactUuid;

    DirectMessage({
        required this.senderName,
        required this.content,
        required this.date,
        required this.contactUuid,
    });

    factory DirectMessage.fromJson(Map<String,dynamic> json) {
        return DirectMessage(
            senderName: json["senderName"],
            content: json["messageContent"],
            date: DateTime.parse(json["date"]),
            contactUuid: json["senderId"],
        );
    }

}
