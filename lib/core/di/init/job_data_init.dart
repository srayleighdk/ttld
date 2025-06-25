// job_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/ky_nang_mem_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';

Future<void> initializeJobData() async {
  final nganhNgheKTRepository = locator<NganhNgheRepository>();
  final nganhNgheTDRepository = locator<NganhNgheTDRepository>();
  final chucDanhRepository = locator<ChucDanhRepository>();
  final nganhNgheCapDoRepository = locator<NganhNgheCapDoRepository>();
  final nganhNgheBacHocRepository = locator<NganhNgheBacHocRepository>();
  final nganhNgheChuyenNganhRepository =
      locator<NganhNgheChuyenNganhRepository>();
  final kinhNghiemLamViecRepository = locator<KinhNghiemLamViecRepository>();
  final kyNangMemRepository = locator<KyNangMemRepository>();

  try {
    if (!locator.isRegistered<List<NganhNgheKT>>()) {
      final nganhNgheKTs = await nganhNgheKTRepository.getNganhNghes();
      locator.registerSingleton<List<NganhNgheKT>>(nganhNgheKTs);
    }
  } catch (e) {
    debugPrint('Error preloading nganh nghe: $e');
    if (!locator.isRegistered<List<NganhNgheKT>>()) {
      locator.registerSingleton<List<NganhNgheKT>>([]); // Fallback empty list
    }
  }

  try {
    if (!locator.isRegistered<List<NganhNgheTD>>()) {
      final nganhNgheTDs = await nganhNgheTDRepository.getNganhNgheTDs();
      locator.registerSingleton<List<NganhNgheTD>>(nganhNgheTDs);
    }
  } catch (e) {
    debugPrint('Error preloading nganh nghe: $e');
    if (!locator.isRegistered<List<NganhNgheTD>>()) {
      locator.registerSingleton<List<NganhNgheTD>>([]); // Fallback empty list
    }
  }

  try {
    if (!locator.isRegistered<List<ChucDanhModel>>()) {
      final chucDanhs = await chucDanhRepository.getChucDanhs();
      locator.registerSingleton<List<ChucDanhModel>>(chucDanhs);
    }
  } catch (e) {
    debugPrint('Error preloading chuc danh: $e');
  }

  try {
    if (!locator.isRegistered<List<NganhNgheCapDo>>()) {
      final nganhNgheCapDos =
          await nganhNgheCapDoRepository.getNganhNgheCapDos();
      locator.registerSingleton<List<NganhNgheCapDo>>(nganhNgheCapDos);
    }
  } catch (e) {
    debugPrint('Error preloading nganh nghe capdo: $e');
  }

  try {
    if (!locator.isRegistered<List<TrinhDoChuyenMon>>()) {
      final nganhNgheBacHocs =
          await nganhNgheBacHocRepository.getNganhNgheBacHocs();
      locator.registerSingleton<List<TrinhDoChuyenMon>>(nganhNgheBacHocs);
    }
  } catch (e) {
    debugPrint('Error preloading nganh nghe bachoc: $e');
  }

  try {
    if (!locator.isRegistered<List<NganhNgheChuyenNganh>>()) {
      final nganhNgheChuyenNganhs =
          await nganhNgheChuyenNganhRepository.getNganhNgheChuyenNganhs();
      locator
          .registerSingleton<List<NganhNgheChuyenNganh>>(nganhNgheChuyenNganhs);
    }
  } catch (e) {
    debugPrint('Error preloading nganh nghe chuyen nganh: $e');
  }

  try {
    if (!locator.isRegistered<List<KinhNghiemLamViec>>()) {
      final kinhNghiemLamViecs =
          await kinhNghiemLamViecRepository.getKinhNghiemLamViecList();
      locator.registerSingleton<List<KinhNghiemLamViec>>(kinhNghiemLamViecs);
    }
  } catch (e) {
    final kinhNghiemLamViecs =
        await kinhNghiemLamViecRepository.getKinhNghiemLamViecList();
    locator.registerSingleton<List<KinhNghiemLamViec>>(kinhNghiemLamViecs);
  }

  // Ky Nang Mem
  try {
    final kyNangMems = await kyNangMemRepository.getKyNangMems();
    locator.registerSingleton<List<KyNangMemModel>>(kyNangMems);
  } catch (e) {
    debugPrint('Error preloading ky nang mem: $e');
  }
}
