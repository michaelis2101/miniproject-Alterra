import 'package:get/get.dart';

class UserController extends GetxController {
  RxString uid = ''.obs;

  void setUserUid(String newUid) {
    uid.value = newUid;
  }
}

final userController = UserController();
