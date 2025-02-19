import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/tblDmChuyenMon/chuyenmon_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/chuyenmon/chuyenmon.dart';

class ChuyenMonScreen extends StatelessWidget {
  const ChuyenMonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chuyen Mon')),
      body: BlocProvider(
        create: (context) => ChuyenMonBloc(locator())
          ..add(LoadChuyenMons()), // Initialize and load data
        child: BlocBuilder<ChuyenMonBloc, ChuyenMonState>(
          builder: (context, state) {
            if (state is ChuyenMonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChuyenMonLoaded) {
              return ListView.builder(
                itemCount: state.chuyenMons.length,
                itemBuilder: (context, index) {
                  final chuyenMon = state.chuyenMons[index];
                  return ListTile(
                    title: Text(chuyenMon.tenChuyenMon),
                    subtitle: Text('Status: ${chuyenMon.status}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<ChuyenMonBloc>(context)
                            .add(DeleteChuyenMon(chuyenMon.maChuyenMon));
                      },
                    ),
                  );
                },
              );
            } else if (state is ChuyenMonError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Initial State'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to a screen to create a new ChuyenMon
          // You'll need to implement that screen separately
          _showCreateDialog(context);
        },
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    String newTenChuyenMon = '';
    int newDisplayOrder = 1;
    bool newStatus = true; // Default to active
    String newCreatedBy = 'User'; // Or get the current user

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Chuyen Mon'),
          content: SingleChildScrollView(
            // Wrap in SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Ten Chuyen Mon'),
                  onChanged: (value) {
                    newTenChuyenMon = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Display Order'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    newDisplayOrder =
                        int.tryParse(value) ?? 1; // Parse as int, default to 1
                  },
                ),
                DropdownButtonFormField<bool>(
                  decoration: const InputDecoration(labelText: 'Status'),
                  value: newStatus,
                  items: const [
                    DropdownMenuItem(value: false, child: Text('Inactive')),
                    DropdownMenuItem(value: true, child: Text('Active')),
                  ],
                  onChanged: (value) {
                    newStatus = value!;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Created By'),
                  onChanged: (value) {
                    newCreatedBy = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                if (newTenChuyenMon.isNotEmpty) {
                  final newChuyenMon = ChuyenMon(
                    maChuyenMon: newTenChuyenMon,
                    displayOrder: newDisplayOrder,
                    status: newStatus,
                    createdBy: newCreatedBy,
                  );
                  BlocProvider.of<ChuyenMonBloc>(context)
                      .add(CreateChuyenMon(newChuyenMon));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
