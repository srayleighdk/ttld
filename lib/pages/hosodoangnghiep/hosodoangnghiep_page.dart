import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';

class HoSoDoanhNghiepPage extends StatefulWidget {
  const HoSoDoanhNghiepPage({super.key});

  @override
  State<HoSoDoanhNghiepPage> createState() => _HoSoDoanhNghiepPageState();
}

class _HoSoDoanhNghiepPageState extends State<HoSoDoanhNghiepPage> {
  NTDDataSource? ntdDataSource;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  final int _rowsPerPage = 20; // Adjust as needed
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final ntdRepository = locator<NTDRepository>();
    try {
      final value =
          await ntdRepository.getNtdList(); // Use await instead of then
      setState(() {
        ntdDataSource = NTDDataSource(value,
            onUpdate: _handleUpdate, onDelete: _handleDelete);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Handle error state if needed
      });
      print('Error loading data: $e');
    }
  }

// Handle update action
  void _handleUpdate(dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập Nhật Doanh Nghiệp'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${item.idDoanhNghiep}'),
            TextField(
              decoration: const InputDecoration(labelText: 'Tên Doanh Nghiệp'),
              controller: TextEditingController(text: item.ntdTen),
              onChanged: (value) => item.name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Địa Chỉ'),
              controller: TextEditingController(text: item.ntdDiachichitiet),
              onChanged: (value) => item.address = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Số Điện Thoại'),
              controller: TextEditingController(text: item.ntdDienthoai),
              onChanged: (value) => item.phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Update the item in the repository (assuming an API call)
              locator<NTDRepository>().updateNtd(item.idDoanhNghiep).then((_) {
                setState(() {}); // Refresh the table
                Navigator.pop(context);
              });
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // Handle delete action
  void _handleDelete(dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa Doanh Nghiệp'),
        content: Text('Bạn có chắc muốn xóa ${item.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Delete the item from the repository (assuming an API call)
              locator<NTDRepository>().deleteNtd(item.id).then((_) {
                setState(() {
                  ntdDataSource!.ntds.remove(item); // Remove from local list
                });
                Navigator.pop(context);
              });
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || ntdDataSource == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ doanh nghiệp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PaginatedDataTable2(
          header: Text('Hồ sơ doanh nghiệp'),
          horizontalMargin: 12,
          columnSpacing: 12,
          rowsPerPage: _rowsPerPage,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          availableRowsPerPage: [5, 10, 20],
          onRowsPerPageChanged: (value) {},
          minWidth: 1200,
          source: ntdDataSource!,
          fixedLeftColumns: 1,
          columns: [
            const DataColumn2(
              label: Text('Hành Động'),
              size: ColumnSize.S,
            ),
            DataColumn2(
                label: Text('Mã DN/Mã Số Thuế'),
                size: ColumnSize.S,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
            DataColumn2(
                label: Text('Tên Doanh Nghiệp'),
                size: ColumnSize.L,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
            DataColumn2(
                label: Text('Người liên hệ'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
            DataColumn2(
                label: Text('Điện Thoại'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
            DataColumn2(
                label: Text('Email'),
                size: ColumnSize.M,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
            DataColumn2(
                label: Text('Địa Chỉ Chi tiết'),
                size: ColumnSize.L,
                onSort: (columnIndex, ascending) =>
                    _sort(columnIndex, ascending)),
          ],
          dataRowHeight: kMinInteractiveDimension,
          fit: FlexFit.loose,
        ),
      ),
    );
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      ntdDataSource!.sort(columnIndex, ascending);
    });
  }
}

class NTDDataSource extends DataTableSource {
  final List<Ntd> ntds;
  final Function(dynamic item)? onUpdate;
  final Function(dynamic item)? onDelete;

  NTDDataSource(this.ntds, {this.onUpdate, this.onDelete});

  void sort(int columnIndex, bool ascending) {
    ntds.sort((a, b) {
      int result;
      switch (columnIndex) {
        case 0: // ID
          result = a.ntdMadn!.compareTo(b.ntdMadn!);
          break;
        case 1: // Name
          result = a.ntdTen!.compareTo(b.ntdTen!);
          break;
        case 2: // Age
          result = a.ntdNguoilienhe!.compareTo(b.ntdNguoilienhe!);
          break;
        default:
          result = 0;
      }
      return ascending ? result : -result;
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    if (index >= ntds.length) return DataRow2(cells: []); // Out of range
    final ntd = ntds[index];
    return DataRow2(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => onUpdate!(ntd),
                tooltip: 'Cập Nhật',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete!(ntd),
                tooltip: 'Xóa',
              ),
            ],
          ),
        ),
        DataCell(Text(ntd.ntdMadn.toString())),
        DataCell(Text(ntd.ntdTen ?? '')),
        DataCell(Text(ntd.ntdNguoilienhe ?? '')),
        DataCell(Text(ntd.ntdDienthoai ?? '')),
        DataCell(Text(ntd.ntdEmail ?? '')),
        DataCell(Flexible(child: Text(ntd.ntdDiachichitiet ?? ''))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ntds.length;

  @override
  int get selectedRowCount => 0; // No selection for this example
}

