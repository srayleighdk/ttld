import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_event.dart';
import 'package:ttld/bloc/tblNhaTuyenDung/ntd_state.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';

class NhaTuyenDungPage extends StatelessWidget {
  static const routePath = '/nha-tuyen-dung';
  const NhaTuyenDungPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhà Tuyển Dụng'),
      ),
      body: BlocBuilder<NTDBloc, NTDState>(
        builder: (context, state) {
          if (state is NTDInitial) {
            context.read<NTDBloc>().add(NTDFetchList());
            return const Center(child: CircularProgressIndicator());
          } else if (state is NTDLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NTDLoaded) {
            return _buildNTDList(state.ntdList);
          } else if (state is NTDError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildNTDList(List<NtdModel> ntdList) {
    return ListView.builder(
      itemCount: ntdList.length,
      itemBuilder: (context, index) {
        final ntd = ntdList[index];
        return Card(
          child: ListTile(
            title: Text(ntd.ntdTen ?? 'N/A'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mã DN: ${ntd.ntdMadn}'),
                Text('Email: ${ntd.ntdEmail ?? 'N/A'}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
