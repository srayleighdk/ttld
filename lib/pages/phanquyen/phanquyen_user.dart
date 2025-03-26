import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/permission_role/permission_role.dart';
import 'package:ttld/repositories/user_role_repository.dart';

class PhanQuyenUser extends StatefulWidget {
  final String userName;
  const PhanQuyenUser({super.key, required this.userName});

  @override
  State<PhanQuyenUser> createState() => _PhanQuyenUserState();
}

class _PhanQuyenUserState extends State<PhanQuyenUser> {
  bool _isLoading = false;
  List<PermissionRole> _permissions = [];
  final UserRoleRepository _userRepository = locator<UserRoleRepository>();

  @override
  void initState() {
    super.initState();
    _loadUserPermissions();
  }

  Future<void> _loadUserPermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<PermissionRole> permissions =
          await _userRepository.fetchRoles(widget.userName);

      setState(() {
        _permissions = permissions;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading permissions: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _savePermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Implement your save logic here using the repository
      await _userRepository.updateUserRoles(_permissions, widget.userName);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissions saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving permissions: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Permissions - ${widget.userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _savePermissions,
            tooltip: 'Save Permissions',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _permissions.isEmpty
              ? const Center(child: Text('No permissions found for this user'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Permission Management',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPermissionTree(_permissions),
                    ],
                  ),
                ),
    );
  }

  Widget _buildPermissionTree(List<PermissionRole> permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: permissions
          .map((permission) => _buildPermissionItem(permission, 0))
          .toList(),
    );
  }

  Widget _buildPermissionItem(PermissionRole permission, int depth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.only(left: depth * 20.0, bottom: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  permission.description ?? 'No Description',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildPermissionCheckbox(
                      'View',
                      permission.executeSelect ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(executeSelect: value);
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Add',
                      permission.executeInsert ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(executeInsert: value);
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Edit',
                      permission.executeUpdate ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(executeUpdate: value);
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Delete',
                      permission.executeDelete ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(executeDelete: value);
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Approve',
                      permission.executeDuyet ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(executeDuyet: value);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (permission.children != null && permission.children!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: permission.children!
                .map((child) => _buildPermissionItem(child, depth + 1))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildPermissionCheckbox(
      String label, bool value, Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
          Text(label),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
