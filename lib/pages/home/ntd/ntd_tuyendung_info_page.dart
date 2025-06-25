import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:flutter/services.dart'; // Required for Clipboard
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/core/utils/launch_utils.dart'; // Import the new utility function

String getGioiTinhString(int? gioiTinh) {
  if (gioiTinh == null) return '';
  switch (gioiTinh) {
    case -1:
      return 'Nam và Nữ';
    case 0:
      return 'Nữ';
    case 1:
      return 'Nam';
    default:
      return '';
  }
}

String getTrinhDoName(dynamic id) {
  if (id == null) return '';

  // Convert to string if it's an integer
  String stringId = id is int ? id.toString() : id;

  // Assuming you have a list of trinhDo objects fetched and stored
  final trinhDoList = locator<List<TrinhDoHocVan>>();

  final trinhDo = trinhDoList.firstWhere(
    (item) => item.id == stringId,
    orElse: () => TrinhDoHocVan(id: stringId, name: 'Chưa có'),
  );

  return trinhDo.displayName;
}

String getNganhNgheName(dynamic id) {
  if (id == null) return '';

  // Convert to string if it's an integer
  String stringId = id is int ? id.toString() : id;

  List<NganhNgheTD> nganhNgheList = [];
  try {
    nganhNgheList = locator<List<NganhNgheTD>>();
  } catch (e) {
    // If not registered yet, use empty list
    nganhNgheList = [];
  }

  final nganhNghe = nganhNgheList.isNotEmpty 
    ? nganhNgheList.firstWhere(
        (item) => item.id == stringId,
        orElse: () => NganhNgheTD(id: stringId, name: 'Chưa có'),
      )
    : NganhNgheTD(id: stringId, name: 'Chưa có');

  return nganhNghe.displayName;
}

class NTDInfoPage extends StatefulWidget {
  final dynamic ntdData; // Replace with your NTD model if available
  const NTDInfoPage({super.key, this.ntdData});

  static Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(value?.isNotEmpty == true ? value! : '-',
                style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  @override
  State<NTDInfoPage> createState() => _NTDInfoPageState();
}

class _NTDInfoPageState extends State<NTDInfoPage> {
  Ntd? ntd;
  final repository = locator<NTDRepository>();

  @override
  initState() {
    super.initState();
    // make the idDoanhNghiep int
    int idDoanhNghiep = (widget.ntdData['idDoanhNghiep'] is int)
        ? widget.ntdData['idDoanhNghiep']
        : int.parse(widget.ntdData['idDoanhNghiep']);
    repository.getNtdById(idDoanhNghiep).then((value) {
      setState(() {
        ntd = value;
      });
    });
  }

  // Helper method to build a clickable phone number row
  Widget _buildClickablePhoneRow(String label, String? phoneNumber) {
    final theme = Theme.of(context);
    final displayValue = phoneNumber?.isNotEmpty == true ? phoneNumber! : '-';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: displayValue == '-'
                ? Text(displayValue,
                    style: const TextStyle(color: Colors.black87))
                : GestureDetector(
                    onTap: () => launchPhoneCall(context, phoneNumber!), // Use the shared function
                    child: Text(
                      displayValue,
                      style: TextStyle(
                        color:
                            theme.colorScheme.primary, // Make it look clickable
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a copyable email row
  Widget _buildCopyableEmailRow(String label, String? email) {
    final theme = Theme.of(context);
    final displayValue = email?.isNotEmpty == true ? email! : '-';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: displayValue == '-'
                ? Text(displayValue,
                    style: const TextStyle(color: Colors.black87))
                : GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: email!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copied email to clipboard: $email'),
                        ),
                      );
                    },
                    child: Text(
                      displayValue,
                      style: TextStyle(
                        color:
                            theme.colorScheme.primary, // Make it look clickable
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 1.0,
        title: Text(
          'Thông tin NTD',
          style: const TextStyle(fontWeight: FontWeight.bold)
              .copyWith(color: theme.colorScheme.onSurface),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha(25),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: widget.ntdData == null
            ? const Center(child: Text('Không có dữ liệu.'))
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: Thông tin tuyển dụng
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withAlpha(26),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Thông tin tuyển dụng',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NTDInfoPage._infoRow(
                                  'Tuyển dụng ID',
                                  widget.ntdData['tuyendungId']?.toString() ??
                                      ''),
                              NTDInfoPage._infoRow('Tuyển dụng',
                                  widget.ntdData['tuyendung'] ?? ''),
                              NTDInfoPage._infoRow(
                                  'Số lượng', widget.ntdData['soLuong'] ?? ''),
                              NTDInfoPage._infoRow(
                                  'Giới tính',
                                  getGioiTinhString(
                                      widget.ntdData['gioiTinh'])),
                              NTDInfoPage._infoRow('Trình độ',
                                  getTrinhDoName(widget.ntdData['trinhDo'])),
                              NTDInfoPage._infoRow(
                                  'Ngành nghề',
                                  getNganhNgheName(
                                      widget.ntdData['nganhNghe'])),
                              NTDInfoPage._infoRow('Mô tả công việc',
                                  widget.ntdData['moTaCongViec'] ?? ''),
                              NTDInfoPage._infoRow('Ngày đăng',
                                  widget.ntdData['ngayDang'] ?? ''),
                            ],
                          ),
                        ),
                      ),
                      // Section 2: Thông tin liên hệ
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withAlpha(26),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Thông tin liên hệ',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NTDInfoPage._infoRow(
                                  'Tên công ty', ntd?.ntdTen ?? ''),
                              NTDInfoPage._infoRow(
                                  'Ngành', ntd?.ntdLinhvuchoatdong ?? ''),
                              // _infoRow('Email', ntdData['email'] ?? ''),
                              // _infoRow('Phone', ntdData['phone'] ?? ''),
                              NTDInfoPage._infoRow(
                                  'Người đại diện', ntd?.ntdNguoilienhe ?? ''),
                              NTDInfoPage._infoRow(
                                  'Địa chỉ', ntd?.ntdDiachichitiet ?? ''),
                              NTDInfoPage._infoRow(
                                  'Giới thiệu', ntd?.ntdGioithieu ?? ''),
                              _buildClickablePhoneRow(
                                  'Số điện thoại', ntd?.ntdDienthoai),
                              _buildCopyableEmailRow('Email', ntd?.ntdEmail),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
