import 'package:get_it/get_it.dart';
import 'package:ttld/core/di/init/employment_data_init.dart';
import 'package:ttld/core/di/init/job_data_init.dart';
import 'package:ttld/core/di/init/misc_data_init.dart';
import 'package:ttld/core/di/init/user_data_init.dart';

final locator = GetIt.instance;

Future<void> initializeAppData() async {
  // Initialize miscellaneous data and job data
  // Other data initialization might cause duplicate registrations or access unregistered repositories
  await initializeMiscData();
  await initializeJobData();
  await initializeUserData(); // Add this line to initialize DanToc and other user data
}
