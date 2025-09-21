import 'package:corehive_store/app/config/helpers/logging_helper.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavController extends GetxController {
  final PersistentTabController tabController = PersistentTabController(
    initialIndex: 0,
  );

  void changeTab(int index) {
    AppLogger.log(' Changing tab to index: $index');
    tabController.jumpToTab(index);
  }
}
