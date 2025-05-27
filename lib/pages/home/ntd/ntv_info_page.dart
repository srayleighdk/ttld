import 'package:flutter/material.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class NTVInfoPage extends StatelessWidget {
  final TblHoSoUngVienModel? ntdData;
  const NTVInfoPage({super.key, this.ntdData});

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
            'Thông tin tìm việc',
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
            child: ntdData == null
                ? const Center(child: Text('Không có dữ liệu.'))
                : SafeArea(
                    child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.shadow.withAlpha(26),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Thông tin tìm việc',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _modernInfoRow(Icons.work_outline,
                                    'Công việc mong muốn', ntdData?.cvMongMuon),
                                _modernInfoRow(Icons.school_outlined,
                                    'Trình độ', ntdData?.uvcmTrinhdo),
                                _modernInfoRow(Icons.business_center_outlined,
                                    'Ngành nghề', ntdData?.uvnvNganhnghe),
                                _modernInfoRow(
                                    Icons.timeline_outlined,
                                    'Kinh nghiệm làm việc',
                                    ntdData?.uvcmKinhnghiem?.toString()),
                                _modernInfoRow(
                                    Icons.date_range_outlined,
                                    'Ngày đăng',
                                    ntdData?.ngayduyet != null
                                        ? ntdData!.ngayduyet!
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0]
                                        : null),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.shadow.withAlpha(26),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Thông tin liên hệ',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _modernInfoRow(Icons.person_outline, 'Họ tên',
                                    ntdData?.uvHoten),
                                _modernInfoRow(Icons.cake_outlined, 'Ngày sinh',
                                    ntdData?.uvNgaysinh),
                                _modernInfoRow(Icons.email_outlined, 'Email',
                                    ntdData?.uvEmail),
                                _modernInfoRow(Icons.phone_outlined,
                                    'Điện thoại', ntdData?.uvDienthoai),
                                _modernInfoRow(Icons.home_outlined, 'Địa chỉ',
                                    ntdData?.diachilienhe),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))));
  }

  Widget _modernInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(value ?? '-', style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
