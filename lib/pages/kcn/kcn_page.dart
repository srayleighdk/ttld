import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/blocs/kcn/kcn_cubit.dart';

class KcnPage extends StatefulWidget {
  const KcnPage({super.key});

  @override
  State<KcnPage> createState() => _KcnPageState();
}

class _KcnPageState extends State<KcnPage> {
  @override
  void initState() {
    super.initState();
    // Replace 'your_matinh' with the actual matinh value
    context.read<KcnCubit>().getKCN('your_matinh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KCN Data'),
      ),
      body: BlocBuilder<KcnCubit, KcnState>(
        builder: (context, state) {
          if (state is KcnLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KcnLoaded) {
            return ListView.builder(
              itemCount: state.kcnList.length,
              itemBuilder: (context, index) {
                final kcn = state.kcnList[index];
                return ListTile(
                  title: Text(kcn.displayName),
                  subtitle: Text(
                      'Mã tỉnh: ${kcn.matinh}, Thứ tự hiển thị: ${kcn.displayOrder}, Trạng thái: ${kcn.status}'),
                );
              },
            );
          } else if (state is KcnError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Initial state'));
          }
        },
      ),
    );
  }
}
