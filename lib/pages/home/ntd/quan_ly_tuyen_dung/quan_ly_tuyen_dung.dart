import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/pages/home/ntd/create_tuyen_dung/create_tuyen_dung.dart';
import 'package:ttld/blocs/tblNhaTuyenDung/ntd_bloc.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

/// Modern recruitment management page with enhanced UI/UX
class QuanLyTuyenDungPage extends StatefulWidget {
  final String? userId;

  const QuanLyTuyenDungPage({super.key, this.userId});

  @override
  State<QuanLyTuyenDungPage> createState() => _QuanLyTuyenDungPageState();
}

class _QuanLyTuyenDungPageState extends State<QuanLyTuyenDungPage>
    with TickerProviderStateMixin {
  // Core dependencies
  late final TuyenDungBloc _tuyenDungBloc;

  // Animation controllers
  late final AnimationController _fadeAnimationController;
  late final AnimationController _slideAnimationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Data state
  List<NTDTuyenDung> _tuyenDungList = [];
  List<NTDTuyenDung> _filteredList = [];

  // UI state
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'all';
  String _selectedSort = 'newest';
  bool _isGridView = false;
  bool _isFilterVisible = false;

  // Pagination state
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 0;
  int _limit = 10;
  bool _isLoadingMore = false;

  // Statistics
  int get _approvedCount =>
      _tuyenDungList.where((item) => item.tdDuyet == true).length;
  int get _pendingCount =>
      _tuyenDungList.where((item) => item.tdDuyet == false).length;
  int get _totalCount => _tuyenDungList.length;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _tuyenDungBloc = locator<TuyenDungBloc>();
    _loadData();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    // Initialize animation controllers
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeAnimationController.forward();
    _slideAnimationController.forward();

    // Search functionality removed
  }

  void _loadData({bool isLoadMore = false}) {
    if (isLoadMore) {
      setState(() => _isLoadingMore = true);
    }

    String? statusFilter = _selectedStatus == 'all' ? null : _selectedStatus;

    _tuyenDungBloc.add(TuyenDungEvent.fetchList(
      widget.userId,
      limit: _limit,
      page: _currentPage,
      search: null, // Search removed
      status: statusFilter,
    ));
  }

  void _refreshList() {
    HapticFeedback.lightImpact();
    _currentPage = 1;
    _loadData();
  }

  void _performSearch() {
    _currentPage = 1;
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    setState(() {
      _filteredList = _tuyenDungList.where((item) {
        // Apply status filter only (search removed)
        final matchesStatus = _selectedStatus == 'all' ||
            (_selectedStatus == 'approved' && item.tdDuyet == true) ||
            (_selectedStatus == 'pending' && item.tdDuyet == false);

        return matchesStatus;
      }).toList();

      // Apply sorting
      _filteredList.sort((a, b) {
        switch (_selectedSort) {
          case 'newest':
            final dateA =
                DateTime.tryParse(a.ngayNhanHoSo ?? '') ?? DateTime(1970);
            final dateB =
                DateTime.tryParse(b.ngayNhanHoSo ?? '') ?? DateTime(1970);
            return dateB.compareTo(dateA);
          case 'oldest':
            final dateA =
                DateTime.tryParse(a.ngayNhanHoSo ?? '') ?? DateTime(1970);
            final dateB =
                DateTime.tryParse(b.ngayNhanHoSo ?? '') ?? DateTime(1970);
            return dateA.compareTo(dateB);
          case 'title':
            return (a.tdTieude ?? '').compareTo(b.tdTieude ?? '');
          default:
            return 0;
        }
      });
    });
  }

  void _loadNextPage() {
    if (_currentPage < _totalPages && !_isLoadingMore) {
      _currentPage++;
      _loadData(isLoadMore: true);
    }
  }

  void _loadPreviousPage() {
    if (_currentPage > 1 && !_isLoadingMore) {
      _currentPage--;
      _loadData();
    }
  }

  void _goToPage(int page) {
    if (page >= 1 &&
        page <= _totalPages &&
        page != _currentPage &&
        !_isLoadingMore) {
      _currentPage = page;
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme),
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.02),
                      theme.colorScheme.surface,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Statistics Dashboard
                      _buildStatisticsDashboard(theme),

                      // Filter Section (moved from app bar)
                      if (_isFilterVisible)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: _buildRightAlignedFilterSection(theme),
                        ),

                      // Content Area
                      Expanded(
                        child: BlocConsumer<TuyenDungBloc, TuyenDungState>(
                          bloc: _tuyenDungBloc,
                          listener: _handleBlocListener,
                          builder: _buildBlocContent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(theme),
    );
  }

  void _handleBlocListener(BuildContext context, TuyenDungState state) {
    final theme = Theme.of(context);
    state.whenOrNull(
      loaded: (list, currentPage, totalPages, totalItems, limit) {
        setState(() {
          _tuyenDungList = list;
          _currentPage = currentPage;
          _totalPages = totalPages;
          _totalItems = totalItems;
          _limit = limit;
          _isLoadingMore = false;
        });
        _applyFiltersAndSort();
      },
      error: (message) {
        setState(() {
          _isLoadingMore = false;
        });
        _showErrorSnackBar(context, message, theme);
      },
    );
  }

  Widget _buildBlocContent(BuildContext context, TuyenDungState state) {
    final theme = Theme.of(context);
    return state.when(
      initial: () => _buildLoadingState(theme),
      loading: () => _buildLoadingState(theme),
      loaded: (list, currentPage, totalPages, totalItems, limit) =>
          _buildContentArea(theme, _filteredList),
      creating: (tuyenDung, isValidated) => _buildLoadingState(theme),
      error: (message) => _buildErrorState(theme, message),
    );
  }

  void _showErrorSnackBar(
      BuildContext context, String message, ThemeData theme) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              FontAwesomeIcons.triangleExclamation,
              color: theme.colorScheme.onError,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'Thử lại',
          textColor: theme.colorScheme.onError,
          onPressed: _refreshList,
        ),
      ),
    );
  }

  /// Clean app bar with filter on the right
  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Row(
        children: [
          // // App icon
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: theme.colorScheme.primary.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Icon(
          //     FontAwesomeIcons.briefcase,
          //     color: theme.colorScheme.primary,
          //     size: 20,
          //   ),
          // ),
          // const SizedBox(width: 12),

          // Title
          Expanded(
            child: Text(
              'Quản lý tuyển dụng',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      actions: [
        // Filter toggle button
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: _isFilterVisible
                ? theme.colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isFilterVisible
                  ? theme.colorScheme.primary.withOpacity(0.3)
                  : theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: IconButton(
            icon: Icon(
              _isFilterVisible
                  ? FontAwesomeIcons.filterCircleXmark
                  : FontAwesomeIcons.filter,
              size: 18,
              color: _isFilterVisible
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              setState(() {
                _isFilterVisible = !_isFilterVisible;
              });
            },
            tooltip: _isFilterVisible ? 'Ẩn bộ lọc' : 'Hiện bộ lọc',
          ),
        ),

        // View mode toggle
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: IconButton(
            icon: Icon(
              _isGridView
                  ? FontAwesomeIcons.list
                  : FontAwesomeIcons.gripVertical,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            tooltip: _isGridView ? 'Chế độ danh sách' : 'Chế độ lưới',
          ),
        ),

        // Refresh button
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.secondary.withOpacity(0.3),
            ),
          ),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowsRotate,
              size: 18,
              color: theme.colorScheme.secondary,
            ),
            onPressed: _refreshList,
            tooltip: 'Làm mới',
          ),
        ),
      ],
    );
  }

  /// Right-aligned filter section with responsive layout
  Widget _buildRightAlignedFilterSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.05),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Check if we need vertical layout
          final needsVerticalLayout = constraints.maxWidth <= 600;

          if (needsVerticalLayout) {
            return _buildVerticalFilterLayout(theme);
          } else {
            return _buildHorizontalFilterLayout(theme);
          }
        },
      ),
    );
  }

  /// Horizontal layout for larger screens
  Widget _buildHorizontalFilterLayout(ThemeData theme) {
    return Row(
      children: [
        // Filter label
        Icon(
          FontAwesomeIcons.filter,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          'Bộ lọc:',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),

        const Spacer(),

        // Status filter
        Flexible(
          child: SizedBox(
            width: 110,
            child: _buildCompactDropdown(
              theme,
              'Trạng thái',
              _selectedStatus,
              [
                {'value': 'all', 'label': 'Tất cả'},
                {'value': 'approved', 'label': 'Đã duyệt'},
                {'value': 'pending', 'label': 'Chờ duyệt'},
              ],
              (value) {
                setState(() => _selectedStatus = value!);
                _performSearch();
              },
              FontAwesomeIcons.checkCircle,
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Sort filter
        Flexible(
          child: SizedBox(
            width: 110,
            child: _buildCompactDropdown(
              theme,
              'Sắp xếp',
              _selectedSort,
              [
                {'value': 'newest', 'label': 'Mới nhất'},
                {'value': 'oldest', 'label': 'Cũ nhất'},
                {'value': 'title', 'label': 'Theo tiêu đề'},
              ],
              (value) {
                setState(() => _selectedSort = value!);
                _performSearch();
              },
              FontAwesomeIcons.arrowUpShortWide,
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Results count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.listCheck,
                size: 10,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                '${_filteredList.length}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Vertical layout for smaller screens
  Widget _buildVerticalFilterLayout(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter header
        Container(
          height: 24,
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.filter,
                size: 12,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                'Bộ lọc',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              // Results count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_filteredList.length}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // Filter controls
        Container(
          height: 32,
          child: Row(
            children: [
              // Status filter
              Expanded(
                child: _buildCompactDropdown(
                  theme,
                  'Trạng thái',
                  _selectedStatus,
                  [
                    {'value': 'all', 'label': 'Tất cả'},
                    {'value': 'approved', 'label': 'Đã duyệt'},
                    {'value': 'pending', 'label': 'Chờ duyệt'},
                  ],
                  (value) {
                    setState(() => _selectedStatus = value!);
                    _performSearch();
                  },
                  FontAwesomeIcons.checkCircle,
                ),
              ),

              const SizedBox(width: 6),

              // Sort filter
              Expanded(
                child: _buildCompactDropdown(
                  theme,
                  'Sắp xếp',
                  _selectedSort,
                  [
                    {'value': 'newest', 'label': 'Mới nhất'},
                    {'value': 'oldest', 'label': 'Cũ nhất'},
                    {'value': 'title', 'label': 'Theo tiêu đề'},
                  ],
                  (value) {
                    setState(() => _selectedSort = value!);
                    _performSearch();
                  },
                  FontAwesomeIcons.arrowUpShortWide,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Compact dropdown for app bar filters
  Widget _buildCompactDropdown(
    ThemeData theme,
    String label,
    String value,
    List<Map<String, String>> items,
    void Function(String?) onChanged,
    IconData icon,
  ) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: Icon(
            FontAwesomeIcons.chevronDown,
            size: 10,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontSize: 12,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item['value'],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item['label']!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  /// Enhanced statistics dashboard with animations
  Widget _buildStatisticsDashboard(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Main statistics row
          Row(
            children: [
              Expanded(
                child: _buildAnimatedStatCard(
                  theme,
                  'Tổng số bài đăng',
                  _totalItems.toString(),
                  FontAwesomeIcons.briefcase,
                  [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withOpacity(0.7)
                  ],
                  0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnimatedStatCard(
                  theme,
                  'Đã duyệt',
                  _approvedCount.toString(),
                  FontAwesomeIcons.circleCheck,
                  [Colors.green, Colors.green.withOpacity(0.7)],
                  100,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnimatedStatCard(
                  theme,
                  'Chờ duyệt',
                  _pendingCount.toString(),
                  FontAwesomeIcons.clock,
                  [Colors.orange, Colors.orange.withOpacity(0.7)],
                  200,
                ),
              ),
            ],
          ),

          // Progress indicator for approval rate
          if (_totalCount > 0) ...[
            const SizedBox(height: 16),
            _buildApprovalProgressIndicator(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildApprovalProgressIndicator(ThemeData theme) {
    final approvalRate = _totalCount > 0 ? _approvedCount / _totalCount : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tỷ lệ duyệt',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                '${(approvalRate * 100).toStringAsFixed(1)}%',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: approvalRate,
              backgroundColor: theme.colorScheme.outline.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                approvalRate >= 0.8
                    ? Colors.green
                    : approvalRate >= 0.5
                        ? Colors.orange
                        : Colors.red,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatCard(
    ThemeData theme,
    String title,
    String value,
    IconData icon,
    List<Color> gradientColors,
    int delayMs,
  ) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delayMs),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, animationValue, child) {
        return Transform.scale(
          scale: animationValue,
          child: _buildStatCard(theme, title, value, icon, gradientColors),
        );
      },
    );
  }

  Widget _buildStatCard(ThemeData theme, String title, String value,
      IconData icon, List<Color> gradientColors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Content Area
  Widget _buildContentArea(ThemeData theme, List<NTDTuyenDung> list) {
    return Column(
      children: [
        // Results Header
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.briefcase,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Hiển thị $_totalItems kết quả (Trang $_currentPage/$_totalPages)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: _isGridView
              ? _buildGridView(theme, list)
              : _buildListView(theme, list),
        ),

        // Pagination
        if (_totalPages > 1) _buildPaginationControls(theme),
      ],
    );
  }

  // Grid View
  Widget _buildGridView(ThemeData theme, List<NTDTuyenDung> list) {
    if (list.isEmpty) {
      return _buildEmptyState(theme);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildJobCard(theme, list[index]);
        },
      ),
    );
  }

  // List View (Cards)
  Widget _buildListView(ThemeData theme, List<NTDTuyenDung> list) {
    if (list.isEmpty) {
      return _buildEmptyState(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildJobListCard(theme, list[index], index);
      },
    );
  }

  /// Enhanced job list card for list view
  Widget _buildJobListCard(ThemeData theme, NTDTuyenDung tuyenDung, int index) {
    final tdDuyet = tuyenDung.tdDuyet ?? false;
    final tdTieude = tuyenDung.tdTieude ?? 'Chưa có tiêu đề';
    final tenNganhnghe = tuyenDung.tenNganhnghe ?? 'Chưa có ngành nghề';
    final ngayNhanHoSo = tuyenDung.ngayNhanHoSo ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showEditDialog(context, tuyenDung),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: tdDuyet
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: tdDuyet ? Colors.green : Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tdDuyet ? 'Đã duyệt' : 'Chờ duyệt',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: tdDuyet ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Date
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.calendar,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatDate(ngayNhanHoSo),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Job title
                Text(
                  tdTieude,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Industry
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.briefcase,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tenNganhnghe,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showEditDialog(context, tuyenDung),
                        icon:
                            const Icon(FontAwesomeIcons.penToSquare, size: 16),
                        label: const Text('Chỉnh sửa'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showDeleteDialog(context, tuyenDung),
                        icon: const Icon(FontAwesomeIcons.trash, size: 16),
                        label: const Text('Xóa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                          foregroundColor: theme.colorScheme.onError,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FontAwesomeIcons.briefcase,
              size: 48,
              color: theme.colorScheme.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Chưa có bài đăng tuyển dụng nào',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hãy tạo bài đăng tuyển dụng đầu tiên của bạn',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _navigateToCreatePage,
            icon: const Icon(FontAwesomeIcons.plus, size: 16),
            label: const Text('Tạo bài đăng mới'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Loading State
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
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // Error State
  Widget _buildErrorState(ThemeData theme, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FontAwesomeIcons.triangleExclamation,
              size: 48,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Có lỗi xảy ra',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshList,
            icon: const Icon(FontAwesomeIcons.arrowsRotate, size: 16),
            label: const Text('Thử lại'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pagination Controls
  Widget _buildPaginationControls(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          ElevatedButton.icon(
            onPressed:
                _currentPage > 1 && !_isLoadingMore ? _loadPreviousPage : null,
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              size: 14,
              color: _currentPage > 1 && !_isLoadingMore
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            label: Text(
              'Trước',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _currentPage > 1 && !_isLoadingMore
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage > 1 && !_isLoadingMore
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              foregroundColor: _currentPage > 1 && !_isLoadingMore
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
            ),
          ),

          // Page info and quick navigation
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_totalPages <= 5) ...[
                  // Show all pages if total pages <= 5
                  for (int i = 1; i <= _totalPages; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: _buildPageButton(i, theme),
                    ),
                ] else ...[
                  // Show condensed pagination for more than 5 pages
                  _buildPageButton(1, theme),
                  if (_currentPage > 3) ...[
                    const SizedBox(width: 4),
                    Text('...', style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 4),
                  ],
                  for (int i = math.max(2, _currentPage - 1);
                      i <= math.min(_totalPages - 1, _currentPage + 1);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: _buildPageButton(i, theme),
                    ),
                  if (_currentPage < _totalPages - 2) ...[
                    const SizedBox(width: 4),
                    Text('...', style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 4),
                  ],
                  if (_totalPages > 1) _buildPageButton(_totalPages, theme),
                ],
              ],
            ),
          ),

          // Next button
          ElevatedButton.icon(
            onPressed: _currentPage < _totalPages && !_isLoadingMore
                ? _loadNextPage
                : null,
            icon: _isLoadingMore
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )
                : Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 14,
                    color: _currentPage < _totalPages && !_isLoadingMore
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
            label: Text(
              'Tiếp',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _currentPage < _totalPages && !_isLoadingMore
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage < _totalPages && !_isLoadingMore
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              foregroundColor: _currentPage < _totalPages && !_isLoadingMore
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(int page, ThemeData theme) {
    final isCurrentPage = page == _currentPage;
    return GestureDetector(
      onTap: !_isLoadingMore ? () => _goToPage(page) : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isCurrentPage ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isCurrentPage
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            page.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: isCurrentPage
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // Floating Action Button
  Widget _buildFloatingActionButton(ThemeData theme) {
    return FloatingActionButton.extended(
      onPressed: _navigateToCreatePage,
      icon: const Icon(FontAwesomeIcons.plus, size: 18),
      label: const Text('Tạo bài đăng'),
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  // Job Card for Grid View
  Widget _buildJobCard(ThemeData theme, NTDTuyenDung tuyenDung) {
    final tdDuyet = tuyenDung.tdDuyet ?? false;
    final tdTieude = tuyenDung.tdTieude ?? 'Chưa có tiêu đề';
    final tenNganhnghe = tuyenDung.tenNganhnghe ?? 'Chưa có ngành nghề';
    final ngayNhanHoSo = tuyenDung.ngayNhanHoSo ?? '';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showEditDialog(context, tuyenDung),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.primary.withOpacity(0.02),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: tdDuyet
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: tdDuyet ? Colors.green : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tdDuyet ? 'Đã duyệt' : 'Chờ duyệt',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: tdDuyet ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditDialog(context, tuyenDung);
                      } else if (value == 'delete') {
                        _showDeleteDialog(context, tuyenDung);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.penToSquare, size: 16),
                            const SizedBox(width: 8),
                            Text('Chỉnh sửa'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.trash,
                                size: 16, color: theme.colorScheme.error),
                            const SizedBox(width: 8),
                            Text('Xóa',
                                style:
                                    TextStyle(color: theme.colorScheme.error)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Job Title
              Text(
                tdTieude,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Industry
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.briefcase,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tenNganhnghe,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Date
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendar,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _formatDate(ngayNhanHoSo),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showEditDialog(context, tuyenDung),
                      icon: Icon(FontAwesomeIcons.penToSquare, size: 14),
                      label: Text('Sửa'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        side: BorderSide(color: theme.colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _showDeleteDialog(context, tuyenDung),
                    icon: Icon(FontAwesomeIcons.trash, size: 14),
                    style: IconButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                      backgroundColor: theme.colorScheme.error.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigate to Create Page
  void _navigateToCreatePage() async {
    final theme = Theme.of(context);
    final ntdBloc = locator<NTDBloc>();

    // Check if we have the NTD data loaded
    if (ntdBloc.state is NTDLoadedById) {
      final ntd = (ntdBloc.state as NTDLoadedById).ntd;

      if (ntd.idDoanhNghiep == null || ntd.idDoanhNghiep!.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không tìm thấy thông tin doanh nghiệp của bạn.'),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }

      if (!mounted) return;
      // Navigate to create page
      context.push(
        CreateTuyenDungPage.routePath,
        extra: {
          'ntd': ntd,
          'isEdit': false,
        },
      );
    } else {
      // Show error if NTD data is not loaded
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Vui lòng tải lại trang để lấy thông tin doanh nghiệp.'),
          backgroundColor: theme.colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _showEditDialog(BuildContext context, NTDTuyenDung tuyenDung) {
    final theme = Theme.of(context);
    final ntdBloc = locator<NTDBloc>();

    // Check for NTDLoadedById state first (same as _navigateToCreatePage)
    if (ntdBloc.state is NTDLoadedById) {
      final ntd = (ntdBloc.state as NTDLoadedById).ntd;

      if (ntd.idDoanhNghiep == null || ntd.idDoanhNghiep!.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Không tìm thấy thông tin doanh nghiệp của bạn.'),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }

      if (!mounted) return;
      // Navigate to edit page
      context.push(
        CreateTuyenDungPage.routePath,
        extra: {
          'ntd': ntd,
          'tuyenDung': tuyenDung,
          'isEdit': true,
        },
      );
    }
    // Fallback to NTDLoaded state if available
    else if (ntdBloc.state is NTDLoaded) {
      final ntdList = (ntdBloc.state as NTDLoaded).ntdList;
      final ntd = ntdList.firstWhere(
        (ntd) => ntd.idDoanhNghiep == widget.userId,
        orElse: () => Ntd(),
      );

      if (ntd.idDoanhNghiep == null || ntd.idDoanhNghiep!.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Vui lòng đăng nhập lại để chỉnh sửa bài tuyển dụng.'),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }

      if (!mounted) return;
      context.push(
        CreateTuyenDungPage.routePath,
        extra: {
          'ntd': ntd,
          'tuyenDung': tuyenDung,
          'isEdit': true,
        },
      );
    }
    // No valid state found
    else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Vui lòng tải lại trang để lấy thông tin doanh nghiệp.'),
          backgroundColor: theme.colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          action: SnackBarAction(
            label: 'Tải lại',
            textColor: theme.colorScheme.onError,
            onPressed: _refreshList,
          ),
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context, NTDTuyenDung tuyenDung) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Xác nhận xóa',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn xóa bài đăng tuyển dụng này?',
          style: theme.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteTuyenDung(tuyenDung.idTuyenDung!);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _deleteTuyenDung(String id) {
    _tuyenDungBloc.add(TuyenDungEvent.delete(id, widget.userId));
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'Chưa có ngày';
    }
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      print('Error formatting date: $e');
      return 'Chưa có ngày';
    }
  }

  // Widget _buildPaginationButton(
  //   ThemeData theme,
  //   String label,
  //   IconData icon,
  //   bool isEnabled,
  //   VoidCallback? onPressed, {
  //   bool isNext = false,
  // }) {
  //   return ElevatedButton.icon(
  //     onPressed: isEnabled ? onPressed : null,
  //     icon: _isLoadingMore && isNext
  //         ? SizedBox(
  //             width: 14,
  //             height: 14,
  //             child: CircularProgressIndicator(
  //               strokeWidth: 2,
  //               color: theme.colorScheme.onPrimary,
  //             ),
  //           )
  //         : Icon(icon, size: 14),
  //     label: Text(label),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor:
  //           isEnabled ? theme.colorScheme.primary : theme.colorScheme.surface,
  //       foregroundColor: isEnabled
  //           ? theme.colorScheme.onPrimary
  //           : theme.colorScheme.onSurface.withOpacity(0.5),
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         side: BorderSide(
  //           color: theme.colorScheme.outline.withOpacity(0.3),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // List<Widget> _buildPageIndicators(ThemeData theme) {
  //   List<Widget> indicators = [];
  //
  //   if (_totalPages <= 5) {
  //     // Show all pages if total pages <= 5
  //     for (int i = 1; i <= _totalPages; i++) {
  //       indicators.add(
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 2),
  //           child: _buildPageIndicator(i, theme),
  //         ),
  //       );
  //     }
  //   } else {
  //     // Show condensed pagination for more than 5 pages
  //     indicators.add(_buildPageIndicator(1, theme));
  //
  //     if (_currentPage > 3) {
  //       indicators.addAll([
  //         const SizedBox(width: 4),
  //         Text('...', style: theme.textTheme.bodyMedium),
  //         const SizedBox(width: 4),
  //       ]);
  //     }
  //
  //     for (int i = math.max(2, _currentPage - 1);
  //         i <= math.min(_totalPages - 1, _currentPage + 1);
  //         i++) {
  //       indicators.add(
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 2),
  //           child: _buildPageIndicator(i, theme),
  //         ),
  //       );
  //     }
  //
  //     if (_currentPage < _totalPages - 2) {
  //       indicators.addAll([
  //         const SizedBox(width: 4),
  //         Text('...', style: theme.textTheme.bodyMedium),
  //         const SizedBox(width: 4),
  //       ]);
  //     }
  //
  //     if (_totalPages > 1) {
  //       indicators.add(_buildPageIndicator(_totalPages, theme));
  //     }
  //   }
  //
  //   return indicators;
  // }

  // Widget _buildPageIndicator(int page, ThemeData theme) {
  //   final isCurrentPage = page == _currentPage;
  //   return GestureDetector(
  //     onTap: !_isLoadingMore ? () => _goToPage(page) : null,
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
  //       width: 32,
  //       height: 32,
  //       decoration: BoxDecoration(
  //         color: isCurrentPage ? theme.colorScheme.primary : Colors.transparent,
  //         borderRadius: BorderRadius.circular(6),
  //         border: Border.all(
  //           color: isCurrentPage
  //               ? theme.colorScheme.primary
  //               : theme.colorScheme.outline.withOpacity(0.3),
  //         ),
  //       ),
  //       child: Center(
  //         child: Text(
  //           page.toString(),
  //           style: theme.textTheme.bodySmall?.copyWith(
  //             color: isCurrentPage
  //                 ? theme.colorScheme.onPrimary
  //                 : theme.colorScheme.onSurface,
  //             fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w400,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
