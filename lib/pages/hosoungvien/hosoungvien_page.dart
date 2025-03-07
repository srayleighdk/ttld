import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/hosoungvien/bloc/hosoungvien_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:data_table_2/data_table_2.dart';

class HoSoUngVienPage extends StatelessWidget {
  const HoSoUngVienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HoSoUngVienBloc(
            hoSoUngVienApiService:
                HoSoUngVienApiService(locator<ApiClient>().dio))
          ..add(HoSoUngVienFetchData()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hồ Sơ Ứng Viên'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Navigate to create new HoSoUngVien
                  context.push('/ho-so-ung-vien/create-hoso-ungvien');
                },
              ),
            ],
          ),
          body: BlocBuilder<HoSoUngVienBloc, HoSoUngVienState>(
            builder: (context, state) {
              if (state is HoSoUngVienInitial) {
                return const Center(child: Text('Initial State'));
              } else if (state is HoSoUngVienLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HoSoUngVienLoaded) {
                return PaginatedDataTable(
                  columns: const [
                    DataColumn2(label: Text('Họ tên'), fixedWidth: 150),
                    DataColumn2(label: Text('Email'), size: ColumnSize.M),
                    DataColumn2(label: Text('Hành động')),
                  ],
                  source: HoSoUngVienDataSource(
                    context: context,
                    hoSoUngVienList: state.hoSoUngVienList,
                  ),
                  // empty: Center(child: Text("Không có dữ liệu")),
                );
              } else if (state is HoSoUngVienError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ));
  }
}

class HoSoUngVienDataSource extends DataTableSource {
  final List<TblHoSoUngVienModel> hoSoUngVienList;
  final BuildContext context;

  HoSoUngVienDataSource({required this.hoSoUngVienList, required this.context});

  @override
  DataRow? getRow(int index) {
    final hoSoUngVien = hoSoUngVienList[index];
    return DataRow(cells: [
      DataCell(Text(hoSoUngVien.uvHoten ?? 'N/A')),
      DataCell(Text(hoSoUngVien.uvEmail ?? 'N/A')),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit HoSoUngVien
              context.push('/ntv_home/update_ntv', extra: hoSoUngVien);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show delete confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác nhận xóa'),
                    content:
                        const Text(('Bạn có chắc chắn muốn xóa hồ sơ này?')),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Delete HoSoUngVien
                          context.read<HoSoUngVienBloc>().add(
                                HoSoUngVienDelete(
                                    int.tryParse(hoSoUngVien.id)!),
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Xóa'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => hoSoUngVienList.length;

  @override
  int get selectedRowCount => 0;
}
