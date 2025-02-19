import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class HoSoUngVienPage extends StatefulWidget {
  const HoSoUngVienPage({Key? key}) : super(key: key);

  @override
  State<HoSoUngVienPage> createState() => _HoSoUngVienPageState();
}

class _HoSoUngVienPageState extends State<HoSoUngVienPage> {
  List<TblHoSoUngVienModel> hoSoUngVienList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Replace with your actual API service call
      hoSoUngVienList = await HoSoUngVienApiService().getHoSoUngVienList();
    } catch (e) {
      print('Error fetching  $e');
      // Handle error appropriately
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: hoSoUngVienList.length,
              itemBuilder: (context, index) {
                final hoSoUngVien = hoSoUngVienList[index];
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
            ),
    );
  }
}

// Placeholder API service
class HoSoUngVienApiService {
  Future<List<TblHoSoUngVienModel>> getHoSoUngVienList() async {
    // Replace with your actual API endpoint
    const String apiUrl = '/api/nghiep-vu/hoso-uv';
    final dio = Dio();
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => TblHoSoUngVienModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load HoSoUngVien: ${response.statusCode}');
    }
  }
}
