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
}
