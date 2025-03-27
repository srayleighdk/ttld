import 'package:flutter/material.dart';
import 'package:ttld/features/user_group/models/group.dart';

class CreateGroupDialog extends StatefulWidget {
  final List<Group> groups;
  final Function(Group) onSubmit;

  const CreateGroupDialog({
    super.key,
    required this.groups,
    required this.onSubmit,
  });

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  final TextEditingController idUserGroupController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController displayOrderController = TextEditingController();
  final TextEditingController groupLevelController =
      TextEditingController(text: '1');
  String? selectedParentId;
  bool statusValue = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.group_add, color: Theme.of(context).primaryColor),
          const SizedBox(width: 10),
          const Text('Thêm nhóm người dùng'),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 0,
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin cơ bản',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: idUserGroupController,
                      decoration: InputDecoration(
                        labelText: 'Mã nhóm *',
                        hintText: 'Nhập mã nhóm',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.code),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Tên nhóm *',
                        hintText: 'Nhập tên nhóm',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.group),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        hintText: 'Nhập mô tả',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.description),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cấu hình nhóm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedParentId,
                      decoration: InputDecoration(
                        labelText: 'Nhóm cha',
                        hintText: 'Chọn nhóm cha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.account_tree),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Không có nhóm cha'),
                        ),
                        ...widget.groups.map(
                          (group) => DropdownMenuItem(
                            value: group.idUserGroup,
                            child: Text(group.idUserGroup),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedParentId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: displayOrderController,
                            decoration: InputDecoration(
                              labelText: 'STT',
                              hintText: 'Nhập số thứ tự',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.reorder),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: groupLevelController,
                            decoration: InputDecoration(
                              labelText: 'Group-Level',
                              hintText: 'Nhập cấp độ nhóm',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.layers),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SwitchListTile(
                          title: const Text('Trạng thái hoạt động'),
                          subtitle: Text(
                            statusValue ? 'Đã duyệt' : 'Chưa duyệt',
                            style: TextStyle(
                              color: statusValue ? Colors.green : Colors.red,
                            ),
                          ),
                          secondary: Icon(
                            statusValue ? Icons.check_circle : Icons.cancel,
                            color: statusValue ? Colors.green : Colors.red,
                          ),
                          value: statusValue,
                          onChanged: (value) {
                            setState(() {
                              statusValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.cancel),
          label: const Text('Hủy'),
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Tạo nhóm'),
          onPressed: () {
            if (idUserGroupController.text.isEmpty ||
                nameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng điền các trường bắt buộc (*)'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final newGroup = Group(
              idUserGroup: idUserGroupController.text,
              parentId: selectedParentId,
              name: nameController.text,
              description: descriptionController.text,
              displayOrder: int.tryParse(displayOrderController.text) ?? 0,
              groupLevel: int.tryParse(groupLevelController.text) ?? 1,
              status: statusValue,
            );

            widget.onSubmit(newGroup);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
