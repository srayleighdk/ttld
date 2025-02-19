import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/hosoungvien/bloc/hosoungvien_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';

class HoSoUngVienPage extends StatelessWidget {
  const HoSoUngVienPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HoSoUngVienBloc(hoSoUngVienApiService: HoSoUngVienApiService())
        ..add(HoSoUngVienFetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hồ Sơ Ứng Viên'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to create new HoSoUngVien
              },
            ),
          ],
        ),
        body: BlocBuilder<HoSoUngVienBloc, HoSoUngVienState>(
          builder: (context, state) {
            if (state is HoSoUngVienInitial) {
              return const Center(child: Text('Initial State'));
            } else if (state is HoSoUngVienLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HoSoUngVienLoaded) {
              return ListView.builder(
                itemCount: state.hoSoUngVienList.length,
                itemBuilder: (context, index) {
                  final hoSoUngVien = state.hoSoUngVienList[index];
                  return Card(
                    child: ListTile(
                      title: Text(hoSoUngVien.uvHoten ?? 'N/A'),
                      subtitle: Text(hoSoUngVien.uvEmail ?? 'N/A'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Navigate to edit HoSoUngVien
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Show delete confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Xác nhận xóa'),
                                    content: const Text(
                                        ('Bạn có chắc chắn muốn xóa hồ sơ này?')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Hủy'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Delete HoSoUngVien
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Xóa'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is HoSoUngVienError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
