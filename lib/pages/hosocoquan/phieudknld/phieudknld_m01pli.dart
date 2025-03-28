import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
  late M01PliDataSource _dataSource;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  PaginatorController? _dataTableController;

  @override
  void initState() {
    super.initState();
    _dataSource = M01PliDataSource(
      _repository,
      viewDetailsCallback: _viewPliDetails,
      editCallback: _editPli,
      deleteCallback: _confirmDeletePli,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dataSource.dispose();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      _dataSource.refresh();
    });
  }

  void _sort<T>(Comparable<T> Function(M01Pli pli) getField, int columnIndex,
      bool ascending) {
    _dataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<DataColumn> get _columns {
    return [
      DataColumn(label: const Text('STT')),
      DataColumn(label: const Text('Hành động')),
      DataColumn(
        label: const Text('Mã đăng ký'),
        onSort: (columnIndex, ascending) =>
            _sort<String>((pli) => pli.maphieu ?? '', columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Ngày lập'),
        onSort: (columnIndex, ascending) =>
            _sort<String>((pli) => pli.ngaylap ?? '', columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Họ và tên'),
        onSort: (columnIndex, ascending) =>
            _sort<String>((pli) => pli.hoten ?? '', columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Số Cmnd/Cccd'),
        onSort: (columnIndex, ascending) =>
            _sort<String>((pli) => pli.soCmnd ?? '', columnIndex, ascending),
      ),
      DataColumn(label: const Text('Địa chỉ thường trú')),
      DataColumn(label: const Text('Người liên hệ')),
      DataColumn(
        label: const Text('Ngày sinh'),
        onSort: (columnIndex, ascending) =>
            _sort<String>((pli) => pli.ngaysinh ?? '', columnIndex, ascending),
      ),
      DataColumn(label: const Text('Giới tính')),
      DataColumn(label: const Text('Điện thoại')),
      DataColumn(label: const Text('Email')),
      DataColumn(label: const Text('Trạng thái')),
    ];
  }

  // Widget _buildPaginationControls() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         IconButton(
  //           icon: const Icon(Icons.chevron_left),
  //           onPressed: _currentPage > 1
  //               ? () => _handlePageChange(_currentPage - 1)
  //               : null,
  //         ),
  //         ...List.generate(_totalPages, (index) {
  //           final pageNumber = index + 1;
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //             child: InkWell(
  //               onTap: () => _handlePageChange(pageNumber),
  //               child: Container(
  //                 padding: const EdgeInsets.all(8),
  //                 decoration: BoxDecoration(
  //                   color: _currentPage == pageNumber
  //                       ? Theme.of(context).primaryColor
  //                       : Colors.transparent,
  //                   borderRadius: BorderRadius.circular(4),
  //                 ),
  //                 child: Text(
  //                   '$pageNumber',
  //                   style: TextStyle(
  //                     color: _currentPage == pageNumber
  //                         ? Colors.white
  //                         : Colors.black,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //         IconButton(
  //           icon: const Icon(Icons.chevron_right),
  //           onPressed: _currentPage < _totalPages
  //               ? () => _handlePageChange(_currentPage + 1)
  //               : null,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildSearchAndActions(),
            const SizedBox(height: 16),
            Expanded(
              child: PaginatedDataTable2(
                controller: _dataTableController,
                horizontalMargin: 20,
                columnSpacing: 0,
                wrapInCard: false,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade100),
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: const [10, 20, 50, 100],
                onPageChanged: (value) {
                  final pageNumber = (value ~/ _rowsPerPage) + 1;
                  _dataSource.handlePageChange(pageNumber);
                },
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value!;
                    _dataSource.updateItemsPerPage(value);
                  });
                },
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: _columns,
                source: _dataSource,
                empty: const Center(
                    child: Text('Không có dữ liệu nào được tìm thấy')),
                minWidth: 1200,
                fit: FlexFit.tight,
                border: TableBorder(
                  top: const BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.grey[300]!),
                  left: BorderSide(color: Colors.grey[300]!),
                  right: BorderSide(color: Colors.grey[300]!),
                  verticalInside: BorderSide(color: Colors.grey[300]!),
                  horizontalInside:
                      const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Phiếu đăng ký nhu cầu lao động',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchAndActions() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm theo họ tên, mã phiếu...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Implement add new record
          },
          icon: const Icon(Icons.add),
          label: const Text('Thêm mới'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _refreshData,
          icon: const Icon(Icons.refresh),
          tooltip: 'Làm mới',
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  // Widget _buildDataTable() {
  //   return Card(
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(12),
  //       child: FutureBuilder<Map<String, dynamic>>(
  //         future: _pliFuture,
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //
  //           if (snapshot.hasError) {
  //             return Center(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   const Icon(Icons.error_outline,
  //                       size: 48, color: Colors.red),
  //                   const SizedBox(height: 16),
  //                   Text(
  //                     'Đã xảy ra lỗi: ${snapshot.error}',
  //                     style: const TextStyle(color: Colors.red),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   ElevatedButton(
  //                     onPressed: _refreshData,
  //                     child: const Text('Thử lại'),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }
  //
  //           final response = snapshot.data ?? {};
  //           final pliList = (response['data'] as List<M01Pli>?) ?? [];
  //           final totalItems = (response['total'] as int?) ?? 0;
  //           _totalPages = (totalItems / _itemsPerPage).ceil();
  //
  //           if (pliList.isEmpty) {
  //             return const Center(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Icon(Icons.info_outline, size: 48, color: Colors.blue),
  //                   SizedBox(height: 16),
  //                   Text(
  //                     'Không có dữ liệu nào được tìm thấy',
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }
  //
  //           // Filter data based on search query
  //           final filteredData = _searchQuery.isEmpty
  //               ? pliList
  //               : pliList
  //                   .where((pli) =>
  //                       (pli.hoten
  //                               ?.toLowerCase()
  //                               .contains(_searchQuery.toLowerCase()) ??
  //                           false) ||
  //                       (pli.maphieu
  //                               ?.toLowerCase()
  //                               .contains(_searchQuery.toLowerCase()) ??
  //                           false) ||
  //                       (pli.soCmnd
  //                               ?.toLowerCase()
  //                               .contains(_searchQuery.toLowerCase()) ??
  //                           false))
  //                   .toList();
  //
  //           return SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: SingleChildScrollView(
  //               child: DataTable(
  //                 headingRowColor:
  //                     MaterialStateProperty.all(Colors.grey.shade100),
  //                 dataRowMaxHeight: 80,
  //                 dataRowMinHeight: 60,
  //                 columns: [
  //                   const DataColumn(label: Text('STT')),
  //                   const DataColumn(label: Text('Hành động')),
  //                   const DataColumn(label: Text('Mã đăng ký')),
  //                   const DataColumn(label: Text('Ngày lập')),
  //                   const DataColumn(label: Text('Họ và tên')),
  //                   const DataColumn(label: Text('Số Cmnd/Cccd')),
  //                   const DataColumn(label: Text('Địa chỉ thường trú')),
  //                   const DataColumn(label: Text('Người liên hệ')),
  //                   const DataColumn(label: Text('Ngày sinh')),
  //                   const DataColumn(label: Text('Giới tính')),
  //                   const DataColumn(label: Text('Điện thoại')),
  //                   const DataColumn(label: Text('Email')),
  //                   const DataColumn(label: Text('Trạng thái')),
  //                 ],
  //                 rows: List<DataRow>.generate(filteredData.length, (index) {
  //                   final pli = filteredData[index];
  //                   return DataRow(
  //                     cells: [
  //                       DataCell(Text('${index + 1}')),
  //                       DataCell(_buildActions(pli)),
  //                       DataCell(Text(pli.maphieu ?? '')),
  //                       DataCell(Text(pli.ngaylap != null ? pli.ngaylap! : '')),
  //                       DataCell(Text(pli.hoten ?? '')),
  //                       DataCell(Text(pli.soCmnd ?? '')),
  //                       DataCell(Text(pli.diachiTt ?? '')),
  //                       DataCell(Text(pli.tenLienhe ?? '')),
  //                       DataCell(
  //                           Text(pli.ngaysinh != null ? pli.ngaysinh! : '')),
  //                       DataCell(_buildGenderChip(pli.idGioitinh)),
  //                       DataCell(Text(pli.dienthoai ?? '')),
  //                       DataCell(Text(pli.email ?? '')),
  //                       DataCell(_buildStatusChip(pli.status)),
  //                     ],
  //                   );
  //                 }),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget _buildActions(M01Pli pli) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, color: Colors.blue),
          tooltip: 'Xem chi tiết',
          onPressed: () => _viewPliDetails(pli),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange),
          tooltip: 'Chỉnh sửa',
          onPressed: () => _editPli(pli),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Xóa',
          onPressed: () => _confirmDeletePli(pli.idphieu ?? ''),
        ),
      ],
    );
  }

  Widget _buildGenderChip(int? genderCode) {
    Color chipColor;
    String label;
    IconData icon;

    if (genderCode == 1) {
      chipColor = Colors.blue.shade100;
      label = 'Nam';
      icon = Icons.male;
    } else if (genderCode == 0) {
      chipColor = Colors.pink.shade100;
      label = 'Nữ';
      icon = Icons.female;
    } else {
      chipColor = Colors.grey.shade200;
      label = 'Không xác định';
      icon = Icons.person;
    }

    return Chip(
      backgroundColor: chipColor,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildStatusChip(bool? statusCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusCode == true ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusCode == true ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: statusCode == true ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            statusCode == true ? 'Kích hoạt' : 'Vô hiệu',
            style: TextStyle(
              color: statusCode == true ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _viewPliDetails(M01Pli pli) {
    // TODO: Implement view details functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chi tiết phiếu đăng ký'),
        content: const Text('Chức năng đang được phát triển'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _editPli(M01Pli pli) {
    // TODO: Implement edit functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa phiếu đăng ký'),
        content: const Text('Chức năng đang được phát triển'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePli(String idphieu) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content:
            const Text('Bạn có chắc chắn muốn xóa phiếu đăng ký này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deletePli(idphieu);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePli(String idphieu) async {
    // TODO: Implement delete functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chức năng xóa đang được phát triển'),
      ),
    );
  }
}

// Custom DataSource for M01Pli
class M01PliDataSource extends DataTableSource {
  final M01PliRepository _repository;
  final Function(M01Pli) viewDetailsCallback;
  final Function(M01Pli) editCallback;
  final Function(String) deleteCallback;
  List<M01Pli> _pliList = [];
  String _searchQuery = '';
  int _currentPage = 1;
  int _itemsPerPage = 10;
  int _totalItems = 0;
  bool _isLoading = false;

  M01PliDataSource(
    this._repository, {
    required this.viewDetailsCallback,
    required this.editCallback,
    required this.deleteCallback,
  }) {
    _fetchData();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _fetchData();
  }

  void handlePageChange(int newPage) {
    _currentPage = newPage;
    refresh();
  }

  void updateItemsPerPage(int newItemsPerPage) {
    _itemsPerPage = newItemsPerPage;
    _currentPage = 1;
    refresh();
  }

  void refresh() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchM01Plis(
        page: _currentPage,
        limit: _itemsPerPage,
      );

      _pliList = (response['data'] as List<M01Pli>?) ?? [];
      final newTotal = (response['total'] as int?) ?? 0;

      // Validate page number against new total
      final totalPages = (newTotal / _itemsPerPage).ceil();
      if (_currentPage > totalPages && totalPages > 0) {
        _currentPage = totalPages;
        return await _fetchData(); // Recursively fetch correct page
      }

      _totalItems = newTotal;
    } catch (e) {
      _pliList = [];
      _totalItems = 0;
      // Optionally store error for display
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void sort<T>(Comparable<T> Function(M01Pli pli) getField, bool ascending) {
    _pliList.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final localIndex = index - startIndex;

    if (localIndex < 0 || localIndex >= _pliList.length) return null;
    final pli = _pliList[localIndex];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(_buildActions(pli)),
      DataCell(Text(pli.maphieu ?? '')),
      DataCell(Text(pli.ngaylap ?? '')),
      DataCell(Text(pli.hoten ?? '')),
      DataCell(Text(pli.soCmnd ?? '')),
      DataCell(Text(pli.diachiTt ?? '')),
      DataCell(Text(pli.tenLienhe ?? '')),
      DataCell(Text(pli.ngaysinh ?? '')),
      DataCell(_buildGenderChip(pli.idGioitinh)),
      DataCell(Text(pli.dienthoai ?? '')),
      DataCell(Text(pli.email ?? '')),
      DataCell(_buildStatusChip(pli.status)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _totalItems;

  @override
  int get selectedRowCount => 0;

  Widget _buildActions(M01Pli pli) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, color: Colors.blue),
          tooltip: 'Xem chi tiết',
          onPressed: () => _viewPliDetails(pli),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange),
          tooltip: 'Chỉnh sửa',
          onPressed: () => _editPli(pli),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Xóa',
          onPressed: () => _confirmDeletePli(pli.idphieu ?? ''),
        ),
      ],
    );
  }

  Widget _buildGenderChip(int? idGioitinh) {
    // Keep existing _buildGenderChip implementation
    Color chipColor;
    String label;
    IconData icon;

    if (idGioitinh == 1) {
      chipColor = Colors.blue.shade100;
      label = 'Nam';
      icon = Icons.male;
    } else if (idGioitinh == 0) {
      chipColor = Colors.pink.shade100;
      label = 'Nữ';
      icon = Icons.female;
    } else {
      chipColor = Colors.grey.shade200;
      label = 'Không xác định';
      icon = Icons.person;
    }

    return Chip(
      backgroundColor: chipColor,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildStatusChip(bool? status) {
    // Keep existing _buildStatusChip implementation
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == true ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status == true ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: status == true ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            status == true ? 'Kích hoạt' : 'Vô hiệu',
            style: TextStyle(
              color: status == true ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _viewPliDetails(M01Pli pli) => viewDetailsCallback(pli);
  void _editPli(M01Pli pli) => editCallback(pli);
  void _confirmDeletePli(String idphieu) => deleteCallback(idphieu);
}
