// app_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/bloc/tinh_thanh/tinh_thanh_cubit.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/chuc_danh_model.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_chuyennganh_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_td_repository.dart';
import 'package:ttld/repositories/ngoai_ngu/ngoai_ngu_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';

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
  final trinhDoTinHocRepository = locator<TrinhDoTinHocRepository>();
  final ngoaiNguRepository = locator<NgoaiNguRepository>();
  final trinhDoNgoaiNguRepository = locator<TrinhDoNgoaiNguRepository>();
  final kinhNghiemLamViecRepository = locator<KinhNghiemLamViecRepository>();
  final tinhThanhRepository = locator<TinhThanhCubit>();
  // Thoi gian lam viec
  final thoiGianLamViecRepository = locator<ThoiGianLamViecRepository>();
  // Muc Luong
  final mucLuongRepository = locator<MucLuongRepository>();
  // Doi Tuong Chinh Sach
  final doiTuongChinhSachRepository = locator<DoiTuongRepository>();
  // Muc Dich Lam Viec
  final mucDichLamViecRepository = locator<MucDichLamViecRepository>();
  // Hinh Thuc TD
  final hinhThucTDRepository = locator<HinhThucTuyenDungRepository>();
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
  try {
    final trinhDoTinHocs = await trinhDoTinHocRepository.getTrinhDoTinHocs();
    locator.registerSingleton<List<TrinhDoTinHoc>>(trinhDoTinHocs);
    debugPrint(
        '🌍 Loaded ${trinhDoTinHocs.length} TrinhDoTinHoc items at app start');
  } catch (e) {
    debugPrint('Error preloading trinh do tin hoc: $e');
  }
  try {
    final ngoaiNgus = await ngoaiNguRepository.getNgoaiNgus();
    locator.registerSingleton<List<NgoaiNgu>>(ngoaiNgus);
    debugPrint(
        '🌍 Loaded ${ngoaiNgus.length} NgoaiNgu items at app start');
  } catch (e) {
    debugPrint('Error preloading ngoai ngu: $e');
  }
  try {
    final trinhDoNgoaiNgus = await trinhDoNgoaiNguRepository.getTrinhDoNgoaiNgus();
    locator.registerSingleton<List<TrinhDoNgoaiNgu>>(trinhDoNgoaiNgus);
    debugPrint(
        '🌍 Loaded ${trinhDoNgoaiNgus.length} TrinhDoNgoaiNgu items at app start');
  } catch (e) {
    debugPrint('Error preloading trinh do ngoai ngu: $e');
  }
  try {
    final kinhNghiemLamViecs = await kinhNghiemLamViecRepository.getKinhNghiemLamViecs();
    locator.registerSingleton<List<KinhNghiemLamViec>>(kinhNghiemLamViecs);
    debugPrint(
        '🌍 Loaded ${kinhNghiemLamViecs.length} KinhNghiemLamViec items at app start');
  } catch (e) {
    debugPrint('Error preloading kinh nghiem lam viec: $e');
  }
  try {
    final tinhThanhs = await tinhThanhRepository.loadTinhThanhs();
    locator.registerSingleton<List<TinhThanhModel>>(tinhThanhs);
    debugPrint(
        '🌍 Loaded ${tinhThanhs.length} TinhThanh items at app start');
  } catch (e) {
    debugPrint('Error preloading tinh thanh: $e');
  }
  // Thoi gian lam viec
  try {
    final thoiGianLamViecs = await thoiGianLamViecRepository.getThoiGianLamViecs();
    locator.registerSingleton<List<ThoiGianLamViec>>(thoiGianLamViecs);
    debugPrint(
        '🌍 Loaded ${thoiGianLamViecs.length} ThoiGianLamViec items at app start');
  } catch (e) {
    debugPrint('Error preloading thoi gian lam viec: $e');
  }
  // Muc Luong
  try {
    final mucLuongs = await mucLuongRepository.getMucLuongs();
    locator.registerSingleton<List<MucLuongMM>>(mucLuongs);
    debugPrint('🌍 Loaded ${mucLuongs.length} MucLuong items at app start');
  } catch (e) {
    debugPrint('Error preloading muc luong: $e');
  }
  // Doi Tuong Chinh Sach
  try {
    final doiTuongChinhSaches = await doiTuongChinhSachRepository.getDoiTuongs();
    locator.registerSingleton<List<DoiTuong>>(doiTuongChinhSaches);
    debugPrint('🌍 Loaded ${doiTuongChinhSaches.length} DoiTuongChinhSach items at app start');
  } catch (e) {
    debugPrint('Error preloading doi tuong chinh sach: $e');
  }
  // Muc Dich Lam Viec
  try {
    final mucDichLamViecs = await mucDichLamViecRepository.getMucDichLamViec();
    locator.registerSingleton<List<MucDichLamViec>>(mucDichLamViecs);
    debugPrint('🌍 Loaded ${mucDichLamViecs.length} MucDichLamViec items at app start');
  } catch (e) { 
    debugPrint('Error preloading muc dich lam viec: $e');
  }
  // Hinh Thuc TD
  try {
    final hinhThucTDs = await hinhThucTDRepository.getHinhThucTuyenDung();
    locator.registerSingleton<List<HinhThucTuyenDung>>(hinhThucTDs);
    debugPrint('🌍 Loaded ${hinhThucTDs.length} HinhThucTuyenDung items at app start');
  } catch (e) {
    debugPrint('Error preloading hinh thuc td: $e');
  }
}
