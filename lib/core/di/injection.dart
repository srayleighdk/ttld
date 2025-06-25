import 'package:get_it/get_it.dart';
import 'package:ttld/core/di/setup/core.dart';
import 'package:ttld/core/di/setup/auth.dart';
import 'package:ttld/core/di/setup/user.dart';
import 'package:ttld/core/di/setup/location.dart';
import 'package:ttld/core/di/setup/industry.dart';
import 'package:ttld/core/di/setup/employment.dart';
import 'package:ttld/core/di/setup/profile.dart';
import 'package:ttld/core/di/setup/misc.dart';

// Export the locator so it can be imported from a single place
final locator = GetIt.instance;

bool _isLocatorSetup = false;

Future<void> setupLocator() async {
  if (_isLocatorSetup) {
    return; // Prevent duplicate setup
  }
  
  try {
    await setupCoreLocator();
    await setupAuthLocator();
    await setupUserLocator();
    await setupLocationLocator();
    await setupIndustryLocator();
    await setupEmploymentLocator();
    await setupProfileLocator();
    await setupMiscLocator();
    _isLocatorSetup = true;
  } catch (e) {
    print('Error setting up dependency injection: $e');
    // You might want to rethrow or handle differently based on your app's needs
    rethrow;
  }
}
