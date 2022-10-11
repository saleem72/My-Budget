//

import 'package:get_it/get_it.dart';
import 'package:my_budget/helpers/safe/safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  final shared = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => Safe(storage: shared));
}
