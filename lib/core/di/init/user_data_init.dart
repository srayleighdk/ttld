// user_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/blocs/tinh_thanh/tinh_thanh_cubit.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/user/manv_name_model.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';
import 'package:ttld/repositories/user/user_repository.dart';

Future<void> initializeUserData() async {
  final tinhThanhRepository = locator<TinhThanhCubit>();
  final userRepository = locator<UserRepository>();
  final danTocRepository = locator<DanTocRepository>();

  try {
    final tinhThanhs = await tinhThanhRepository.loadTinhThanhs();
    locator.registerSingleton<List<TinhThanhModel>>(tinhThanhs);
  } catch (e) {
    debugPrint('Error preloading tinh thanh: $e');
  }

  try {
    final users = await userRepository.getManvName();
    locator.registerSingleton<List<ManvNameModel>>(users);
  } catch (e) {
    debugPrint('Error preloading user: $e');
  }

  // Dan Toc
  try {
    if (!locator.isRegistered<List<DanToc>>()) {
      final danTocs = await danTocRepository.getDanTocs();
      locator.registerSingleton<List<DanToc>>(danTocs);
    }
  } catch (e) {
    debugPrint('Error preloading dan toc: $e');
    if (!locator.isRegistered<List<DanToc>>()) {
      locator.registerSingleton<List<DanToc>>([]); // Fallback empty list
    }
  }

  // Tinh Trang Tan Tat
}
