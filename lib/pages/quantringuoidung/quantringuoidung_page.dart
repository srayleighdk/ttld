import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/user_group/models/group.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/models/user/user_model.dart';
import 'package:ttld/repositories/user/user_repository.dart';

class QuanTriNguoiDungPage extends StatefulWidget {
  const QuanTriNguoiDungPage({super.key});

  @override
  State<QuanTriNguoiDungPage> createState() => _QuanTriNguoiDungPageState();
}

class _QuanTriNguoiDungPageState extends State<QuanTriNguoiDungPage> {
  List<Group> groups = [];
  bool isLoading = false;
  // Map to track expanded state of each group
  Map<String, bool> expandedGroups = {};

  // Controllers for create group form
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
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    setState(() {
      isLoading = true;
    });
    final GroupRepository groupRepository =
        GroupRepository(userRepository: locator<UserRepository>());
    try {
      groups = await groupRepository.getGroups();
      // Initialize all groups as collapsed
      for (var group in groups) {
        expandedGroups[group.idUserGroup] = false;
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading groups: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _toggleGroupExpansion(String groupId) {
    setState(() {
      expandedGroups[groupId] = !(expandedGroups[groupId] ?? false);
    });
  }

  void _showCreateGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateGroupDialog(
        groups: groups,
        onSubmit: (newGroup) async {
          try {
            final GroupRepository groupRepository = GroupRepository(
              userRepository: locator<UserRepository>(),
            );
            await groupRepository.createGroup(newGroup);
            Navigator.pop(context);
            await _fetchGroups();
            idUserGroupController.clear();
            nameController.clear();
            descriptionController.clear();
            displayOrderController.clear();
            groupLevelController.clear();
            setState(() {
              selectedParentId = null;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo nhóm thành công!'),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Lỗi tạo nhóm: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Trị Người Dùng'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchGroups,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : groups.isEmpty
              ? const Center(child: Text('Không có nhóm người dùng nào'))
              : ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    final isExpanded =
                        expandedGroups[group.idUserGroup] ?? false;

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Group header - always visible
                          ListTile(
                            title: Text(
                              group.idUserGroup,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                '${group.users.length} người dùng - Nhóm: ${group.idUserGroup}'),
                            trailing: IconButton(
                              icon: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                              onPressed: () =>
                                  _toggleGroupExpansion(group.idUserGroup),
                            ),
                            onTap: () =>
                                _toggleGroupExpansion(group.idUserGroup),
                          ),

                          // Users list - visible only when expanded
                          if (isExpanded)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: group.users.length,
                              itemBuilder: (context, userIndex) {
                                final user = group.users[userIndex];
                                return UserListItem(user: user);
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateGroupDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
  final TextEditingController groupLevelController = TextEditingController();
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

class UserListItem extends StatelessWidget {
  final UserModel user;

  const UserListItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?'),
        ),
        title: Text(user.name),
        subtitle: Text(user.email ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Edit user action
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete user action
              },
            ),
          ],
        ),
      ),
    );
  }
}
