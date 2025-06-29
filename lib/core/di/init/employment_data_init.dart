// employment_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/do_tuoi_model.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/do_tuoi/do_tuoi_repository.dart';
import 'package:ttld/repositories/hinh_thuc_lam_viec_repository.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';
import 'package:ttld/repositories/loai_hop_dong_lao_dong_repository.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';
import 'package:ttld/repositories/tinh_trang_hd_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';

Future<void> initializeEmploymentData() async {
  final mucLuongRepository = locator<MucLuongRepository>();
  final doiTuongChinhSachRepository = locator<DoiTuongRepository>();
  final mucDichLamViecRepository = locator<MucDichLamViecRepository>();
  final hinhThucTDRepository = locator<HinhThucTuyenDungRepository>();
  final doTuoiRepository = locator<DoTuoiRepository>();
  final loaiHopDongLaoDongRepository = locator<LoaiHopDongLaoDongRepository>();
  final tinhTrangHDRepository = locator<TinhTrangHdRepository>();
  final hinhThucLamViecRepository = locator<HinhThucLamViecRepository>();
  final thoiGianLamViecRepository = locator<ThoiGianLamViecRepository>();

  

  

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

  // DoTuoi
  try {
    final doTuois = await doTuoiRepository.getDoTuois();
    locator.registerSingleton<List<DoTuoi>>(doTuois);
  } catch (e) {
    debugPrint('Error preloading do tuoi: $e');
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

  
}
