import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/bloc/tuyendung/tuyendung_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';

class QuanLyTuyenDungPage extends StatefulWidget {
  final Ntd? ntd;
  QuanLyTuyenDungPage({super.key, this.ntd});

  @override
  State<QuanLyTuyenDungPage> createState() => _QuanLyTuyenDungPageState();
}

class _QuanLyTuyenDungPageState extends State<QuanLyTuyenDungPage> {
  late final TuyenDungBloc _tuyenDungBloc;
  late final TuyenDungRepository tuyenDungRepository;
  late List<NTDTuyenDung> tuyenDungList = [];

  @override
  void initState() {
    super.initState();
    _tuyenDungBloc = locator<TuyenDungBloc>();
    tuyenDungRepository = locator<TuyenDungRepository>();
    _tuyenDungBloc.add(const TuyenDungEvent.fetchList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tuyển dụng'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TuyenDungBloc, TuyenDungState>(
          bloc: _tuyenDungBloc,
          builder: (context, state) {
            if (state is TuyenDungLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TuyenDungError) {
              return Center(child: Text(state.message));
            }

            if (state is TuyenDungLoaded) {
              return _buildDataTable(state.tuyenDungList);
            }

            return const Center(child: Text('Không có dữ liệu'));
          },
        ),
      ),
    );
  }

  Widget _buildDataTable(List<NTDTuyenDung> tuyenDungList) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: const [
        DataColumn2(label: Text('Vị trí'), size: ColumnSize.L),
        DataColumn2(label: Text('Số lượng'), size: ColumnSize.S),
        DataColumn2(label: Text('Lương'), size: ColumnSize.M),
        DataColumn2(label: Text('Địa điểm'), size: ColumnSize.L),
        DataColumn2(label: Text('Trạng thái'), size: ColumnSize.S),
        DataColumn2(label: Text(''), size: ColumnSize.S),
      ],
      rows: tuyenDungList
          .map((tuyenDung) => DataRow(cells: [
                DataCell(Text(tuyenDung.title ?? '')),
                DataCell(Text(tuyenDung.quantity?.toString() ?? '0')),
                DataCell(Text('${tuyenDung.salary ?? 0} VND')),
                DataCell(Text(tuyenDung.location ?? '')),
                DataCell(_buildStatusChip(tuyenDung.status)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _showEditDialog(context, tuyenDung),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.delete, size: 20, color: Colors.red),
                      onPressed: () => _deleteTuyenDung(tuyenDung.idTuyenDung!),
                    ),
                  ],
                )),
              ]))
          .toList(),
    );
  }

  Widget _buildStatusChip(String? status) {
    final color = status == 'active' ? Colors.green : Colors.red;
    return Chip(
      label: Text(status ?? 'inactive',
          style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
    );
  }

  void _showCreateDialog(BuildContext context) {
    // TODO: Implement create dialog
  }

  void _showEditDialog(BuildContext context, NTDTuyenDung tuyenDung) {
    // TODO: Implement edit dialog
  }

  void _deleteTuyenDung(String id) {
    _tuyenDungBloc.add(TuyenDungEvent.delete(id));
  }
}
