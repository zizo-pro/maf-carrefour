import 'package:maf_carrefour/constants/components.dart';
import 'package:maf_carrefour/modules/login_screen/login_screen.dart';
import 'package:maf_carrefour/shared/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

dynamic uId;
