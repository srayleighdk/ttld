import 'package:flutter/material.dart';
import 'package:ttld/features/user_group/models/group.dart';
import 'package:ttld/features/user_group/repository/group_repository.dart';
import 'package:ttld/models/user/user_model.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    setState(() {
      isLoading = true;
    });
    final GroupRepository groupRepository = GroupRepository();
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
                            subtitle: Text('${group.users.length} người dùng'),
                            trailing: IconButton(
                              icon: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                              onPressed: () => _toggleGroupExpansion(group.id),
                            ),
                            onTap: () => _toggleGroupExpansion(group.id),
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
        onPressed: () {
          // Add action for creating new group or user
        },
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
