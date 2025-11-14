import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ttld/blocs/m02tt11/m02tt11_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/m02tt11/m02tt11_model.dart';
import 'package:ttld/pages/dang_ky_tim_viec_lam/dang_ky_tim_viec_lam_page.dart';
import 'package:ttld/utils/m02tt11_mapper.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class DangKyTimViecLamListPage extends StatelessWidget {
  static const String routePath = '/ntv_home/dang-ky-tim-viec-lam-list';

  const DangKyTimViecLamListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<M02TT11Bloc>(),
      child: const _DangKyTimViecLamListPageContent(),
    );
  }
}

class _DangKyTimViecLamListPageContent extends StatefulWidget {
  const _DangKyTimViecLamListPageContent();

  @override
  State<_DangKyTimViecLamListPageContent> createState() =>
      _DangKyTimViecLamListPageState();
}

class _DangKyTimViecLamListPageState
    extends State<_DangKyTimViecLamListPageContent> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _userId = authState.userId;
      context.read<M02TT11Bloc>().add(LoadM02TT11List(userId: _userId!));
    }
  }

  Future<void> _navigateToCreate() async {
    if (_userId == null) return;

    try {
      // Show loading indicator
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Fetch HoSoUngVien data for the current user
      final hosoUVService = locator<HoSoUngVienApiService>();
      final hosoUV = await hosoUVService.getHoSoUngVienByUserId(_userId!);

      // Dismiss loading indicator
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Pre-populate M02TT11 with HoSoUngVien data
      M02TT11? initialData;
      if (hosoUV != null && M02TT11Mapper.hasEssentialData(hosoUV)) {
        initialData = M02TT11Mapper.fromHoSoUngVien(hosoUV);
      }

      if (mounted) {
        // Navigate to form with pre-populated data
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) =>
                DangKyTimViecLamPage(existingData: initialData),
          ),
        )
            .then((_) {
          // Reload list after creating/updating
          if (_userId != null) {
            context.read<M02TT11Bloc>().add(LoadM02TT11List(userId: _userId!));
          }
        });
      }
    } catch (e) {
      // Dismiss loading indicator if still showing
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // Show error and navigate anyway with empty form
      if (mounted) {
        ToastUtils.showWarningToast(
          context,
          'Không thể tải dữ liệu hồ sơ. Vui lòng nhập thủ công.',
        );

        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const DangKyTimViecLamPage(),
          ),
        )
            .then((_) {
          if (_userId != null) {
            context.read<M02TT11Bloc>().add(LoadM02TT11List(userId: _userId!));
          }
        });
      }
    }
  }

  void _navigateToEdit(M02TT11 item) {
    if (_userId == null) return;

    // Navigate to edit page with existing data
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => DangKyTimViecLamPage(existingData: item),
      ),
    )
        .then((_) {
      // Reload list after editing
      if (_userId != null) {
        context.read<M02TT11Bloc>().add(LoadM02TT11List(userId: _userId!));
      }
    });
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content:
            const Text('Bạn có chắc chắn muốn xóa đăng ký tìm việc làm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<M02TT11Bloc>().add(DeleteM02TT11(id: id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Đăng ký tìm việc làm',
        useGradient: true,
      ),
      body: BlocConsumer<M02TT11Bloc, M02TT11State>(
        listener: (context, state) {
          if (state is M02TT11OperationSuccess) {
            ToastUtils.showSuccessToast(context, state.message);
            // Reload list after operation
            if (_userId != null) {
              context
                  .read<M02TT11Bloc>()
                  .add(LoadM02TT11List(userId: _userId!));
            }
          } else if (state is M02TT11Error) {
            ToastUtils.showErrorToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is M02TT11Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is M02TT11Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Có lỗi xảy ra',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_userId != null) {
                        context
                            .read<M02TT11Bloc>()
                            .add(LoadM02TT11List(userId: _userId!));
                      }
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is M02TT11ListLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.fileCirclePlus,
                      size: 80,
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Chưa có đăng ký nào',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nhấn nút bên dưới để tạo đăng ký mới',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                if (_userId != null) {
                  context
                      .read<M02TT11Bloc>()
                      .add(LoadM02TT11List(userId: _userId!));
                }
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return _buildRegistrationCard(context, item, theme);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreate,
        icon: const Icon(FontAwesomeIcons.plus),
        label: const Text('Đăng ký mới'),
      ),
    );
  }

  Widget _buildRegistrationCard(
      BuildContext context, M02TT11 item, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToEdit(item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      FontAwesomeIcons.briefcase,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.hoten ?? 'Không có tên',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (item.maphieu != null)
                          Text(
                            'Mã phiếu: ${item.maphieu}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _navigateToEdit(item);
                      } else if (value == 'delete') {
                        _confirmDelete(item.idphieu ?? '');
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Chỉnh sửa'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildInfoRow(
                context,
                FontAwesomeIcons.calendarDays,
                'Ngày lập',
                item.ngaylap != null
                    ? DateFormat('dd/MM/yyyy').format(item.ngaylap!)
                    : 'Chưa có',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                FontAwesomeIcons.phone,
                'Điện thoại',
                item.dienthoai ?? 'Chưa có',
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                FontAwesomeIcons.envelope,
                'Email',
                item.email ?? 'Chưa có',
              ),
              if (item.tenVv != null) ...[
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  FontAwesomeIcons.bullseye,
                  'Công việc mong muốn',
                  item.tenVv!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
