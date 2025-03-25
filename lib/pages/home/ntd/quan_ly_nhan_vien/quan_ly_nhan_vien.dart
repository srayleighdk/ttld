import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/bloc/biendong/biendong_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuanLyNhanVienPage extends StatefulWidget {
  final String? userId;
  const QuanLyNhanVienPage({super.key, this.userId});
  static const routePath = '/ntd_home/quan-ly-nhan-vien';

  @override
  State<QuanLyNhanVienPage> createState() => _QuanLyNhanVienPageState();
}

class _QuanLyNhanVienPageState extends State<QuanLyNhanVienPage> {
  late final BienDongBloc _bienDongBloc;
  late List<NhanVien> nhanVienList = [];

  @override
  void initState() {
    super.initState();
    _bienDongBloc = locator<BienDongBloc>();
    _bienDongBloc.add(BienDongEvent.fetchList(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý nhân viên'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Thêm nhân viên mới'),
                onPressed: () => context
                    .push('/ntd_home/quan-ly-nhan-vien/create-nhan-vien'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: BlocBuilder<BienDongBloc, BienDongState>(
                  bloc: _bienDongBloc,
                  builder: (context, state) {
                    if (state is BienDongLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is BienDongError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is BienDongLoaded) {
                      return _buildDataTable(state.nhanVienList);
                    }

                    return const Center(child: Text('Không có dữ liệu'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(List<NhanVien> nhanVienList) {
    if (nhanVienList.isEmpty) {
      return const Center(
        child: Text(
          'Không có dữ liệu',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 1000,
      columns: const [
        DataColumn2(label: Text('Thứ tự'), size: ColumnSize.S),
        DataColumn2(label: Text('Họ và tên'), size: ColumnSize.L),
        DataColumn2(label: Text('Ngày sinh'), size: ColumnSize.M),
        // DataColumn2(label: Text('Giới tính'), size: ColumnSize.S),
        DataColumn2(label: Text('Dân tộc'), size: ColumnSize.S),
        DataColumn2(label: Text('CMND/CCCD'), size: ColumnSize.M),
        DataColumn2(label: Text('Vị trí'), size: ColumnSize.L),
        DataColumn2(label: Text('Loại HĐLĐ'), size: ColumnSize.M),
        DataColumn2(label: Text('Tình trạng HĐ'), size: ColumnSize.M),
        DataColumn2(label: Text('Trạng thái'), size: ColumnSize.S),
        DataColumn2(label: Text('Tùy chọn'), size: ColumnSize.M),
      ],
      rows: nhanVienList.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final nhanVien = entry.value;
        return DataRow(cells: [
          DataCell(Text(index.toString())),
          DataCell(Text(nhanVien.hoTenUv ?? '')),
          DataCell(Text(nhanVien.ngaySinhUv ?? '')),
          // DataCell(Text(nhanVien.uvGioitinh ?? '')),
          DataCell(Text(nhanVien.danTocUv ?? '')),
          DataCell(Text(nhanVien.soCmndUv ?? '')),
          DataCell(Text(nhanVien.tenChucdanh ?? '')),
          DataCell(Text(nhanVien.loaiHDLD ?? '')),
          DataCell(Text(nhanVien.tinhtrangHd ?? '')),
          DataCell(Text(nhanVien.tinhtrangHd ?? '')),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _showEditDialog(context, nhanVien),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () => _deleteNhanVien(nhanVien.idphieu!),
              ),
            ],
          )),
        ]);
      }).toList(),
    );
  }

  void _showEditDialog(BuildContext context, NhanVien nhanVien) {
    // TODO: Implement edit dialog
  }

  void _deleteNhanVien(String id) {
    _bienDongBloc.add(BienDongEvent.delete(id));
  }
}
