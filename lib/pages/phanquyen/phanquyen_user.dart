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

  // Map to keep track of expanded state for each permission
  final Map<String?, bool> _expandedState = {};

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
        // Initialize expanded state for all permissions
        for (var permission in permissions) {
          _initializeExpandedState(permission);
        }
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

  void _initializeExpandedState(PermissionRole permission) {
    // Use idMenu or another unique identifier as key
    _expandedState[permission.idMenu] = true; // Default to expanded

    if (permission.children != null) {
      for (var child in permission.children!) {
        _initializeExpandedState(child);
      }
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Permission Management',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _isLoading ? null : _savePermissions,
                            icon: const Icon(Icons.save),
                            label: const Text('Update Permissions'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
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
    bool hasChildren =
        permission.children != null && permission.children!.isNotEmpty;
    bool isExpanded = _expandedState[permission.idMenu] ?? true;

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
                Row(
                  children: [
                    if (hasChildren)
                      IconButton(
                        icon: Icon(
                          isExpanded ? Icons.expand_more : Icons.chevron_right,
                          size: 24,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _expandedState[permission.idMenu] = !isExpanded;
                          });
                        },
                      )
                    else
                      const SizedBox(width: 24), // For alignment when no toggle
                    Expanded(
                      child: Text(
                        permission.description ?? 'No Description',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
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
                          permission = permission.copyWith(
                            executeSelect: value,
                          );
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Add',
                      permission.executeInsert ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(
                            executeInsert: value,
                          );
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Edit',
                      permission.executeUpdate ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(
                            executeUpdate: value,
                          );
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Delete',
                      permission.executeDelete ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(
                            executeDelete: value,
                          );
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Approve',
                      permission.executeDuyet ?? false,
                      (value) {
                        setState(() {
                          permission = permission.copyWith(
                            executeDuyet: value,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (hasChildren && isExpanded)
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
