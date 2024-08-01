import 'package:get/get.dart';
import 'package:jackpot_arena/NetworkCheck/alertBoxMethod.dart';
import 'package:jackpot_arena/NetworkCheck/networkChecking.dart';

class Dependencyinjection {
  static void init() {
    Get.put<NetworkChecking>(
      NetworkChecking(),
      permanent: true,
    );
  }
}
