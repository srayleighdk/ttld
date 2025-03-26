import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/user/user_model.dart';
import 'package:ttld/repositories/user/user_repository.dart';

class PhanQuyenPage extends StatefulWidget {
  const PhanQuyenPage({super.key});

  @override
  State<PhanQuyenPage> createState() => _PhanQuyenPageState();
}

class _PhanQuyenPageState extends State<PhanQuyenPage> {
  // Mock data for demonstration
  List<UserModel> _users = [];

  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load users from API or database in real implementation
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });
    final userRepository = locator<UserRepository>();
    final List<UserModel> users = await userRepository.getAllUsers();

    setState(() {
      _users = users;
      _isLoading = false;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  void _editUser(UserModel user) {
    context.push(
      '/phan-quyen-user',
      extra: user.name,
    );
  }

  void _deleteUser(UserModel user) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete user in real implementation
              setState(() {
                _users.removeWhere((u) => u.idUser == user.idUser);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User ${user.name} deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Permission Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search users...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      // Implement search functionality
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add new user functionality
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add User'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'User Permissions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: const [
                            DataColumn2(
                              label: Text('ID'),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: Text('Name'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text('Email'),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: Text('Role'),
                              size: ColumnSize.M,
                            ),
                            DataColumn2(
                              label: Text('Actions'),
                              size: ColumnSize.M,
                            ),
                          ],
                          rows: _users.map((user) {
                            return DataRow2(
                              cells: [
                                DataCell(Text('#${user.idUser}')),
                                DataCell(Text(user.name)),
                                DataCell(Text(user.email!)),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getRoleColor(user.idUserGroup),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      user.idUserGroup,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.blue,
                                        tooltip: 'Edit',
                                        onPressed: () => _editUser(user),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        tooltip: 'Delete',
                                        onPressed: () => _deleteUser(user),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.purple;
      case 'ldvl':
        return Colors.blue;
      case 'bhtn':
        return Colors.green;
      case 'phonghanhchinh':
        return Colors.orange;
      case 'web':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// In case you don't have these classes defined yet:
class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

// Simple User model if you don't have one
class User {
  final int id;
  final String name;
  final String email;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
