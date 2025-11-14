// user_data_init.dart
import 'package:flutter/material.dart';
import 'package:ttld/blocs/tinh_thanh/tinh_thanh_cubit.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/models/tinh_thanh_model.dart';
import 'package:ttld/models/user/manv_name_model.dart';
import 'package:ttld/models/ton_giao_model.dart';
import 'package:ttld/models/do_tuoi_model.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';
import 'package:ttld/repositories/user/user_repository.dart';
import 'package:ttld/repositories/ton_giao/ton_giao_repository.dart';
import 'package:ttld/repositories/do_tuoi/do_tuoi_repository.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';
import 'package:ttld/repositories/trinh_do_van_hoa/trinh_do_van_hoa_repository.dart';
import 'package:ttld/models/muc_luong_mm.dart';
import 'package:ttld/repositories/muc_luong/muc_luong_repository.dart';
import 'package:ttld/models/thoigianlamviec_model.dart';
import 'package:ttld/repositories/thoigianlamviec/thoigianlamviec_repository.dart';
import 'package:ttld/models/tinh/tinh.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';
import 'package:ttld/repositories/tblDmChuyenMon/chuyenmon_repository.dart';
import 'package:ttld/models/tinh_trangvl_model.dart';
import 'package:ttld/repositories/tinh_trangvl/tinh_trangvl_repository.dart';
import 'package:ttld/models/status_vieclam_model.dart';
import 'package:ttld/repositories/status_vieclam/status_vieclam_repository.dart';
import 'package:ttld/models/bac_mon_dao_tao_model.dart';
import 'package:ttld/repositories/bac_mon_dao_tao/bac_mon_dao_tao_repository.dart';
import 'package:ttld/models/chuyen_nganh_dao_tao_model.dart';
import 'package:ttld/repositories/chuyen_nganh_dao_tao/chuyen_nganh_dao_tao_repository.dart';
import 'package:ttld/models/status_dg_model.dart';
import 'package:ttld/repositories/status_dg/status_dg_repository.dart';

Future<void> initializeUserData() async {
  final tinhThanhRepository = locator<TinhThanhCubit>();
  final userRepository = locator<UserRepository>();
  final danTocRepository = locator<DanTocRepository>();
  final tonGiaoRepository = locator<TonGiaoRepository>();
  final doTuoiRepository = locator<DoTuoiRepository>();
  final doiTuongChinhSachRepository = locator<DoiTuongRepository>();
  final trinhDoVanHoaRepository = locator<TrinhDoVanHoaRepository>();
  final mucLuongRepository = locator<MucLuongRepository>();
  final thoiGianLamViecRepository = locator<ThoiGianLamViecRepository>();
  final tinhRepository = locator<TinhRepository>();
  final chuyenMonRepository = locator<ChuyenMonRepository>();
  final tinhTrangVLRepository = locator<TinhTrangVLRepository>();
  final statusViecLamRepository = locator<StatusViecLamRepository>();
  final bacMonDaoTaoRepository = locator<BacMonDaoTaoRepository>();
  final chuyenNganhDaoTaoRepository = locator<ChuyenNganhDaoTaoRepository>();
  final statusDgRepository = locator<StatusDgRepository>();

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

  // Ton Giao
  try {
    if (!locator.isRegistered<List<TonGiao>>()) {
      final tonGiaos = await tonGiaoRepository.getTonGiaos();
      locator.registerSingleton<List<TonGiao>>(tonGiaos);
    }
  } catch (e) {
    debugPrint('Error preloading ton giao: $e');
    if (!locator.isRegistered<List<TonGiao>>()) {
      locator.registerSingleton<List<TonGiao>>([]); // Fallback empty list
    }
  }

  // Do Tuoi
  try {
    if (!locator.isRegistered<List<DoTuoi>>()) {
      final doTuois = await doTuoiRepository.getDoTuois();
      locator.registerSingleton<List<DoTuoi>>(doTuois);
    }
  } catch (e) {
    debugPrint('Error preloading do tuoi: $e');
    if (!locator.isRegistered<List<DoTuoi>>()) {
      locator.registerSingleton<List<DoTuoi>>([]); // Fallback empty list
    }
  }

  // TtTantat
  try {
    if (!locator.isRegistered<List<TtTantat>>()) {
      final ttTantats = await locator<TtTantatRepository>().getTtTantat();
      locator.registerSingleton<List<TtTantat>>(ttTantats);
    }
  } catch (e) {
    debugPrint('Error preloading TtTantat: $e');
    if (!locator.isRegistered<List<TtTantat>>()) {
      locator.registerSingleton<List<TtTantat>>([]); // Fallback empty list
    }
  }

  // Doi Tuong Chinh Sach
  try {
    if (!locator.isRegistered<List<DoiTuong>>()) {
      final doiTuongChinhSaches =
          await doiTuongChinhSachRepository.getDoiTuongs();
      locator.registerSingleton<List<DoiTuong>>(doiTuongChinhSaches);
    }
  } catch (e) {
    debugPrint('Error preloading doi tuong chinh sach: $e');
    if (!locator.isRegistered<List<DoiTuong>>()) {
      locator.registerSingleton<List<DoiTuong>>([]); // Fallback empty list
    }
  }

  // Trinh Do Van Hoa
  try {
    if (!locator.isRegistered<List<TrinhDoVanHoa>>()) {
      final trinhDoVanHoas = await trinhDoVanHoaRepository.getTrinhDoVanHoas();
      locator.registerSingleton<List<TrinhDoVanHoa>>(trinhDoVanHoas);
    }
  } catch (e) {
    debugPrint('Error preloading TrinhDoVanHoa: $e');
    if (!locator.isRegistered<List<TrinhDoVanHoa>>()) {
      locator.registerSingleton<List<TrinhDoVanHoa>>([]); // Fallback empty list
    }
  }

  // Muc Luong
  try {
    if (!locator.isRegistered<List<MucLuongMM>>()) {
      final mucLuongs = await mucLuongRepository.getMucLuongs();
      locator.registerSingleton<List<MucLuongMM>>(mucLuongs);
    }
  } catch (e) {
    debugPrint('Error preloading muc luong: $e');
    if (!locator.isRegistered<List<MucLuongMM>>()) {
      locator.registerSingleton<List<MucLuongMM>>([]); // Fallback empty list
    }
  }

  // Thoi Gian Lam Viec
  try {
    if (!locator.isRegistered<List<ThoiGianLamViec>>()) {
      final thoiGianLamViecs =
          await thoiGianLamViecRepository.getThoiGianLamViecs();
      locator.registerSingleton<List<ThoiGianLamViec>>(thoiGianLamViecs);
    }
  } catch (e) {
    debugPrint('Error preloading thoi gian lam viec: $e');
    if (!locator.isRegistered<List<ThoiGianLamViec>>()) {
      locator
          .registerSingleton<List<ThoiGianLamViec>>([]); // Fallback empty list
    }
  }

  // Tinh
  try {
    if (!locator.isRegistered<List<Tinh>>()) {
      final tinhs = await tinhRepository.getTinhs();
      locator.registerSingleton<List<Tinh>>(tinhs);
    }
  } catch (e) {
    debugPrint('Error preloading tinh: $e');
    if (!locator.isRegistered<List<Tinh>>()) {
      locator.registerSingleton<List<Tinh>>([]); // Fallback empty list
    }
  }

  // ChuyenMon
  try {
    if (!locator.isRegistered<List<ChuyenMon>>()) {
      debugPrint('🔄 Loading ChuyenMon data...');
      final chuyenMons = await chuyenMonRepository.getChuyenMons();
      debugPrint('✅ ChuyenMon loaded: ${chuyenMons.length} items');
      locator.registerSingleton<List<ChuyenMon>>(chuyenMons);
    } else {
      debugPrint('⚠️ ChuyenMon already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading chuyen mon: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<ChuyenMon>>()) {
      locator.registerSingleton<List<ChuyenMon>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty ChuyenMon list as fallback');
    }
  }

  // TinhTrangViecLam
  try {
    if (!locator.isRegistered<List<TinhTrangViecLam>>()) {
      final tinhTrangVLs = await tinhTrangVLRepository.getTinhTrangVLs();
      locator.registerSingleton<List<TinhTrangViecLam>>(tinhTrangVLs);
    }
  } catch (e) {
    debugPrint('Error preloading tinh trang viec lam: $e');
    if (!locator.isRegistered<List<TinhTrangViecLam>>()) {
      locator.registerSingleton<List<TinhTrangViecLam>>([]); // Fallback empty list
    }
  }

  // StatusViecLam (TblDmStatusViecLam) - from /common/status-vl
  try {
    if (!locator.isRegistered<List<StatusViecLam>>()) {
      debugPrint('🔄 Loading StatusViecLam data...');
      final statusViecLams = await statusViecLamRepository.getStatusViecLams();
      debugPrint('✅ StatusViecLam loaded: ${statusViecLams.length} items');
      locator.registerSingleton<List<StatusViecLam>>(statusViecLams);
    } else {
      debugPrint('⚠️ StatusViecLam already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading status viec lam: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<StatusViecLam>>()) {
      locator.registerSingleton<List<StatusViecLam>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty StatusViecLam list as fallback');
    }
  }

  // BacMonDaoTao (TblDmBacMonDaoTao) - from /common/bac-hoc
  try {
    if (!locator.isRegistered<List<BacMonDaoTao>>()) {
      debugPrint('🔄 Loading BacMonDaoTao data...');
      final bacMonDaoTaos = await bacMonDaoTaoRepository.getBacMonDaoTaos();
      debugPrint('✅ BacMonDaoTao loaded: ${bacMonDaoTaos.length} items');
      locator.registerSingleton<List<BacMonDaoTao>>(bacMonDaoTaos);
    } else {
      debugPrint('⚠️ BacMonDaoTao already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading bac mon dao tao: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<BacMonDaoTao>>()) {
      locator.registerSingleton<List<BacMonDaoTao>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty BacMonDaoTao list as fallback');
    }
  }

  // ChuyenNganhDaoTao (TblDmBacDaoTaoC3) - from /common/chuyen-nganh
  try {
    if (!locator.isRegistered<List<ChuyenNganhDaoTao>>()) {
      debugPrint('🔄 Loading ChuyenNganhDaoTao data...');
      final chuyenNganhDaoTaos = await chuyenNganhDaoTaoRepository.getChuyenNganhDaoTaos();
      debugPrint('✅ ChuyenNganhDaoTao loaded: ${chuyenNganhDaoTaos.length} items');
      locator.registerSingleton<List<ChuyenNganhDaoTao>>(chuyenNganhDaoTaos);
    } else {
      debugPrint('⚠️ ChuyenNganhDaoTao already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading chuyen nganh dao tao: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<ChuyenNganhDaoTao>>()) {
      locator.registerSingleton<List<ChuyenNganhDaoTao>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty ChuyenNganhDaoTao list as fallback');
    }
  }

  // StatusDg (TblDmStatusDG) - from /common/status-dg
  try {
    if (!locator.isRegistered<List<StatusDg>>()) {
      debugPrint('🔄 Loading StatusDg data...');
      final statusDgs = await statusDgRepository.getStatusDgs();
      debugPrint('✅ StatusDg loaded: ${statusDgs.length} items');
      locator.registerSingleton<List<StatusDg>>(statusDgs);
    } else {
      debugPrint('⚠️ StatusDg already registered');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error preloading status dg: $e');
    debugPrint('Stack trace: $stackTrace');
    if (!locator.isRegistered<List<StatusDg>>()) {
      locator.registerSingleton<List<StatusDg>>([]); // Fallback empty list
      debugPrint('⚠️ Registered empty StatusDg list as fallback');
    }
  }
}
