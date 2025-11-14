// employment_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';
import 'package:ttld/models/lydo_nghiviec/lydo_nghiviec_model.dart';
import 'package:ttld/repositories/hinh_thuc_lam_viec_repository.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';
import 'package:ttld/repositories/loai_hop_dong_lao_dong_repository.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';
import 'package:ttld/repositories/tinh_trang_hd_repository.dart';
import 'package:ttld/repositories/lydo_nghiviec/lydo_nghiviec_repository.dart';

Future<void> initializeEmploymentData() async {
  final mucDichLamViecRepository = locator<MucDichLamViecRepository>();
  final hinhThucTDRepository = locator<HinhThucTuyenDungRepository>();
  final loaiHopDongLaoDongRepository = locator<LoaiHopDongLaoDongRepository>();
  final tinhTrangHDRepository = locator<TinhTrangHdRepository>();
  final hinhThucLamViecRepository = locator<HinhThucLamViecRepository>();
  final lydoNghiviecRepository = locator<LydoNghiviecRepository>();

  // Muc Dich Lam Viec
  try {
    final mucDichLamViecs = await mucDichLamViecRepository.getMucDichLamViec();
    locator.registerSingleton<List<MucDichLamViec>>(mucDichLamViecs);
  } catch (e) {
    debugPrint('Error preloading muc dich lam viec: $e');
  }

  // Hinh Thuc TD
  try {
    final hinhThucTDs = await hinhThucTDRepository.getHinhThucTuyenDung();
    locator.registerSingleton<List<HinhThucTuyenDung>>(hinhThucTDs);
  } catch (e) {
    debugPrint('Error preloading hinh thuc td: $e');
  }

  // Loai Hop Dong Lao Dong
  try {
    final loaiHopDongLaoDongs =
        await loaiHopDongLaoDongRepository.getLoaiHopDong();
    locator.registerSingleton<List<LoaiHopDongLaoDong>>(loaiHopDongLaoDongs);
  } catch (e) {
    debugPrint('Error preloading loai hop dong lao dong: $e');
  }

  // Tinh Trang Hop Dong Cubit
  try {
    final tinhTrangHds = await tinhTrangHDRepository.fetchTinhTrangHd();
    locator.registerSingleton<List<TinhTrangHdModel>>(tinhTrangHds);
  } catch (e) {
    debugPrint('Error preloading tinh trang hop dong: $e');
  }

  // Hinh Thuc Lam Viec
  try {
    final hinhThucLamViecs =
        await hinhThucLamViecRepository.getHinhThucLamViecs();
    locator.registerSingleton<List<HinhThucLamViecModel>>(hinhThucLamViecs);
  } catch (e) {
    debugPrint('Error preloading hinh thuc lam viec: $e');
  }

  // Lydo Nghiviec
  try {
    if (!locator.isRegistered<List<LydoNghiviec>>()) {
      final lydoNghiviecs = await lydoNghiviecRepository.getLydoNghiviecs();
      locator.registerSingleton<List<LydoNghiviec>>(lydoNghiviecs);
    }
  } catch (e) {
    debugPrint('Error preloading lydo nghiviec: $e');
    if (!locator.isRegistered<List<LydoNghiviec>>()) {
      locator.registerSingleton<List<LydoNghiviec>>([]); // Fallback empty list
    }
  }
}
