import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class TongQuanPage extends StatefulWidget {
  static const routePath = '/ntd_home/tong_quan';
  const TongQuanPage({super.key});

  @override
  State<TongQuanPage> createState() => _TongQuanPageState();
}

class _TongQuanPageState extends State<TongQuanPage> {
  late NTDBloc _ntdBloc;
  late TuyenDungBloc _tuyenDungBloc;
  String? userId;
  String? idDoanhNghiep;

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  void _initializeBlocs() {
    _ntdBloc = locator<NTDBloc>();
    _tuyenDungBloc = locator<TuyenDungBloc>();

    final authState = locator<AuthBloc>().state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      userId = authState.userId;
      
      // Load NTD data to get idDoanhNghiep
      if (!_ntdBloc.isClosed) {
        _ntdBloc.add(NTDFetchById(int.parse(userId!)));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const CustomAppBar(
        title: 'Tổng quan',
      ),
      body: BlocBuilder<NTDBloc, NTDState>(
        bloc: _ntdBloc,
        builder: (context, ntdState) {
          if (ntdState is NTDLoadedById) {
            idDoanhNghiep = ntdState.ntd.idDoanhNghiep;
            
            // Load recruitment data once we have idDoanhNghiep
            if (idDoanhNghiep != null && !_tuyenDungBloc.isClosed) {
              _tuyenDungBloc.add(TuyenDungEvent.fetchList(idDoanhNghiep));
            }
          }

          return BlocBuilder<TuyenDungBloc, TuyenDungState>(
            bloc: _tuyenDungBloc,
            builder: (context, tuyenDungState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(theme, ntdState),
                    const SizedBox(height: 20),
                    _buildStatisticsCards(theme, tuyenDungState),
                    const SizedBox(height: 20),
                    _buildRecentActivity(theme, tuyenDungState),
                    const SizedBox(height: 20),
                    _buildQuickInsights(theme),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme, NTDState ntdState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  FontAwesomeIcons.chartLine,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tổng quan hoạt động',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (ntdState is NTDLoadedById)
                      Text(
                        ntdState.ntd.ntdTen ?? 'Doanh nghiệp',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Theo dõi hiệu quả tuyển dụng và quản lý nhân sự của doanh nghiệp',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(ThemeData theme, TuyenDungState tuyenDungState) {
    int totalJobs = 0;
    int activeJobs = 0;
    int pendingJobs = 0;

    if (tuyenDungState is TuyenDungLoaded) {
      totalJobs = tuyenDungState.tuyenDungList.length;
      activeJobs = tuyenDungState.tuyenDungList.where((td) => td.tdDuyet == true).length;
      pendingJobs = tuyenDungState.tuyenDungList.where((td) => td.tdDuyet == false).length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thống kê tuyển dụng',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                theme,
                'Tổng tin tuyển dụng',
                totalJobs.toString(),
                FontAwesomeIcons.briefcase,
                [Color(0xFF4A6FFF), Color(0xFF2E5CFF)],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                theme,
                'Đang hoạt động',
                activeJobs.toString(),
                FontAwesomeIcons.checkCircle,
                [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                theme,
                'Chờ duyệt',
                pendingJobs.toString(),
                FontAwesomeIcons.clock,
                [Color(0xFFFF9800), Color(0xFFF57C00)],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                theme,
                'Lượt xem',
                '0', // TODO: Calculate total views
                FontAwesomeIcons.eye,
                [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    ThemeData theme,
    String title,
    String value,
    IconData icon,
    List<Color> gradientColors,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(ThemeData theme, TuyenDungState tuyenDungState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.clockRotateLeft,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Hoạt động gần đây',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (tuyenDungState is TuyenDungLoaded && tuyenDungState.tuyenDungList.isNotEmpty)
            ...tuyenDungState.tuyenDungList.take(3).map((td) => _buildActivityItem(
              theme,
              td.tdTieude ?? 'Tin tuyển dụng',
              td.tdDuyet == true ? 'Đã duyệt' : 'Chờ duyệt',
              td.createdDate,
              td.tdDuyet == true ? Colors.green : Colors.orange,
            ))
          else
            _buildEmptyActivity(theme),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    ThemeData theme,
    String title,
    String status,
    DateTime? date,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      status,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (date != null) ...[
                      Text(
                        ' • ',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        _formatDate(date),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivity(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.inbox,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có hoạt động nào',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tạo tin tuyển dụng đầu tiên để bắt đầu',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsights(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.05),
            theme.colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.lightbulb,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Gợi ý cải thiện',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            theme,
            'Tối ưu hóa tin tuyển dụng',
            'Thêm mô tả chi tiết và yêu cầu rõ ràng để thu hút ứng viên phù hợp',
            FontAwesomeIcons.bullseye,
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            theme,
            'Tăng tương tác',
            'Cập nhật thông tin doanh nghiệp và hình ảnh để tạo ấn tượng tốt',
            FontAwesomeIcons.handshake,
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            theme,
            'Theo dõi hiệu quả',
            'Kiểm tra thống kê lượt xem và ứng tuyển để điều chỉnh chiến lược',
            FontAwesomeIcons.chartBar,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
    ThemeData theme,
    String title,
    String description,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hôm nay';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}