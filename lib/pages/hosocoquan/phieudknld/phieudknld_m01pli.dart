import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/m01pli/m01pli_model.dart';
import 'package:ttld/repositories/m01pli_repository.dart';

class PhieudknldM01pli extends StatefulWidget {
  const PhieudknldM01pli({super.key});

  @override
  State<PhieudknldM01pli> createState() => _PhieudknldM01pliState();
}

class _PhieudknldM01pliState extends State<PhieudknldM01pli> {
  final M01PliRepository _repository = locator<M01PliRepository>();
  late Future<List<M01Pli>> _pliFuture;

  @override
  void initState() {
    super.initState();
    _pliFuture = _repository.fetchM01Plis();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<M01Pli>>(
            future: _pliFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final pliList = snapshot.data ?? [];

              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 600,
                  maxWidth: double.infinity,
                ),
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(label: Text('STT'), fixedWidth: 50),
                    DataColumn2(label: Text('Hành động'), fixedWidth: 80),
                    DataColumn2(label: Text('Mã đăng ký'), fixedWidth: 100),
                    DataColumn2(label: Text('Ngày lập')),
                    DataColumn2(label: Text('Họ và tên')),
                    DataColumn2(label: Text('Số Cmnd/Cccd')),
                    DataColumn2(label: Text('Địa chỉ thường trú')),
                    DataColumn2(label: Text('Người liên hệ')),
                    DataColumn2(label: Text('Ngày sinh')),
                    DataColumn2(label: Text('Giới tính')),
                    DataColumn2(label: Text('Điện thoại')),
                    DataColumn2(label: Text('Email')),
                    DataColumn2(label: Text('Trạng thái')),
                  ],
                  rows: List<DataRow>.generate(pliList.length, (index) {
                    final pli = pliList[index];
                    return DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _editPli(pli),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 20),
                                onPressed: () => _deletePli(pli.idphieu ?? ''),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(pli.maphieu ?? '')),
                        DataCell(Text(pli.ngaylap?.toString() ?? '')),
                        DataCell(Text(pli.hoten ?? '')),
                        DataCell(Text(pli.soCmnd ?? '')),
                        DataCell(Text(pli.diachiTt ?? '')),
                        DataCell(Text(pli.tenLienhe ?? '')),
                        DataCell(Text(pli.ngaysinh?.toString() ?? '')),
                        DataCell(Text(_getGenderText(pli.idGioitinh))),
                        DataCell(Text(pli.dienthoai ?? '')),
                        DataCell(Text(pli.email ?? '')),
                        DataCell(Text(_getStatusText(pli.status))),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getGenderText(int? genderCode) {
    return genderCode == 1
        ? 'Nam'
        : genderCode == 0
            ? 'Nữ'
            : '';
  }

  String _getStatusText(bool? statusCode) {
    return statusCode == true ? 'Kích hoạt' : 'Vô hiệu';
  }

  void _editPli(M01Pli pli) {
    // TODO: Implement edit functionality
  }

  Future<void> _deletePli(String idphieu) async {
    // TODO: Implement delete confirmation and functionality
  }
}
