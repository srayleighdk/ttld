// misc_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/models/ngoai_ngu_model.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/models/quocgia/quocgia_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';
import 'package:ttld/repositories/kieuchapnoi_repository.dart';
import 'package:ttld/repositories/loai_hinh/loai_hinh_repository.dart';
import 'package:ttld/repositories/ngoai_ngu/ngoai_ngu_repository.dart';
import 'package:ttld/repositories/nguon_thuthap/nguon_thuthap_repository.dart';
import 'package:ttld/repositories/quocgia/quocgia_repository.dart';
import 'package:ttld/repositories/trinh_do_hoc_van/trinh_do_hoc_van_repository.dart';
import 'package:ttld/repositories/trinh_do_ngoai_ngu/trinh_do_ngoai_ngu_repository.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';
import 'package:ttld/models/ca_lam_viec_model.dart';
import 'package:ttld/repositories/ca_lam_viec/ca_lam_viec_repository.dart';
import 'package:ttld/models/nguyen_nhan_that_nghiep_model.dart';
import 'package:ttld/repositories/nguyen_nhan_that_nghiep/nguyen_nhan_that_nghiep_repository.dart';
import 'package:ttld/models/ve_tinh_model.dart';
import 'package:ttld/repositories/ve_tinh/ve_tinh_repository.dart';

Future<void> initializeMiscData() async {
  final quocGiaRepository = locator<QuocGiaRepository>();
  final hinhThucLoaiHinhRepository = locator<HinhThucLoaiHinhRepository>();
  final trinhDoRepository = locator<TrinhDoHocVanRepository>();
  final trinhDoTinHocRepository = locator<TrinhDoTinHocRepository>();
  final ngoaiNguRepository = locator<NgoaiNguRepository>();
  final caLamViecRepository = locator<CaLamViecRepository>();
  final nguyenNhanThatNghiepRepository = locator<NguyenNhanThatNghiepRepository>();
  final veTinhRepository = locator<VeTinhRepository>();
  final trinhDoNgoaiNguRepository = locator<TrinhDoNgoaiNguRepository>();
  final kieuChapNoiRepository = locator<KieuChapNoiRepository>();
  final nguonThuThapRepository = locator<NguonThuThapRepository>();
  final hinhThucDoanhNghiepRepository =
      locator<HinhThucDoanhNghiepRepository>();
  final loaiHinhRepository = locator<LoaiHinhRepository>();

  try {
    if (!locator.isRegistered<List<QuocGia>>()) {
      final quocGias = await quocGiaRepository.getQuocGias();
      locator.registerSingleton<List<QuocGia>>(quocGias);
    }
  } catch (e) {
    if (!locator.isRegistered<List<QuocGia>>()) {
      locator.registerSingleton<List<QuocGia>>([]); // Fallback empty list
    }
  }

  try {
    if (!locator.isRegistered<List<HinhThucLoaiHinh>>()) {
      final hinhThucLoaiHinhs =
          await hinhThucLoaiHinhRepository.getHinhThucLoaiHinhs();
      locator.registerSingleton<List<HinhThucLoaiHinh>>(hinhThucLoaiHinhs);
    }
  } catch (e) {
    debugPrint('Error preloading hinh thuc loai hinh: $e');
  }

  try {
    if (!locator.isRegistered<List<TrinhDoHocVan>>()) {
      final trinhDoHocVans = await trinhDoRepository.getTrinhDoHocVans();
      locator.registerSingleton<List<TrinhDoHocVan>>(trinhDoHocVans);
    }
  } catch (e) {
    debugPrint('Error preloading trinh do hoc van: $e');
  }

  try {
    if (!locator.isRegistered<List<TrinhDoTinHoc>>()) {
      final trinhDoTinHocs = await trinhDoTinHocRepository.getTrinhDoTinHocs();
      locator.registerSingleton<List<TrinhDoTinHoc>>(trinhDoTinHocs);
    }
  } catch (e) {
    debugPrint('Error preloading trinh do tin hoc: $e');
  }

  try {
    if (!locator.isRegistered<List<NgoaiNgu>>()) {
      final ngoaiNgus = await ngoaiNguRepository.getNgoaiNgus();
      locator.registerSingleton<List<NgoaiNgu>>(ngoaiNgus);
    }
  } catch (e) {
    debugPrint('Error preloading ngoai ngu: $e');
  }

  try {
    if (!locator.isRegistered<List<TrinhDoNgoaiNgu>>()) {
      final trinhDoNgoaiNgus =
          await trinhDoNgoaiNguRepository.getTrinhDoNgoaiNgus();
      locator.registerSingleton<List<TrinhDoNgoaiNgu>>(trinhDoNgoaiNgus);
    }
  } catch (e) {
    debugPrint('Error preloading trinh do ngoai ngu: $e');
  }

  // NgoaiNgu (from /common/td-nn)
  try {
    if (!locator.isRegistered<List<NgoaiNgu>>()) {
      debugPrint('🔄 Loading NgoaiNgu data...');
      final ngoaiNgus = await ngoaiNguRepository.getNgoaiNgus();
      debugPrint('✅ NgoaiNgu loaded: ${ngoaiNgus.length} items');
      locator.registerSingleton<List<NgoaiNgu>>(ngoaiNgus);
    } else {
      debugPrint('⚠️ NgoaiNgu already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading ngoai ngu: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<NgoaiNgu>>()) {
      locator.registerSingleton<List<NgoaiNgu>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty NgoaiNgu list as fallback');
    }
  }

  // Kieu Chap Noi
  try {
    final kieuChapNois = await kieuChapNoiRepository.getKieuChapNois();
    locator.registerSingleton<List<KieuChapNoiModel>>(kieuChapNois);
  } catch (e) {
    debugPrint('Error preloading kieu chap noi: $e');
  }

  // Nguon Thu Thap
  try {
    if (!locator.isRegistered<List<NguonThuThap>>()) {
      final nguonThuThaps = await nguonThuThapRepository.getNguonThuThaps();
      locator.registerSingleton<List<NguonThuThap>>(nguonThuThaps);
    }
  } catch (e) {
    debugPrint('Error preloading nguon thu thap: $e');
    if (!locator.isRegistered<List<NguonThuThap>>()) {
      locator.registerSingleton<List<NguonThuThap>>([]); // Fallback empty list
    }
  }

  // Hinh Thuc Doanh Nghiep
  try {
    if (!locator.isRegistered<List<HinhThucDoanhNghiep>>()) {
      final hinhThucDoanhNghieps =
          await hinhThucDoanhNghiepRepository.getHinhThucDoanhNghieps();
      locator
          .registerSingleton<List<HinhThucDoanhNghiep>>(hinhThucDoanhNghieps);
    }
  } catch (e) {
    debugPrint('Error preloading hinh thuc doanh nghiep: $e');
    if (!locator.isRegistered<List<HinhThucDoanhNghiep>>()) {
      locator.registerSingleton<List<HinhThucDoanhNghiep>>(
          []); // Fallback empty list
    }
  }

  // Loai Hinh
  try {
    if (!locator.isRegistered<List<LoaiHinh>>()) {
      final loaiHinhs = await loaiHinhRepository.getLoaiHinhs();
      locator.registerSingleton<List<LoaiHinh>>(loaiHinhs);
    }
  } catch (e) {
    debugPrint('Error preloading loai hinh: $e');
    if (!locator.isRegistered<List<LoaiHinh>>()) {
      locator.registerSingleton<List<LoaiHinh>>([]); // Fallback empty list
    }
  }

  // Ca Lam Viec (TblDmCaLamViec) - from /bo-sung/ca-lam
  try {
    if (!locator.isRegistered<List<CaLamViec>>()) {
      debugPrint('🔄 Loading CaLamViec data...');
      final caLamViecs = await caLamViecRepository.getCaLamViecs();
      debugPrint('✅ CaLamViec loaded: ${caLamViecs.length} items');
      locator.registerSingleton<List<CaLamViec>>(caLamViecs);
    } else {
      debugPrint('⚠️ CaLamViec already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading ca lam viec: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<CaLamViec>>()) {
      locator.registerSingleton<List<CaLamViec>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty CaLamViec list as fallback');
    }
  }

  // Nguyen Nhan That Nghiep (TblDmNguyenNhanThatNghiep) - from /common/nguyen-nhan-tn
  try {
    if (!locator.isRegistered<List<NguyenNhanThatNghiep>>()) {
      debugPrint('🔄 Loading NguyenNhanThatNghiep data...');
      final nguyenNhanThatNghieps = await nguyenNhanThatNghiepRepository.getNguyenNhanThatNghieps();
      debugPrint('✅ NguyenNhanThatNghiep loaded: ${nguyenNhanThatNghieps.length} items');
      locator.registerSingleton<List<NguyenNhanThatNghiep>>(nguyenNhanThatNghieps);
    } else {
      debugPrint('⚠️ NguyenNhanThatNghiep already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading nguyen nhan that nghiep: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<NguyenNhanThatNghiep>>()) {
      locator.registerSingleton<List<NguyenNhanThatNghiep>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty NguyenNhanThatNghiep list as fallback');
    }
  }

  // VeTinh (bhtnVeTinh) - from /danhmuc/vetinh
  try {
    if (!locator.isRegistered<List<VeTinh>>()) {
      debugPrint('🔄 Loading VeTinh data...');
      final veTinhs = await veTinhRepository.getVeTinhs();
      debugPrint('✅ VeTinh loaded: ${veTinhs.length} items');
      locator.registerSingleton<List<VeTinh>>(veTinhs);
    } else {
      debugPrint('⚠️ VeTinh already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading ve tinh: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<VeTinh>>()) {
      locator.registerSingleton<List<VeTinh>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty VeTinh list as fallback');
    }
  }
}
