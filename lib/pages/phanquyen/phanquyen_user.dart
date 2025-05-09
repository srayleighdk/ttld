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
    // Start with parent nodes collapsed
    _expandedState[permission.idMenu] = permission.children?.isEmpty ?? true;

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
      Navigator.pop(context);
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

  void _updatePermissionInList(PermissionRole newPermission) {
    _permissions = _updatePermissionRecursive(_permissions, newPermission);
  }

  List<PermissionRole> _updatePermissionRecursive(
      List<PermissionRole> permissions, PermissionRole newPermission) {
    return permissions.map((perm) {
      if (perm.idMenu == newPermission.idMenu) {
        return newPermission;
      } else if (perm.children != null) {
        return perm.copyWith(
          children: _updatePermissionRecursive(perm.children!, newPermission),
        );
      }
      return perm;
    }).toList();
  }

  void _updateChildrenPermissions(PermissionRole parent, bool value) {
    final updatedChildren = parent.children?.map((child) {
      return child.copyWith(
        executeSelect: value,
        executeInsert: value,
        executeUpdate: value,
        executeDelete: value,
        executeDuyet: value,
      );
    }).toList();

    _updatePermissionInList(parent.copyWith(children: updatedChildren));
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
                      'Xem',
                      permission.executeSelect ?? false,
                      (value) {
                        setState(() {
                          if (hasChildren) {
                            _updateChildrenPermissions(permission, value);
                          }
                          _updatePermissionInList(
                              permission.copyWith(executeSelect: value));
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Thêm',
                      permission.executeInsert ?? false,
                      (value) {
                        setState(() {
                          if (hasChildren) {
                            _updateChildrenPermissions(permission, value);
                          }
                          _updatePermissionInList(
                              permission.copyWith(executeInsert: value));
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Sửa',
                      permission.executeUpdate ?? false,
                      (value) {
                        setState(() {
                          if (hasChildren) {
                            _updateChildrenPermissions(permission, value);
                          }
                          _updatePermissionInList(
                              permission.copyWith(executeUpdate: value));
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Xóa',
                      permission.executeDelete ?? false,
                      (value) {
                        setState(() {
                          if (hasChildren) {
                            _updateChildrenPermissions(permission, value);
                          }
                          _updatePermissionInList(
                              permission.copyWith(executeDelete: value));
                        });
                      },
                    ),
                    _buildPermissionCheckbox(
                      'Duyệt',
                      permission.executeDuyet ?? false,
                      (value) {
                        setState(() {
                          if (hasChildren) {
                            _updateChildrenPermissions(permission, value);
                          }
                          _updatePermissionInList(
                              permission.copyWith(executeDuyet: value));
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
