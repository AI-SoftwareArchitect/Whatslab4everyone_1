import 'package:whatslab4everyone_1/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrentUserLocalSaveService {
  final String _boxName = "currentUserBox";

  CurrentUserLocalSaveService();

  Future<Box<User>> get _box async =>
      await Hive.openBox<User>(_boxName);

//create
  Future<void> addPerson(User user) async {
    var box = await _box;
    await box.add(user);
  }

//read
  Future<List<User>> getAllPerson() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> update(int index, User user) async {
    var box = await _box;
    try {
      await box.putAt(index, user);
    }
    catch(err) {
      await box.add(user);
    }
  }

//delete
  Future<void> delete(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

}