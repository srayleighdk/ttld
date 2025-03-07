// app_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';

Future<void> initializeAppData() async {
  final quocGiaRepository = locator<QuocGiaRepository>();
  final hinhThucLoaiHinhRepository = locator<HinhThucLoaiHinhRepository>();
  final nganhNgheKTRepository = locator<NganhNgheRepository>();
  final nganhNgheTDRepository = locator<NganhNgheTDRepository>();
  final chucDanhRepository = locator<ChucDanhRepository>();
  final nganhNgheCapDoRepository = locator<NganhNgheCapDoRepository>();
  final trinhDoRepository = locator<TrinhDoHocVanRepository>();
  final nganhNgheBacHocRepository = locator<NganhNgheBacHocRepository>();
  final nganhNgheChuyenNganhRepository = locator<NganhNgheChuyenNganhRepository>();
  try {
    final quocGias = await quocGiaRepository.getQuocGias();
    locator.registerSingleton<List<QuocGia>>(quocGias);
    debugPrint('🌍 Loaded ${quocGias.length} QuocGia items at app start');
  } catch (e) {
    debugPrint('Error preloading quoc gia: $e');
    locator.registerSingleton<List<QuocGia>>([]); // Fallback empty list
  }
  try {
    final hinhThucLoaiHinhs =
        await hinhThucLoaiHinhRepository.getHinhThucLoaiHinhs();
    locator.registerSingleton<List<HinhThucLoaiHinh>>(hinhThucLoaiHinhs);
    debugPrint(
        '🌍 Loaded ${hinhThucLoaiHinhs.length} HinhThucLoaiHinh items at app start');
  } catch (e) {
    debugPrint('Error preloading hinh thuc loai hinh: $e');
  }
  try {
    final nganhNgheKTs = await nganhNgheKTRepository.getNganhNghes();
    locator.registerSingleton<List<NganhNgheKT>>(nganhNgheKTs);
    debugPrint(
        '🌍 Loaded ${nganhNgheKTs.length} NganhNgheKT items at app start');
  } catch (e) {
    debugPrint('Error preloading nganh nghe: $e');
    locator.registerSingleton<List<NganhNgheKT>>([]); // Fallback empty list
  }
  try {
    final nganhNgheTDs = await nganhNgheTDRepository.getNganhNgheTDs();
    locator.registerSingleton<List<NganhNgheTD>>(nganhNgheTDs);
    debugPrint(
        '🌍 Loaded ${nganhNgheTDs.length} NganhNgheTD items at app start');
  } catch (e) {
    debugPrint('Error preloading nganh nghe: $e');
    locator.registerSingleton<List<NganhNgheTD>>([]); // Fallback empty list
  }
  try {
    final chucDanhs = await chucDanhRepository.getChucDanhs();
    locator.registerSingleton<List<ChucDanhModel>>(chucDanhs);
    debugPrint(
        '🌍 Loaded ${chucDanhs.length} ChucDanhModel items at app start');
  } catch (e) {
    debugPrint('Error preloading chuc danh: $e');
  }
  try {
    final nganhNgheCapDos = await nganhNgheCapDoRepository.getNganhNgheCapDos();
    locator.registerSingleton<List<NganhNgheCapDo>>(nganhNgheCapDos);
    debugPrint(
        '🌍 Loaded ${nganhNgheCapDos.length} NganhNgheCapDo items at app start');
  } catch (e) {
    debugPrint('Error preloading nganh nghe capdo: $e');
  }
  try {
    final trinhDoHocVans = await trinhDoRepository.getTrinhDoHocVans();
    locator.registerSingleton<List<TrinhDoHocVan>>(trinhDoHocVans);
    debugPrint(
        '🌍 Loaded ${trinhDoHocVans.length} TrinhDoHocVan items at app start');
  } catch (e) {
    debugPrint('Error preloading trinh do hoc van: $e');
  }
  try {
    final nganhNgheBacHocs = await nganhNgheBacHocRepository.getNganhNgheBacHocs();
    locator.registerSingleton<List<NganhNgheBacHoc>>(nganhNgheBacHocs);
    debugPrint(
        '🌍 Loaded ${nganhNgheBacHocs.length} NganhNgheBacHoc items at app start');
  } catch (e) {
    debugPrint('Error preloading nganh nghe bachoc: $e');
  }
  try {
    final nganhNgheChuyenNganhs = await nganhNgheChuyenNganhRepository.getNganhNgheChuyenNganhs();
    locator.registerSingleton<List<NganhNgheChuyenNganh>>(nganhNgheChuyenNganhs);
    debugPrint(
        '🌍 Loaded ${nganhNgheChuyenNganhs.length} NganhNgheChuyenNganh items at app start');
  } catch (e) {
    debugPrint('Error preloading nganh nghe chuyen nganh: $e');
  }
}
