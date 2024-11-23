
import 'package:hive/hive.dart';

import '../models/direct_message_model.dart';

class DirectMessageService {
  static const String _boxName = 'direct_messages';

  static Future<void> init() async {
    await Hive.openBox<DirectMessage>(_boxName);
  }

  static Future<void> create(DirectMessage message) async {
    final box = Hive.box<DirectMessage>(_boxName);
    final keys = box.keys;
    for (var key in keys) {
      final existingMessage = box.get(key);
      if (existingMessage?.contactUuid == message.contactUuid) {
        return;
      }
    }
    await box.add(message);
  }


  static Future<List<DirectMessage>> readAll() async {
    final box = Hive.box<DirectMessage>(_boxName);
    return box.values.toList();
  }

  static Future<DirectMessage?> read(String contactUuid) async {
    final box = Hive.box<DirectMessage>(_boxName);
    final keys = box.keys;
    for (var key in keys) {
      final message = box.get(key);
      if (message?.contactUuid == contactUuid) {
        return message;
      }
    }
    return null;
  }

  static Future<void> update(DirectMessage message) async {
    final box = Hive.box<DirectMessage>(_boxName);
    final keys = box.keys;
    for (var key in keys) {
      final existingMessage = box.get(key);
      if (existingMessage?.contactUuid == message.contactUuid) {
        await box.put(key, message);
        break;
      }
    }
  }


  static Future<void> delete(String contactUuid) async {
    final box = Hive.box<DirectMessage>(_boxName);
    final keys = box.keys;
    for (var key in keys) {
      final message = box.get(key);
      if (message?.contactUuid == contactUuid) {
        await box.delete(key);
        break;
      }
    }
  }

}