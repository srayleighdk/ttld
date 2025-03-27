import 'package:flutter/material.dart';
import 'package:ttld/features/user_group/models/group.dart';

class EditGroupDialog extends StatefulWidget {
  final Group group;
  final List<Group> groups;
  final Function(Group) onSubmit;

  const EditGroupDialog({
    super.key,
    required this.group,
    required this.groups,
    required this.onSubmit,
  });

  @override
  State<EditGroupDialog> createState() => _EditGroupDialogState();
}

class _EditGroupDialogState extends State<EditGroupDialog> {
  final TextEditingController idUserGroupController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController displayOrderController = TextEditingController();
  final TextEditingController groupLevelController = TextEditingController();
  String? selectedParentId;
  bool statusValue = true;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing group data
    idUserGroupController.text = widget.group.idUserGroup;
    nameController.text = widget.group.name ?? '';
    descriptionController.text = widget.group.description ?? '';
    displayOrderController.text = widget.group.displayOrder.toString();
    groupLevelController.text = widget.group.groupLevel.toString();
    selectedParentId = widget.group.parentId;
    statusValue = widget.group.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.edit, color: Theme.of(context).primaryColor),
          const SizedBox(width: 10),
          const Text('Sửa nhóm người dùng'),
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
                      readOnly: true, // Cannot change the ID
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
                        ...widget.groups
                            .where((g) =>
                                g.idUserGroup != widget.group.idUserGroup)
                            .map(
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
          icon: const Icon(Icons.save),
          label: const Text('Lưu thay đổi'),
          onPressed: () {
            if (nameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng điền tên nhóm'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final updatedGroup = Group(
              idUserGroup: idUserGroupController.text,
              parentId: selectedParentId,
              name: nameController.text,
              description: descriptionController.text,
              displayOrder: int.tryParse(displayOrderController.text) ?? 0,
              groupLevel: int.tryParse(groupLevelController.text) ?? 1,
              status: statusValue,
              users: widget.group.users, // Keep existing users
            );

            widget.onSubmit(updatedGroup);
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
