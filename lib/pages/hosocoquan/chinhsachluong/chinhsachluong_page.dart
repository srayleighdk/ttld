import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/blocs/chinhsachluong_bloc/chinhsachluong_bloc.dart';
import 'package:ttld/models/chinhsachluong/chinhsachluong_model.dart';

class ChinhSachLuongPage extends StatefulWidget {
  const ChinhSachLuongPage({super.key});

  @override
  State<ChinhSachLuongPage> createState() => _ChinhSachLuongPageState();
}

class _ChinhSachLuongPageState extends State<ChinhSachLuongPage> {
  late final ChinhSachLuongBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = locator<ChinhSachLuongBloc>();
    _bloc.add(LoadChinhSachLuongs());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý chính sách lương'),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _bloc.add(LoadChinhSachLuongs()),
            tooltip: 'Làm mới dữ liệu',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        label: const Text('Thêm mới'),
        icon: const Icon(Icons.add),
      ),
      body: BlocConsumer<ChinhSachLuongBloc, ChinhSachLuongState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ChinhSachLuongOperationFailure) {
            _showErrorSnackbar(context, state.error);
          } else if (state is ChinhSachLuongOperationSuccess) {
            _showSuccessSnackbar(
                context, state.success ?? 'Thao tác thành công');
          }
        },
        builder: (context, state) {
          if (state is ChinhSachLuongLoading) {
            return const _LoadingWidget();
          }

          if (state is ChinhSachLuongLoadSuccess) {
            return state.cslList.isEmpty
                ? const _EmptyDataWidget()
                : _DataTableWidget(cslList: state.cslList, bloc: _bloc);
          }

          return const _ErrorWidget();
        },
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCreateDialog() {
    final formKey = GlobalKey<FormState>();
    final csl = ChinhSachLuong();
    final TextEditingController idController = TextEditingController();
    final TextEditingController tenController = TextEditingController();
    final TextEditingController vungController = TextEditingController();
    final TextEditingController salaryMinController = TextEditingController();
    final TextEditingController nldBhxhController = TextEditingController();
    final TextEditingController nldBhytController = TextEditingController();
    final TextEditingController nldBhtnController = TextEditingController();
    final TextEditingController dnBhxhController = TextEditingController();
    final TextEditingController dnBhytController = TextEditingController();
    final TextEditingController dnBhtnController = TextEditingController();
    final TextEditingController dnThaisanController = TextEditingController();
    final TextEditingController dnTnldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm chính sách lương mới'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('ID code *', idController, (v) {
                  if (v?.isEmpty ?? true) return 'Vui lòng nhập ID';
                  return null;
                }),
                _buildTextField('Tên vùng mô tả *', tenController, (v) {
                  if (v?.isEmpty ?? true) return 'Vui lòng nhập tên';
                  return null;
                }),
                _buildTextField('Mã vùng (1-4) *', vungController, (v) {
                  if (v?.isEmpty ?? true) return 'Vui lòng nhập mã vùng';
                  if (int.tryParse(v!) == null ||
                      int.parse(v) < 1 ||
                      int.parse(v) > 4) {
                    return 'Mã vùng phải từ 1-4';
                  }
                  return null;
                }, keyboardType: TextInputType.number),
                _buildTextField('Mức lương vùng *', salaryMinController, (v) {
                  if (v?.isEmpty ?? true) return 'Vui lòng nhập mức lương';
                  if (double.tryParse(v!) == null) return 'Số không hợp lệ';
                  return null;
                }, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                const Text('Bảo hiểm người lao động',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                _buildPercentageField('BHXH (%) *', nldBhxhController),
                _buildPercentageField('BHYT (%)', nldBhytController),
                _buildPercentageField('BHTN (%)', nldBhtnController),
                const SizedBox(height: 16),
                const Text('Bảo hiểm tổ chức doanh nghiệp',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                _buildPercentageField('BHXH (%) *', dnBhxhController),
                _buildPercentageField('BHYT (%)', dnBhytController),
                _buildPercentageField('BHTN (%)', dnBhtnController),
                _buildPercentageField('Thai sản (%)', dnThaisanController),
                _buildPercentageField('TNLĐ (%)', dnTnldController),
              ],
            ),
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        contentPadding: const EdgeInsets.all(16),
        buttonPadding: EdgeInsets.zero,
        actions: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 120),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 120),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  _bloc.add(CreateChinhSachLuong(ChinhSachLuong(
                    id: int.tryParse(idController.text),
                    ten: tenController.text,
                    vung: int.tryParse(vungController.text),
                    salaryMin: int.tryParse(salaryMinController.text),
                    nldBhxh: double.tryParse(nldBhxhController.text),
                    nldBhyt: double.tryParse(nldBhytController.text),
                    nldBhtn: double.tryParse(nldBhtnController.text),
                    dnBhxh: double.tryParse(dnBhxhController.text),
                    dnBhyt: double.tryParse(dnBhytController.text),
                    dnBhtn: double.tryParse(dnBhtnController.text),
                    dnThaisan: double.tryParse(dnThaisanController.text),
                    dnTnld: double.tryParse(dnTnldController.text),
                    status: true,
                  )));
                  Navigator.pop(context);
                }
              },
              child: const Text('Thêm'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      FormFieldValidator<String?> validator,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildPercentageField(String label, TextEditingController controller) {
    return _buildTextField(
      label,
      controller,
      (v) {
        if (v?.isNotEmpty == true && double.tryParse(v!) == null) {
          return 'Số không hợp lệ';
        }
        return null;
      },
      keyboardType: TextInputType.number,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Đang tải dữ liệu...'),
        ],
      ),
    );
  }
}

class _EmptyDataWidget extends StatelessWidget {
  const _EmptyDataWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có dữ liệu chính sách lương',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn nút "Thêm mới" để tạo chính sách lương',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Không thể tải dữ liệu',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _DataTableWidget extends StatelessWidget {
  final List<ChinhSachLuong> cslList;
  final ChinhSachLuongBloc bloc;

  const _DataTableWidget({required this.cslList, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable2(
          fixedLeftColumns: 1,
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 800,
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
          border: TableBorder.all(
            color: Colors.grey.shade200,
            width: 1,
            borderRadius: BorderRadius.circular(8),
          ),
          columns: const [
            DataColumn2(
              label: Text('Hành động'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Mã'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Tên mô tả'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Vùng'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Mức lương tối thiểu'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Tình trạng'),
              size: ColumnSize.S,
            ),
          ],
          rows: cslList.map((csl) => _buildDataRow(context, csl)).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow(BuildContext context, ChinhSachLuong csl) {
    return DataRow(
      cells: [
        DataCell(_buildActionButtons(context, csl)),
        DataCell(Text(csl.id?.toString() ?? '-')),
        DataCell(Text(csl.ten ?? '-')),
        DataCell(Text(csl.vung?.toString() ?? '-')),
        DataCell(csl.salaryMin != null
            ? Text('${_formatCurrency(csl.salaryMin!)} VNĐ',
                style: TextStyle(fontWeight: FontWeight.bold))
            : const Text('-')),
        DataCell(_buildStatusChip(csl.status)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ChinhSachLuong csl) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
          tooltip: 'Chỉnh sửa',
          onPressed: () => bloc.add(UpdateChinhSachLuong(csl)),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          tooltip: 'Xóa',
          onPressed: () => _showDeleteConfirmation(context, csl),
        ),
      ],
    );
  }

  Widget _buildStatusChip(bool? status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: status == true ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: status == true ? Colors.green.shade300 : Colors.red.shade300,
        ),
      ),
      child: Text(
        status == true ? 'Kích hoạt' : 'Vô hiệu',
        style: TextStyle(
          color: status == true ? Colors.green.shade700 : Colors.red.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ChinhSachLuong csl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content:
            Text('Bạn có chắc chắn muốn xóa chính sách lương "${csl.ten}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              bloc.add(DeleteChinhSachLuong(csl.id!));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(num value) {
    return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
  }
}
