import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/blocs/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/blocs/kieuchapnoi/kieuchapnoi_cubit.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/widgets/logout_button.dart';

class ChapNoiNTDPage extends StatefulWidget {
  static const routePath = '/ntd_home/chap-noi';
  const ChapNoiNTDPage({super.key});

  @override
  State<ChapNoiNTDPage> createState() => _ChapNoiNTDPageState();
}

class _ChapNoiNTDPageState extends State<ChapNoiNTDPage> {
  late final ChapNoiBloc _chapNoiBloc;
  late final KieuChapNoiCubit _kieuChapNoiCubit;
  late final AuthBloc _authBloc;
  
  List<ChapNoiModel> chapNoiList = [];
  List<ChapNoiModel> filteredChapNoiList = [];
  List<KieuChapNoiModel> kieuChapNoiList = [];
  bool isLoading = true;
  int currentPage = 1;
  int totalRecords = 0;
  final int itemsPerPage = 10;
  
  // Status filtering variables
  int? selectedStatusFilter;
  bool showingFilteredList = false;

  @override
  void initState() {
    super.initState();
    _chapNoiBloc = locator<ChapNoiBloc>();
    _kieuChapNoiCubit = locator<KieuChapNoiCubit>();
    _authBloc = locator<AuthBloc>();
    
    _loadInitialData();
  }

  void _loadInitialData() {
    _kieuChapNoiCubit.loadKieuChapNois();
    _loadChapNoiData();
  }

  void _loadChapNoiData() {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated && authState.userType == 'ntd') {
      _chapNoiBloc.add(ChapNoiFetchList(
        limit: itemsPerPage,
        page: currentPage,
        status: selectedStatusFilter, // Use selected status filter
        idTuyenDung: null,
        idDoanhNghiep: authState.userId,
        idUv: null,
      ));
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    _loadChapNoiData();
  }

  void _filterByStatus(int? status) {
    setState(() {
      selectedStatusFilter = status;
      currentPage = 1; // Reset to first page when filtering
      showingFilteredList = status != null;
    });
    _loadChapNoiData();
  }

  void _clearFilter() {
    setState(() {
      selectedStatusFilter = null;
      currentPage = 1;
      showingFilteredList = false;
    });
    _loadChapNoiData();
  }

  void _showChapNoiDetails(ChapNoiModel chapNoi) {
    showDialog(
      context: context,
      builder: (context) => _ChapNoiDetailDialog(chapNoi: chapNoi),
    );
  }

  void _deleteChapNoi(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa hồ sơ chấp nhận này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _chapNoiBloc.add(ChapNoiDelete(id));
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Quản Lý Chấp Nhận Hồ Sơ',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 1.0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          LogoutButton(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.1),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card with Company Info
                _buildEnhancedHeaderCard(theme),
                const SizedBox(height: 12),
                
                // Quick Actions
                _buildQuickActions(theme),
                const SizedBox(height: 12),
                
                // Statistics Dashboard
                _buildEnhancedStatisticsCards(theme),
                const SizedBox(height: 12),
                
                // Content Section
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5, // Fixed height for content
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<ChapNoiBloc, ChapNoiState>(
                        bloc: _chapNoiBloc,
                        listener: (context, state) {
                          if (state is ChapNoiListLoaded) {
                            setState(() {
                              chapNoiList = state.chapNoiList;
                              if (selectedStatusFilter != null) {
                                if (selectedStatusFilter == 0) {
                                  filteredChapNoiList = chapNoiList.where((item) => item.idKetQua == 0 || item.idKetQua == null).toList();
                                } else {
                                  filteredChapNoiList = chapNoiList.where((item) => item.idKetQua == selectedStatusFilter).toList();
                                }
                              } else {
                                filteredChapNoiList = chapNoiList;
                              }
                              totalRecords = state.total;
                              isLoading = false;
                            });
                          } else if (state is ChapNoiLoading) {
                            setState(() {
                              isLoading = true;
                            });
                          } else if (state is ChapNoiError) {
                            setState(() {
                              isLoading = false;
                            });
                            ToastUtils.showToastDanger(
                              context,
                              description: state.message,
                            );
                          }
                        },
                      ),
                      BlocListener<KieuChapNoiCubit, List<KieuChapNoiModel>>(
                        bloc: _kieuChapNoiCubit,
                        listener: (context, state) {
                          setState(() {
                            kieuChapNoiList = state;
                          });
                        },
                      ),
                    ],
                    child: _buildEnhancedContent(theme),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedHeaderCard(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  FontAwesomeIcons.handshake,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quản Lý Chấp Nhận Hồ Sơ',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kết nối với ứng viên tiềm năng',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.building,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Nhà tuyển dụng',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            theme,
            'Làm Mới',
            FontAwesomeIcons.arrowsRotate,
            Colors.blue,
            () => _loadChapNoiData(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionButton(
            theme,
            'Xuất Báo Cáo',
            FontAwesomeIcons.fileExport,
            Colors.green,
            () {
              // TODO: Implement export functionality
              ToastUtils.showSuccessToast(context, 'Tính năng đang phát triển');
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionButton(
            theme,
            'Thống Kê',
            FontAwesomeIcons.chartLine,
            Colors.purple,
            () {
              // TODO: Implement statistics view
              ToastUtils.showSuccessToast(context, 'Tính năng đang phát triển');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    ThemeData theme,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedStatisticsCards(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    // Calculate statistics
    final totalApplications = totalRecords; // Use totalRecords for accurate count
    final pendingCount = chapNoiList.where((item) => item.idKetQua == 0 || item.idKetQua == null).length; // 0 = Chờ xử lý
    final rejectedCount = chapNoiList.where((item) => item.idKetQua == 1).length; // 1 = Không đạt
    final acceptedCount = chapNoiList.where((item) => item.idKetQua == 2).length; // 2 = Đạt
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.chartPie,
                color: colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Thống Kê Tổng Quan',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              if (selectedStatusFilter != null)
                TextButton.icon(
                  onPressed: _clearFilter,
                  icon: const Icon(FontAwesomeIcons.xmark, size: 12),
                  label: const Text('Xóa bộ lọc', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
                    foregroundColor: colorScheme.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildClickableStatCard(
                  theme,
                  'Tổng Hồ Sơ',
                  totalApplications.toString(),
                  FontAwesomeIcons.folder,
                  colorScheme.primary,
                  null, // Show all records
                  selectedStatusFilter == null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildClickableStatCard(
                  theme,
                  'Chờ Xử Lý',
                  pendingCount.toString(),
                  FontAwesomeIcons.clock,
                  Colors.orange,
                  0, // Status 0 for pending
                  selectedStatusFilter == 0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildClickableStatCard(
                  theme,
                  'Không Đạt',
                  rejectedCount.toString(),
                  FontAwesomeIcons.circleXmark,
                  Colors.red,
                  1, // Status 1 for rejected
                  selectedStatusFilter == 1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildClickableStatCard(
                  theme,
                  'Đạt',
                  acceptedCount.toString(),
                  FontAwesomeIcons.circleCheck,
                  Colors.green,
                  2, // Status 2 for accepted
                  selectedStatusFilter == 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatCard(ThemeData theme, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClickableStatCard(
    ThemeData theme, 
    String title, 
    String value, 
    IconData icon, 
    Color color, 
    int? statusFilter,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => _filterByStatus(statusFilter),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
            ? color.withValues(alpha: 0.15) 
            : color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
              ? color.withValues(alpha: 0.5) 
              : color.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Đã chọn',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }


  Widget _buildEnhancedContent(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.listCheck,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _getListTitle(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (totalRecords > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$totalRecords hồ sơ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: isLoading
                ? _buildLoadingState(theme)
                : filteredChapNoiList.isEmpty
                    ? _buildEnhancedEmptyState(theme)
                    : _buildChapNoiListView(theme),
          ),
          
          // Pagination
          if (totalRecords > itemsPerPage && !isLoading) 
            _buildModernPagination(theme),
        ],
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Đang tải dữ liệu...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedEmptyState(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.handshake,
                size: 32,
                color: colorScheme.primary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getEmptyStateTitle(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptyStateMessage(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _loadChapNoiData(),
                  icon: const Icon(FontAwesomeIcons.arrowsRotate, size: 14),
                  label: const Text('Làm mới'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
                if (selectedStatusFilter != null) ...[
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: _clearFilter,
                    icon: const Icon(FontAwesomeIcons.xmark, size: 14),
                    label: const Text('Xóa bộ lọc'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapNoiListView(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: filteredChapNoiList.length,
      itemBuilder: (context, index) {
        final chapNoi = filteredChapNoiList[index];
        return _buildEnhancedChapNoiCard(theme, chapNoi, index);
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.handshake_outlined,
                size: 64,
                color: colorScheme.primary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Chưa có hồ sơ chấp nhận nào',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Các hồ sơ ứng viên chấp nhận sẽ hiển thị tại đây',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _loadChapNoiData(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Làm mới'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final totalPages = (totalRecords / itemsPerPage).ceil();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Danh sách hồ sơ chấp nhận',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tổng: $totalRecords hồ sơ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          if (totalPages > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Trang $currentPage/$totalPages',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEnhancedChapNoiCard(ThemeData theme, ChapNoiModel chapNoi, int index) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status and date
          Row(
            children: [
              _buildEnhancedStatusChip(chapNoi.idKetQua, theme),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendar,
                    size: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(chapNoi.ngayMuonHs),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Candidate info
          if (chapNoi.tenUngvien != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.user,
                  size: 14,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chapNoi.tenUngvien!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          
          // Company info
          if (chapNoi.tenDoanhNghiep != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.building,
                  size: 14,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chapNoi.tenDoanhNghiep!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          
          // Job position
          if (chapNoi.tenTuyendung != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.briefcase,
                  size: 14,
                  color: colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chapNoi.tenTuyendung!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          
          // Connection type
          if (chapNoi.tenKieuChapNoi != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.handshake,
                  size: 14,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Loại: ${chapNoi.tenKieuChapNoi!}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          
          // Return date if available
          if (chapNoi.ngayTraHs != null) ...[
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.calendarCheck,
                  size: 14,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ngày trả: ${_formatDate(chapNoi.ngayTraHs)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showChapNoiDetails(chapNoi),
                icon: Icon(
                  FontAwesomeIcons.eye,
                  size: 14,
                  color: colorScheme.primary,
                ),
                label: Text(
                  'Chi tiết',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => _deleteChapNoi(chapNoi.id.toString()),
                icon: const Icon(
                  FontAwesomeIcons.trash,
                  size: 14,
                  color: Colors.red,
                ),
                label: const Text(
                  'Xóa',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatusChip(int? status, ThemeData theme) {
    Color chipColor;
    String statusText;
    IconData icon;
    
    switch (status) {
      case 2:
        chipColor = Colors.green;
        statusText = 'Đạt';
        icon = FontAwesomeIcons.circleCheck;
        break;
      case 1:
        chipColor = Colors.red;
        statusText = 'Không đạt';
        icon = FontAwesomeIcons.circleXmark;
        break;
      case 0:
      default:
        chipColor = Colors.orange;
        statusText = 'Chờ xử lý';
        icon = FontAwesomeIcons.clock;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Chưa có';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return 'Chưa có';
    }
  }

  String _getListTitle() {
    switch (selectedStatusFilter) {
      case 0:
        return 'Hồ Sơ Chờ Xử Lý';
      case 1:
        return 'Hồ Sơ Không Đạt';
      case 2:
        return 'Hồ Sơ Đạt';
      default:
        return 'Danh Sách Hồ Sơ Chấp Nhận';
    }
  }

  String _getEmptyStateTitle() {
    switch (selectedStatusFilter) {
      case 0:
        return 'Không có hồ sơ chờ xử lý';
      case 1:
        return 'Không có hồ sơ không đạt';
      case 2:
        return 'Không có hồ sơ đạt';
      default:
        return 'Chưa có hồ sơ chấp nhận nào';
    }
  }

  String _getEmptyStateMessage() {
    switch (selectedStatusFilter) {
      case 0:
        return 'Hiện tại không có hồ sơ nào đang chờ xử lý';
      case 1:
        return 'Hiện tại không có hồ sơ nào bị từ chối';
      case 2:
        return 'Hiện tại không có hồ sơ nào được chấp nhận';
      default:
        return 'Các hồ sơ ứng viên chấp nhận sẽ hiển thị tại đây';
    }
  }

  Widget _buildInfoChip(ThemeData theme, IconData icon, String text) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatusChip(int? status, ThemeData theme) {
    Color chipColor;
    String statusText;
    IconData icon;
    
    switch (status) {
      case 2:
        chipColor = Colors.green;
        statusText = 'Đạt';
        icon = Icons.check_circle;
        break;
      case 1:
        chipColor = Colors.red;
        statusText = 'Không đạt';
        icon = Icons.cancel;
        break;
      case 0:
      default:
        chipColor = Colors.orange;
        statusText = 'Chờ xử lý';
        icon = Icons.schedule;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: chipColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernPagination(ThemeData theme) {
    final totalPages = (totalRecords / itemsPerPage).ceil();
    final colorScheme = theme.colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hiển thị ${((currentPage - 1) * itemsPerPage) + 1} - ${(currentPage * itemsPerPage > totalRecords) ? totalRecords : currentPage * itemsPerPage}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'trong tổng số $totalRecords hồ sơ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          
          // Navigation buttons
          Row(
            children: [
              // First page
              IconButton(
                onPressed: currentPage > 1 ? () => _onPageChanged(1) : null,
                icon: Icon(
                  Icons.first_page_rounded,
                  color: currentPage > 1 
                    ? colorScheme.primary 
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: currentPage > 1 
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              // Previous page
              IconButton(
                onPressed: currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null,
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: currentPage > 1 
                    ? colorScheme.primary 
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: currentPage > 1 
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              // Page indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$currentPage / $totalPages',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Next page
              IconButton(
                onPressed: currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null,
                icon: Icon(
                  Icons.chevron_right_rounded,
                  color: currentPage < totalPages 
                    ? colorScheme.primary 
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: currentPage < totalPages 
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              // Last page
              IconButton(
                onPressed: currentPage < totalPages ? () => _onPageChanged(totalPages) : null,
                icon: Icon(
                  Icons.last_page_rounded,
                  color: currentPage < totalPages 
                    ? colorScheme.primary 
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: currentPage < totalPages 
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChapNoiDetailDialog extends StatelessWidget {
  final ChapNoiModel chapNoi;
  
  const _ChapNoiDetailDialog({required this.chapNoi});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.handshake_outlined,
                      color: colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chi tiết chấp nhận hồ sơ',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          chapNoi.tenUngvien ?? 'N/A',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status chip
                    Row(
                      children: [
                        Text(
                          'Trạng thái:',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildModernStatusChip(chapNoi.idKetQua, theme),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Candidate Information Section
                    _buildSection(
                      theme,
                      'Thông tin ứng viên',
                      Icons.person_outline,
                      [
                        _buildDetailRow(theme, 'Họ và tên:', chapNoi.tenUngvien ?? 'N/A'),
                        _buildDetailRow(theme, 'Số điện thoại:', chapNoi.sdtUngvien ?? 'N/A'),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Job Information Section
                    _buildSection(
                      theme,
                      'Thông tin công việc',
                      Icons.work_outline,
                      [
                        _buildDetailRow(theme, 'Vị trí tuyển dụng:', chapNoi.tenTuyendung ?? 'N/A'),
                        _buildDetailRow(theme, 'Doanh nghiệp:', chapNoi.tenDoanhNghiep ?? 'N/A'),
                        _buildDetailRow(theme, 'Loại chấp nhận:', chapNoi.tenKieuChapNoi ?? 'N/A'),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Timeline Section
                    _buildSection(
                      theme,
                      'Thời gian xử lý',
                      Icons.schedule_outlined,
                      [
                        _buildDetailRow(theme, 'Ngày nộp hồ sơ:', chapNoi.ngayMuonHs),
                        _buildDetailRow(theme, 'Ngày trả hồ sơ:', chapNoi.ngayTraHs ?? 'Chưa trả'),
                        _buildDetailRow(theme, 'Kết quả:', chapNoi.tenKetqua ?? 'Chờ xử lý'),
                      ],
                    ),
                    
                    // Notes section
                    if (chapNoi.ghiChu?.isNotEmpty == true) ...[
                      const SizedBox(height: 20),
                      _buildSection(
                        theme,
                        'Ghi chú',
                        Icons.note_outlined,
                        [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colorScheme.outline.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              chapNoi.ghiChu!,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Đóng',
                      style: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Add any additional action here if needed
                    },
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Xác nhận'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ThemeData theme, String title, IconData icon, List<Widget> children) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(ThemeData theme, String label, String value) {
    final colorScheme = theme.colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatusChip(int? status, ThemeData theme) {
    Color chipColor;
    String statusText;
    IconData icon;
    
    switch (status) {
      case 2:
        chipColor = Colors.green;
        statusText = 'Đạt';
        icon = Icons.check_circle;
        break;
      case 1:
        chipColor = Colors.red;
        statusText = 'Không đạt';
        icon = Icons.cancel;
        break;
      case 0:
      default:
        chipColor = Colors.orange;
        statusText = 'Chờ xử lý';
        icon = Icons.schedule;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: chipColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}