import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../blocs/chinhsachluong_bloc/chinhsachluong_bloc.dart';
import '../../../models/chinhsachluong/chinhsachluong_model.dart';

class ChinhSachLuongPage extends StatefulWidget {
  const ChinhSachLuongPage({super.key});

  @override
  State<ChinhSachLuongPage> createState() => _ChinhSachLuongPageState();
}

class _ChinhSachLuongPageState extends State<ChinhSachLuongPage> {
  @override
  void initState() {
    super.initState();
    GetIt.I.get<ChinhSachLuongBloc>().add(LoadChinhSachLuongs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Chính sách lương'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GetIt.I.get<ChinhSachLuongBloc>()
            .add(CreateChinhSachLuong(ChinhSachLuong())),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ChinhSachLuongBloc, ChinhSachLuongState>(
        listener: (context, state) {
          if (state is ChinhSachLuongOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is ChinhSachLuongLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChinhSachLuongLoadSuccess) {
            return _buildDataTable(state.cslList);
          }
          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }

  Widget _buildDataTable(List<ChinhSachLuong> cslList) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 800,
      columns: const [
        DataColumn2(
          label: Text('Hành động'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Mã'),
          numeric: true,
        ),
        DataColumn2(
          label: Text('Tên mô tả'),
        ),
        DataColumn2(
          label: Text('Vùng'),
          numeric: true,
        ),
        DataColumn2(
          label: Text('Mức lương tối thiểu'),
          numeric: true,
        ),
        DataColumn2(
          label: Text('Tình trạng'),
        ),
      ],
      rows: cslList
          .map((csl) => DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => GetIt.I.get<ChinhSachLuongBloc>()
                              .add(UpdateChinhSachLuong(csl)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => GetIt.I.get<ChinhSachLuongBloc>()
                              .add(DeleteChinhSachLuong(csl.id!)),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(csl.id?.toString() ?? '')),
                  DataCell(Text(csl.ten ?? '')),
                  DataCell(Text(csl.vung?.toString() ?? '')),
                  DataCell(Text('${csl.salaryMin?.toString() ?? ''} VNĐ')),
                  DataCell(
                    Chip(
                      backgroundColor: csl.status == true
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      label: Text(csl.status == true ? 'Kích hoạt' : 'Vô hiệu'),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
