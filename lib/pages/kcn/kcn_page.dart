import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/kcn/kcn_cubit.dart';
import 'package:ttld/core/di/injection.dart';

class KcnPage extends StatefulWidget {
  const KcnPage({Key? key}) : super(key: key);

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
            return Center(
              child: Text('Data: ${state.data.toString()}'),
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
