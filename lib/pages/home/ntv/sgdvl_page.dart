import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';
import 'package:ttld/pages/home/ntv/sgdvl_registration.dart';
import 'package:ttld/repositories/uv_dk_sgd_repository.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_bloc.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';

class SGDVLPage extends StatelessWidget {
  static const String routePath = '/sgdvl';

  const SGDVLPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uvDkSgdRepository = locator<UvDkSGDRepository>();
    final sgdvlBloc = locator<SGDVLBloc>();

    // Try to get NTVBloc from context, if not available, provide it
    NTVBloc? ntvBloc;
    try {
      ntvBloc = BlocProvider.of<NTVBloc>(context, listen: false);
    } catch (e) {
      // NTVBloc not found in context, we'll provide it
    }

    Widget content = Scaffold(
      appBar: AppBar(
        title: Text(
          'Sàn Giao Dịch Việc Làm',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          sgdvlBloc.add(LoadSGDVLs());
          // You might want to also refresh the joined events here
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Available Sessions
                _buildSectionHeader(theme, 'Phiên giao dịch việc làm hiện có'),
                const SizedBox(height: 16),
                BlocBuilder<SGDVLBloc, SGDVLState>(
                  bloc: sgdvlBloc..add(LoadSGDVLs()),
                  builder: (context, state) {
                    if (state is SGDVLLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is SGDVLLoaded) {
                      final sgdvls = state.sgdvls;
                      if (sgdvls.isEmpty) {
                        return _buildEmptySection(
                          context,
                          'Chưa có phiên giao dịch nào',
                          'Hiện tại chưa có phiên giao dịch việc làm nào được tổ chức.',
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sgdvls.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            _buildSGDVLCard(context, sgdvls[index]),
                      );
                    }
                    if (state is SGDVLError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text('Lỗi: ${state.message}'),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 32),

                // Section 2: Joined Sessions
                _buildSectionHeader(theme, 'Phiên giao dịch đã tham gia'),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  bloc: locator<AuthBloc>(),
                  builder: (context, state) {
                    if (state is! AuthAuthenticated) {
                      return _buildEmptySection(
                        context,
                        'Vui lòng đăng nhập',
                        'Đăng nhập để xem các phiên giao dịch bạn đã tham gia.',
                      );
                    }
                    return FutureBuilder<List<UvDkSGD>>(
                      future: uvDkSgdRepository.getUvDkSGDs(state.userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text('Lỗi: ${snapshot.error}'),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptySection(
                            context,
                            'Chưa tham gia phiên nào',
                            'Bạn chưa tham gia phiên giao dịch việc làm nào.',
                          );
                        }
                        final joinedEvents = snapshot.data!
                            .where((event) => event.isThamgia)
                            .toList();
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: joinedEvents.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              _buildJoinedEventCard(
                                  context, joinedEvents[index]),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () =>
      //       context.go('/ntv_home${SGDVLRegistrationPage.routePath}'),
      //   icon: const Icon(Icons.add_circle_outline),
      //   label: const Text('Đăng ký phiên giao dịch'),
      // ),
    );

    // If NTVBloc is not available in the context, provide it
    if (ntvBloc == null) {
      return BlocProvider<NTVBloc>.value(
        value: locator<NTVBloc>(),
        child: content,
      );
    }

    return content;
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySection(
      BuildContext context, String title, String message) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_busy_outlined,
            size: 48,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSGDVLCard(BuildContext context, SGDVL sgdvl) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sgdvl.pgdTen,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.calendar_today,
              'Ngày:',
              _formatDate(sgdvl.pgdNgay),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.access_time,
              'Giờ:',
              sgdvl.pgdGio,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.location_on,
              'Địa điểm:',
              sgdvl.pgdDiadiem,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.people,
              'Nhu cầu tuyển:',
              '${sgdvl.tongNhucauTd} người',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số UV đăng ký: ${sgdvl.soUvDangkyPgd}',
                  style: theme.textTheme.bodyMedium,
                ),
                FilledButton.tonal(
                  onPressed: () =>
                      context.go('/ntv_home${SGDVLRegistrationPage.routePath}'),
                  child: const Text('Đăng ký'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinedEventCard(BuildContext context, UvDkSGD event) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.tieude,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.calendar_today,
              'Ngày đăng ký:',
              _formatDate(event.ngaydk),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.event,
              'Ngày diễn ra:',
              _formatDate(event.ngayPgd),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              Icons.email,
              'Email:',
              event.email,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: event.duyet
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    event.duyet ? 'Đã duyệt' : 'Chờ duyệt',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: event.duyet ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
