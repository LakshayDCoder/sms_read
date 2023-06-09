import 'package:sms_read/repo/check_number_repo.dart';
import 'package:sms_read/utils/locator.dart';

class CheckNumberController {
  Future<bool> isNumberSafe(String phone) async {
    return locator.get<CheckNumberRepo>().isNumberSafe(phone);
  }
}
