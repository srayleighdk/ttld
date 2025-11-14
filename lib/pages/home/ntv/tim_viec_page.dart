import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/blocs/tuyendung/tuyendung_bloc.dart';
import 'package:ttld/blocs/kinh_nghiem_lam_viec/kinh_nghiem_lam_viec_bloc.dart';
import 'package:ttld/blocs/nganh_nghe/nganh_nghe_bloc.dart';
import 'package:ttld/blocs/tinh/tinh_bloc.dart';
import 'package:ttld/blocs/tinh/tinh_event.dart';
import 'package:ttld/blocs/tinh/tinh_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';
import 'package:ttld/repositories/tinh/tinh_repository.dart';
import 'package:ttld/pages/home/ntd/ntd_tuyendung_info_page.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/blocs/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/core/utils/toast_utils.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/repositories/tblHoSoUngVien/ntv_repository.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/home/ntv/update_ntv/update_ntv_page.dart';
import 'package:go_router/go_router.dart';

class TimViecPage extends StatefulWidget {
  const TimViecPage({super.key});

  static const String routePath = '/tim-viec';

  @override
  State<TimViecPage> createState() => _TimViecPageState();
}

class _TimViecPageState extends State<TimViecPage> {
  late final TuyenDungBloc _tuyenDungBloc;
  late final KinhNghiemLamViecBloc _kinhNghiemBloc;
  late final NganhNgheBloc _nganhNgheBloc;
  late final TinhBloc _tinhBloc;
  late final AuthBloc _authBloc;
  late final ChapNoiBloc _chapNoiBloc;
  late final NTVBloc _ntvBloc;
  // Track active subscriptions for cleanup
  final List<StreamSubscription> _activeSubscriptions = [];

  // User profile data
  TblHoSoUngVienModel? _userProfile;
  bool _isCheckingProfile = true;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Current user info
  String? _currentUserId;
  String? _currentUserType;

  // Filter states
  String? _selectedKinhNghiem;
  String? _selectedNganhNghe;
  String? _selectedTinh;
  String? _selectedSalaryRange;
  bool _isRemoteWork = false;

  // Data maps for display
  Map<String, String> _kinhNghiemMap = {};
  Map<String, String> _nganhNgheMap = {};
  Map<String, String> _tinhMap = {};

  // Filter visibility
  bool _showFilters = false;

  // Pagination variables
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 0;
  int _limit = 10;
  bool _isLoadingMore = false;

  // Salary ranges
  final List<Map<String, String>> _salaryRanges = [
    {'value': 'all', 'label': 'Tất cả mức lương'},
    {'value': '0-5', 'label': 'Dưới 5 triệu'},
    {'value': '5-10', 'label': '5 - 10 triệu'},
    {'value': '10-15', 'label': '10 - 15 triệu'},
    {'value': '15-20', 'label': '15 - 20 triệu'},
    {'value': '20-30', 'label': '20 - 30 triệu'},
    {'value': '30+', 'label': 'Trên 30 triệu'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
    _loadInitialData();
  }

  void _initializeBlocs() {
    _tuyenDungBloc = TuyenDungBloc(locator<TuyenDungRepository>());
    _kinhNghiemBloc =
        KinhNghiemLamViecBloc(locator<KinhNghiemLamViecRepository>());
    _nganhNgheBloc =
        NganhNgheBloc(nganhNgheRepository: locator<NganhNgheRepository>());
    _tinhBloc = TinhBloc(tinhRepository: locator<TinhRepository>());
    _authBloc = locator<AuthBloc>();
    _chapNoiBloc = locator<ChapNoiBloc>();
    _ntvBloc = NTVBloc(locator<NTVRepository>());

    // Get current user info
    _getCurrentUserInfo();

    // Check user profile
    _checkUserProfile();
  }

  void _getCurrentUserInfo() {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      _currentUserId = authState.userId;
      _currentUserType = authState.userType;

      // Debug logging
      debugPrint(
          'TimViecPage: Current user - ID: $_currentUserId, Type: $_currentUserType');
    } else {
      debugPrint('TimViecPage: User not authenticated');
    }
  }

  void _checkUserProfile() {
    if (_currentUserId != null && _currentUserType == 'NTV') {
      // Load user profile by uvId
      _ntvBloc.add(LoadTblHoSoUngVienByUvId(_currentUserId!));

      // Listen to NTV bloc state changes
      _activeSubscriptions.add(
        _ntvBloc.stream.listen((state) {
          if (state is NTVLoadedById) {
            setState(() {
              _userProfile = state.tblHoSoUngVien;
              _isCheckingProfile = false;
            });

            // Check if user has completed their profile
            if (_userProfile == null ||
                _userProfile!.uvnvNganhngheId == null ||
                _userProfile!.uvnvNganhngheId == 0) {
              _showProfileIncompleteDialog();
            }
          } else if (state is NTVError) {
            setState(() {
              _isCheckingProfile = false;
            });
            // If no profile found, show dialog
            _showProfileIncompleteDialog();
          }
        }),
      );
    } else {
      setState(() {
        _isCheckingProfile = false;
      });
    }
  }

  void _showProfileIncompleteDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông tin chưa đầy đủ'),
            content: const Text(
              'Bạn cần cập nhật thông tin cá nhân và ngành nghề mong muốn trước khi có thể tìm việc làm.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/home'); // Navigate back to home
                },
                child: const Text('Về trang chủ'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to update profile page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateNTVPage(hoSoUngVien: _userProfile),
                    ),
                  );
                },
                child: const Text('Cập nhật thông tin'),
              ),
            ],
          );
        },
      );
    });
  }

  void _loadInitialData() {
    _currentPage = 1; // Reset to first page
    _loadTuyenDungData();
    _kinhNghiemBloc.add(FetchKinhNghiemLamViecList());
    _nganhNgheBloc.add(LoadNganhNghes());
    _tinhBloc.add(LoadTinhs());
  }

  void _loadTuyenDungData({bool isLoadMore = false}) {
    if (isLoadMore) {
      setState(() => _isLoadingMore = true);
    }

    final searchQuery = _searchController.text.trim();

    // Pass the current user ID (idUV) for NTV users
    if (_currentUserType == 'ntv' && _currentUserId != null) {
      _tuyenDungBloc.add(FetchTuyenDungList(
        null,
        idUv: _currentUserId,
        limit: _limit,
        page: _currentPage,
        search: searchQuery.isNotEmpty ? searchQuery : null,
      ));
      print(
          'TimViecPage: FetchTuyenDungList with idUV: $_currentUserId, page: $_currentPage');
    } else {
      // Fallback for other user types or when user ID is not available
      _tuyenDungBloc.add(FetchTuyenDungList(
        null,
        limit: _limit,
        page: _currentPage,
        search: searchQuery.isNotEmpty ? searchQuery : null,
      ));
    }
  }

  @override
  void dispose() {
    _tuyenDungBloc.close();
    _kinhNghiemBloc.close();
    _nganhNgheBloc.close();
    _tinhBloc.close();
    _ntvBloc.close();
    // Don't close _chapNoiBloc here as it's managed by the locator
    // and might be needed by other pages

    // Cancel any active subscriptions
    for (var subscription in _activeSubscriptions) {
      subscription.cancel();
    }
    _activeSubscriptions.clear();

    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch() {
    _currentPage = 1; // Reset to first page when searching
    _loadTuyenDungData();
  }

  void _clearFilters() {
    setState(() {
      _selectedKinhNghiem = null;
      _selectedNganhNghe = null;
      _selectedTinh = null;
      _selectedSalaryRange = null;
      _isRemoteWork = false;
      _searchController.clear();
    });
    // Refresh data after clearing filters
    _performSearch();
  }

  void _applyFilters() {
    setState(() {
      // Trigger rebuild with new filters
    });
    // Optionally refresh data when filters change
    _performSearch();
  }

  void _loadNextPage() {
    if (_currentPage < _totalPages && !_isLoadingMore) {
      _currentPage++;
      _loadTuyenDungData(isLoadMore: true);
    }
  }

  void _loadPreviousPage() {
    if (_currentPage > 1 && !_isLoadingMore) {
      _currentPage--;
      _loadTuyenDungData();
    }
  }

  void _goToPage(int page) {
    if (page >= 1 &&
        page <= _totalPages &&
        page != _currentPage &&
        !_isLoadingMore) {
      _currentPage = page;
      _loadTuyenDungData();
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa có';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateForAPI(DateTime dateTime) {
    // Backend expects DD-MM-YYYY format for moment.js parsing
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  void _quickApplyForJob(NTDTuyenDung job) async {
    if (_currentUserType != 'ntv' || _currentUserId == null) {
      ToastUtils.showErrorToast(
        context,
        'Bạn cần đăng nhập với tài khoản ứng viên để ứng tuyển',
      );
      return;
    }

    if (job.idTuyenDung == null || job.idDoanhNghiep == null) {
      ToastUtils.showErrorToast(
        context,
        'Không thể ứng tuyển: Thiếu thông tin tuyển dụng',
      );
      return;
    }

    try {
      // Format date to match API expectation
      final now = DateTime.now().toUtc();
      final formattedDate = _formatDateForAPI(now);
      
      // Add 7 days for ngayTraHs
      final returnDate = now.add(const Duration(days: 7));
      final formattedReturnDate = _formatDateForAPI(returnDate);

      // Debug logging to identify the issue
      debugPrint('ChapNoi Debug Info:');
      debugPrint('idKieuChapNoi: GGT');
      debugPrint('idUngVien: $_currentUserId');
      debugPrint('idDoanhNghiep: ${job.idDoanhNghiep}');
      debugPrint('idTuyenDung: ${job.idTuyenDung}');
      debugPrint('ngayMuonHs: $formattedDate');
      debugPrint('ngayTraHs: $formattedReturnDate');

      // Validate required fields before creating ChapNoiModel
      if (_currentUserId == null || _currentUserId!.isEmpty) {
        ToastUtils.showErrorToast(
          context,
          'Lỗi: Không tìm thấy ID người dùng',
        );
        return;
      }

      if (job.idDoanhNghiep == null) {
        ToastUtils.showErrorToast(
          context, 
          'Lỗi: Không tìm thấy ID doanh nghiệp',
        );
        return;
      }

      if (job.idTuyenDung == null || job.idTuyenDung!.isEmpty) {
        ToastUtils.showErrorToast(
          context,
          'Lỗi: Không tìm thấy ID tuyển dụng',
        );
        return;
      }

      final chapNoi = ChapNoiModel(
        idKieuChapNoi: 'GGT', // Use proper connection type code (Giấy giới thiệu)
        idUngVien: _currentUserId!,
        idDoanhNghiep: job.idDoanhNghiep.toString(),
        idTuyenDung: job.idTuyenDung!,
        ngayMuonHs: formattedDate,
        ngayTraHs: formattedReturnDate, // Add 7 days from ngayMuonHs
        ghiChu: 'Ứng tuyển nhanh từ danh sách việc làm',
        idKetQua: 0, // 0 = Thất bại (or initial status)
        displayOrder: 0, // Default display order
      );

      // Debug: Print the ChapNoiModel JSON
      debugPrint('ChapNoi JSON: ${chapNoi.toJson()}');

      // Create a StreamSubscription variable that will be properly cleaned up
      StreamSubscription? streamSubscription;

      // Define the listener function
      void handleState(state) {
        if (state is ChapNoiListLoaded) {
          if (mounted) {
            ToastUtils.showSuccessToast(
              context,
              'Ứng tuyển thành công! Hồ sơ của bạn đã được gửi đến nhà tuyển dụng.',
            );
          }

          // Cancel subscription after handling the response
          streamSubscription?.cancel();
          streamSubscription = null;
        } else if (state is ChapNoiError) {
          if (mounted) {
            // Enhanced error logging and display
            debugPrint('ChapNoi Error: ${state.message}');
            ToastUtils.showErrorToast(
              context,
              'Ứng tuyển thất bại: ${state.message}',
            );
          }

          // Cancel subscription after handling the error
          streamSubscription?.cancel();
          streamSubscription = null;
        }
      }

      // Assign the subscription and track it
      streamSubscription = _chapNoiBloc.stream.listen(handleState);
      if (streamSubscription != null) {
        _activeSubscriptions.add(streamSubscription!);
      }

      // Dispatch the event after setting up the listener
      _chapNoiBloc.add(ChapNoiCreate(chapNoi));
    } catch (e) {
      ToastUtils.showErrorToast(
        context,
        'Có lỗi xảy ra khi ứng tuyển: $e',
      );
    }
  }

  List<NTDTuyenDung> _filterJobs(List<NTDTuyenDung> jobs) {
    List<NTDTuyenDung> filteredJobs = List.from(jobs);

    // Search by keyword
    final searchQuery = _searchController.text.trim().toLowerCase();
    if (searchQuery.isNotEmpty) {
      filteredJobs = filteredJobs.where((job) {
        final title = (job.tdTieude ?? '').toLowerCase();
        final description = (job.tdMotacongviec ?? '').toLowerCase();
        final location = (job.noiLamviec ?? '').toLowerCase();
        return title.contains(searchQuery) ||
            description.contains(searchQuery) ||
            location.contains(searchQuery);
      }).toList();
    }

    // Filter by experience
    if (_selectedKinhNghiem != null) {
      filteredJobs = filteredJobs.where((job) {
        return job.idKinhnghiem == _selectedKinhNghiem;
      }).toList();
    }

    // Filter by industry (ngành nghề)
    if (_selectedNganhNghe != null) {
      filteredJobs = filteredJobs.where((job) {
        // tdNganhnghe is an int, so we compare with the selected ID
        return job.tdNganhnghe?.toString() == _selectedNganhNghe;
      }).toList();
    }

    // Filter by location
    if (_selectedTinh != null) {
      filteredJobs = filteredJobs.where((job) {
        return job.noiLamviec?.contains(_tinhMap[_selectedTinh] ?? '') == true;
      }).toList();
    }

    // Filter by remote work (this would need to be implemented based on your data structure)
    if (_isRemoteWork) {
      filteredJobs = filteredJobs.where((job) {
        final location = (job.noiLamviec ?? '').toLowerCase();
        return location.contains('từ xa') ||
            location.contains('remote') ||
            location.contains('online');
      }).toList();
    }

    return filteredJobs;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Show loading indicator while checking profile for NTV users
    if (_isCheckingProfile && _currentUserType == 'NTV') {
      return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const CustomAppBar(
          title: 'Tìm Việc Làm',
          useGradient: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Đang kiểm tra thông tin cá nhân...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Tìm Việc Làm',
        useGradient: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => _showFilters = !_showFilters),
            icon: Icon(
              _showFilters ? FontAwesomeIcons.xmark : FontAwesomeIcons.sliders,
              size: 20,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TuyenDungBloc, TuyenDungState>(
            bloc: _tuyenDungBloc,
            listener: (context, state) {
              if (state is TuyenDungLoaded) {
                setState(() {
                  _currentPage = state.currentPage;
                  _totalPages = state.totalPages;
                  _totalItems = state.totalItems;
                  _limit = state.limit;
                  _isLoadingMore = false;
                });
              } else if (state is TuyenDungError) {
                setState(() {
                  _isLoadingMore = false;
                });
              }
            },
          ),
          BlocListener<KinhNghiemLamViecBloc, KinhNghiemLamViecState>(
            bloc: _kinhNghiemBloc,
            listener: (context, state) {
              if (state is KinhNghiemLamViecLoaded) {
                setState(() {
                  _kinhNghiemMap = {
                    for (var item in state.kinhNghiemList)
                      item.id.toString(): item.displayName
                  };
                });
              }
            },
          ),
          BlocListener<NganhNgheBloc, NganhNgheState>(
            bloc: _nganhNgheBloc,
            listener: (context, state) {
              if (state is NganhNgheLoaded) {
                setState(() {
                  _nganhNgheMap = {
                    for (var item in state.nganhNghes)
                      item.id.toString(): item.displayName
                  };
                });
              }
            },
          ),
          BlocListener<TinhBloc, TinhState>(
            bloc: _tinhBloc,
            listener: (context, state) {
              if (state is TinhLoaded) {
                setState(() {
                  _tinhMap = {
                    for (var item in state.tinhs)
                      item.id.toString(): item.displayName
                  };
                });
              }
            },
          ),
        ],
        child: Column(
          children: [
            // Search Bar
            _buildSearchSection(theme),

            // Filters (collapsible)
            if (_showFilters) _buildFiltersSection(theme),

            // Results
            Expanded(
              child: _buildResultsSection(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 20,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm công việc, công ty...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _performSearch,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(15),
            blurRadius: 10,
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
              Text(
                'Bộ lọc tìm kiếm',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  'Xóa tất cả',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Filter dropdowns in a grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3,
            children: [
              _buildFilterDropdown(
                'Kinh nghiệm',
                _selectedKinhNghiem,
                _kinhNghiemMap,
                (value) {
                  setState(() => _selectedKinhNghiem = value);
                  _applyFilters();
                },
                theme,
              ),
              _buildFilterDropdown(
                'Ngành nghề',
                _selectedNganhNghe,
                _nganhNgheMap,
                (value) {
                  setState(() => _selectedNganhNghe = value);
                  _applyFilters();
                },
                theme,
              ),
              _buildFilterDropdown(
                'Tỉnh/Thành phố',
                _selectedTinh,
                _tinhMap,
                (value) {
                  setState(() => _selectedTinh = value);
                  _applyFilters();
                },
                theme,
              ),
              _buildSalaryDropdown(theme),
            ],
          ),

          const SizedBox(height: 12),

          // Remote work toggle
          Row(
            children: [
              Switch(
                value: _isRemoteWork,
                onChanged: (value) {
                  setState(() => _isRemoteWork = value);
                  _applyFilters();
                },
                activeColor: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Làm việc từ xa',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String? selectedValue,
    Map<String, String> options,
    Function(String?) onChanged,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          value: selectedValue,
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(
                'Tất cả $label',
                style: theme.textTheme.bodySmall,
              ),
            ),
            ...options.entries.map((entry) => DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSalaryDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            'Mức lương',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          value: _selectedSalaryRange,
          items: _salaryRanges
              .map((range) => DropdownMenuItem<String>(
                    value: range['value'],
                    child: Text(
                      range['label']!,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _selectedSalaryRange = value);
            _applyFilters();
          },
        ),
      ),
    );
  }

  Widget _buildResultsSection(ThemeData theme) {
    return BlocBuilder<TuyenDungBloc, TuyenDungState>(
      bloc: _tuyenDungBloc,
      builder: (context, state) {
        if (state is TuyenDungLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Đang tìm kiếm việc làm...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is TuyenDungError) {
          // Parse error message to provide better user feedback
          String userFriendlyMessage = 'Không thể tải danh sách việc làm';
          String technicalDetails = state.message;
          
          if (state.message.contains('500')) {
            userFriendlyMessage = 'Máy chủ đang gặp sự cố';
            technicalDetails = 'Vui lòng thử lại sau ít phút hoặc liên hệ quản trị viên nếu lỗi vẫn tiếp diễn.';
          } else if (state.message.contains('Failed to fetch') || state.message.contains('Network')) {
            userFriendlyMessage = 'Không có kết nối mạng';
            technicalDetails = 'Vui lòng kiểm tra kết nối internet của bạn.';
          } else if (state.message.contains('timeout')) {
            userFriendlyMessage = 'Kết nối quá chậm';
            technicalDetails = 'Vui lòng thử lại hoặc kiểm tra kết nối mạng.';
          }
          
          return Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userFriendlyMessage,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    technicalDetails,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(FontAwesomeIcons.arrowLeft, size: 14),
                        label: Text('Quay lại'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _performSearch,
                        icon: Icon(FontAwesomeIcons.arrowsRotate, size: 14),
                        label: Text('Thử lại'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        if (state is TuyenDungLoaded) {
          final jobs = _filterJobs(state.tuyenDungList);

          if (jobs.isEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withAlpha(15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 48,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không tìm thấy việc làm',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hãy thử thay đổi từ khóa tìm kiếm hoặc bộ lọc',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              // Results header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      'Tìm thấy $_totalItems việc làm (Trang $_currentPage/$_totalPages)',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Job list
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return _buildJobCard(job, theme);
                        },
                      ),
                    ),
                    // Pagination controls
                    if (_totalPages > 1) _buildPaginationControls(theme),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildJobCard(NTDTuyenDung job, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _currentUserType == 'ntv'
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NTDInfoPage(
                        ntdData: {
                          'tuyendungId': job.idTuyenDung,
                          'tuyendung': job.tdTieude ?? '',
                          'soLuong': job.tdSoluong.toString(),
                          'gioiTinh': job.tdYeuCauGioiTinh,
                          'trinhDo': job.tdYeuCauHocVan ?? '',
                          'nganhNghe': job.tdNganhnghe ?? '',
                          'moTaCongViec': job.tdMotacongviec ?? '',
                          'ngayNhanHoSo': job.ngayNhanHoSo ?? '',
                          'tenNTD': job.tdTieude ?? '',
                          'address': job.noiLamviec ?? '',
                          'idDoanhNghiep': job.idDoanhNghiep.toString(),
                          'ngayDang': job.createdDate != null ? _formatDate(job.createdDate!) : '',
                          'mucLuong': job.mucLuong ?? '',
                          'idKinhnghiem': job.idKinhnghiem ?? '',
                          'tdNoinophoso': job.tdNoinophoso ?? '',
                          'tdHosobaogom': job.tdHosobaogom ?? '',
                          'tdGhichu': job.tdGhichu ?? '',
                        },
                      ),
                    ),
                  );
                },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job title and company
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company logo placeholder
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        FontAwesomeIcons.building,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.tdTieude ?? 'Chưa có tiêu đề',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.tenDoanhNghiep ?? "",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bookmark button
                    IconButton(
                      onPressed: () {
                        // Add bookmark functionality
                      },
                      icon: Icon(
                        FontAwesomeIcons.bookmark,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Job details
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (job.noiLamviec != null)
                      _buildJobTag(
                        FontAwesomeIcons.locationDot,
                        job.noiLamviec!,
                        theme.colorScheme.secondary,
                        theme,
                      ),
                    if (job.tdSoluong != null)
                      _buildJobTag(
                        FontAwesomeIcons.users,
                        '${job.tdSoluong} vị trí',
                        theme.colorScheme.tertiary,
                        theme,
                      ),
                    _buildJobTag(
                      FontAwesomeIcons.clock,
                      _formatDate(job.modifiredDate),
                      theme.colorScheme.outline,
                      theme,
                    ),
                  ],
                ),

                if (job.tdMotacongviec != null &&
                    job.tdMotacongviec!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    job.tdMotacongviec!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Action buttons for NTV users
                if (_currentUserType == 'ntv') ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _quickApplyForJob(job),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                size: 14,
                                color: theme.colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Chắp nối việc làm',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NTDInfoPage(
                                ntdData: {
                                  'tuyendungId': job.idTuyenDung,
                                  'tuyendung': job.tdTieude ?? '',
                                  'soLuong': job.tdSoluong.toString(),
                                  'gioiTinh': job.tdYeuCauGioiTinh,
                                  'trinhDo': job.tdYeuCauHocVan ?? '',
                                  'nganhNghe': job.tdNganhnghe ?? '',
                                  'moTaCongViec': job.tdMotacongviec ?? '',
                                  'ngayNhanHoSo': job.ngayNhanHoSo ?? '',
                                  'tenNTD': job.tdTieude ?? '',
                                  'address': job.noiLamviec ?? '',
                                  'idDoanhNghiep': job.idDoanhNghiep.toString(),
                                  'ngayDang': job.createdDate != null ? _formatDate(job.createdDate!) : '',
                                  'mucLuong': job.mucLuong ?? '',
                                  'idKinhnghiem': job.idKinhnghiem ?? '',
                                  'tdNoinophoso': job.tdNoinophoso ?? '',
                                  'tdHosobaogom': job.tdHosobaogom ?? '',
                                  'tdGhichu': job.tdGhichu ?? '',
                                },
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Chi tiết',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobTag(
      IconData icon, String text, Color color, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(15),
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
}
