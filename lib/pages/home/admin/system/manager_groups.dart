import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/user_group/bloc/group_bloc.dart';
import 'package:ttld/features/user_group/models/group.dart';

class ManagerUserPage extends StatefulWidget {
  const ManagerUserPage({super.key});

  @override
  State<ManagerUserPage> createState() => _ManagerUserPageState();
}

class _ManagerUserPageState extends State<ManagerUserPage> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(LoadGroups()); // Trigger loading groups
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage User Groups")),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GroupLoaded) {
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                final group = state.groups[index];
                return ListTile(
                  title: Text(group.name ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(context, group),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context
                            .read<GroupBloc>()
                            .add(DeleteGroup(group.idUserGroup)),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           UserListPage(groupId: group.idUserGroup)),
                    // );
                  },
                );
              },
            );
          }
          return Center(child: Text("No groups available"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddDialog(context),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Group"),
          content: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Group Name")),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                // context.read<GroupBloc>().add(CreateGroup(controller.text));
                // Navigator.pop(context);
              },
              child: Text("Create"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Group group) {
    final TextEditingController controller =
        TextEditingController(text: group.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Group"),
          content: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Group Name")),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                context
                    .read<GroupBloc>()
                    .add(UpdateGroup(group.idUserGroup, controller.text));
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
