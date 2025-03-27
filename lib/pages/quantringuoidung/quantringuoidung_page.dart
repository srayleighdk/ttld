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
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm nhóm người dùng'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idUserGroupController,
                  decoration: const InputDecoration(
                    labelText: 'Mã nhóm *',
                    hintText: 'Nhập mã nhóm',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã nhóm';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedParentId,
                  decoration: const InputDecoration(
                    labelText: 'Nhóm cha',
                    hintText: 'Chọn nhóm cha',
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Không có nhóm cha'),
                    ),
                    ...groups.map(
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
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên nhóm *',
                    hintText: 'Nhập tên nhóm',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên nhóm';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả',
                    hintText: 'Nhập mô tả',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: displayOrderController,
                  decoration: const InputDecoration(
                    labelText: 'STT',
                    hintText: 'Nhập số thứ tự',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: groupLevelController,
                  decoration: const InputDecoration(
                    labelText: 'Group-Level',
                    hintText: 'Nhập cấp độ nhóm',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Duyệt'),
                  value: statusValue,
                  onChanged: (value) {
                    setState(() {
                      statusValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (idUserGroupController.text.isEmpty || nameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng điền các trường bắt buộc (*)'),
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
                    statusValue = true;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi tạo nhóm: ${e.toString()}'),
                    ),
                  );
                }
              },
              child: const Text('Tạo'),
            ),
          ],
        );
      },
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
