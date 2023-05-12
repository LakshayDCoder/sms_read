import 'dart:math';

class CheckNumberRepo {
  Future<bool> checkMobileNumber(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
    int num = Random().nextInt(333);
    return num % 2 == 0;
  }
}
