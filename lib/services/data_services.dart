import 'dart:async';

import '../db_helper/repository.dart';
import '../model/cost_data.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }

  //Save User
  SaveUser(User user) async {
    return await _repository.insertData('erpdata', user.UserMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('erpdata');
  }

  //Edit User
  UpdateUser(User user) async {
    return await _repository.updateData('erpdata', user.UserMap());
  }

  deleteUser(costDataId) async {
    return await _repository.deleteDataById('erpdata', costDataId);
  }
}
