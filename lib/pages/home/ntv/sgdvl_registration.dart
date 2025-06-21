import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/sgdvl/sgdvl_bloc.dart';
import 'package:ttld/bloc/uv_dk_sgd/uv_dk_sgd_bloc.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';
import 'package:intl/intl.dart';

class SGDVLRegistrationPage extends StatelessWidget {
  const SGDVLRegistrationPage({super.key});

  static const routePath = '/sgdvl-registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký phiên GDVL'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UvDkSGDBloc, UvDkSGDState>(
            listener: (context, state) {
              if (state is UvDkSGDRegistered) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đăng ký thành công!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is UvDkSGDRegistrationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lỗi: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<SGDVLBloc, SGDVLState>(
          builder: (context, state) {
            if (state is SGDVLInitial) {
              context.read<SGDVLBloc>().add(LoadSGDVLs());
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SGDVLLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SGDVLError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is SGDVLLoaded) {
              return _buildSGDVLList(context, state.sgdvls);
            }

            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildSGDVLList(BuildContext context, List<SGDVL> sgdvls) {
    if (sgdvls.isEmpty) {
      return const Center(child: Text('Không có phiên GDVL nào'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sgdvls.length,
      itemBuilder: (context, index) {
        final sgdvl = sgdvls[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sgdvl.pgdTen,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Ngày:', sgdvl.pgdNgay),
                _buildInfoRow('Giờ:', sgdvl.pgdGio),
                _buildInfoRow('Địa điểm:', sgdvl.pgdDiadiem),
                _buildInfoRow('Tổng nhu cầu tuyển dụng:', '${sgdvl.tongNhucauTd} người'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số UV đăng ký: ${sgdvl.soUvDangkyPgd}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    BlocBuilder<UvDkSGDBloc, UvDkSGDState>(
                      builder: (context, state) {
                        final bool isRegistering = state is UvDkSGDRegistering;
                        return ElevatedButton(
                          onPressed: isRegistering
                              ? null
                              : () => _handleRegistration(context, sgdvl),
                          child: isRegistering
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Đăng ký'),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _handleRegistration(BuildContext context, SGDVL sgdvl) {
    // TODO: Get the current user ID from authentication
    const String userId = '1'; // Temporary hardcoded value

    final registration = UvDkSGD(
      idUngvien: userId,
      idPhienGd: sgdvl.id,
      ngaydk: DateTime.now().toIso8601String(),
      ngayPgd: sgdvl.pgdNgay,
      tieude: 'Đăng ký tham gia phiên GDVL: ${sgdvl.pgdTen}',
      email: '', // TODO: Get from user profile
      duyet: false,
      isThamgia: false,
      createdDate: DateTime.now().toIso8601String(),
      createdBy: userId,
      modifiredDate: DateTime.now().toIso8601String(),
      modifiredBy: userId,
    );

    context.read<UvDkSGDBloc>().add(RegisterForSGDVL(registration: registration));
  }
}

