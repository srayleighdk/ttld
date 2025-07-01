import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/pages/home/ntd/ntv_info_page.dart';
import 'package:ttld/widgets/common/custom_app_bar.dart';

class TimUngVienPage extends StatefulWidget {
  static const routePath = '/ntd_home/tim_ung_vien';
  final String? idDn;
  
  const TimUngVienPage({
    super.key,
    this.idDn,
  });

  @override
  State<TimUngVienPage> createState() => _TimUngVienPageState();
}

class _TimUngVienPageState extends State<TimUngVienPage> {
  late NTVBloc _ntvBloc;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  String _selectedFilter = 'all';
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _initializeBloc();
  }

  void _initializeBloc() {
    _ntvBloc = locator<NTVBloc>();
    _loadCandidates();
  }

  void _loadCandidates() {
    if (!_ntvBloc.isClosed) {
      if (widget.idDn != null && widget.idDn!.isNotEmpty) {
        // Load candidates for specific company
        _ntvBloc.add(LoadTblHoSoUngViensByIdDn(widget.idDn!));
      } else {
        // Load all candidates
        _ntvBloc.add(LoadTblHoSoUngViens());
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch() {
    _loadCandidates();
  }

  void _clearFilters() {
    setState(() {
      _selectedFilter = 'all';
      _searchController.clear();
      _searchQuery = '';
    });
    _performSearch();
  }

  List<TblHoSoUngVienModel> _filterCandidates(List<TblHoSoUngVienModel> candidates) {
    var filtered = candidates;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((candidate) {
        final name = candidate.uvHoten?.toLowerCase() ?? '';
        final industry = candidate.uvnvNganhnghe?.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || industry.contains(query);
      }).toList();
    }

    // Apply gender filter
    if (_selectedFilter != 'all') {
      if (_selectedFilter == 'male') {
        filtered = filtered.where((candidate) => candidate.uvGioitinh == 1).toList();
      } else if (_selectedFilter == 'female') {
        filtered = filtered.where((candidate) => candidate.uvGioitinh == 0).toList();
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Tìm Ứng Viên',
        elevation: 0,
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
      body: Column(
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
                hintText: 'Tìm kiếm ứng viên theo tên, ngành nghề...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
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
          
          // Filter chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(theme, 'all', 'Tất cả'),
              _buildFilterChip(theme, 'male', 'Nam'),
              _buildFilterChip(theme, 'female', 'Nữ'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(ThemeData theme, String value, String label) {
    final isSelected = _selectedFilter == value;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
      checkmarkColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected 
            ? theme.colorScheme.primary 
            : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected 
            ? theme.colorScheme.primary 
            : theme.colorScheme.outline.withOpacity(0.3),
      ),
    );
  }

  Widget _buildResultsSection(ThemeData theme) {
    return BlocBuilder<NTVBloc, NTVState>(
      bloc: _ntvBloc,
      builder: (context, state) {
        if (state is NTVLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Đang tìm kiếm ứng viên...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is NTVError) {
          return _buildErrorState(theme, state.message);
        }

        if (state is NTVLoaded) {
          final candidates = _filterCandidates(state.tblHoSoUngViens);

          if (candidates.isEmpty) {
            return _buildEmptyState(theme);
          }

          return Column(
            children: [
              // Results header
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
                      FontAwesomeIcons.users,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Tìm thấy ${candidates.length} ứng viên',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Candidates list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    final candidate = candidates[index];
                    return _buildCandidateCard(candidate, theme);
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCandidateCard(TblHoSoUngVienModel candidate, ThemeData theme) {
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
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NTVInfoPage(ntdData: candidate),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Candidate name and gender
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar placeholder
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: candidate.uvGioitinh == 1 
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.pink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        candidate.uvGioitinh == 1 
                            ? FontAwesomeIcons.mars
                            : FontAwesomeIcons.venus,
                        size: 20,
                        color: candidate.uvGioitinh == 1 ? Colors.blue : Colors.pink,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidate.uvHoten ?? 'Chưa có tên',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            candidate.uvnvNganhnghe ?? 'Chưa có ngành nghề',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // View details button
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NTVInfoPage(ntdData: candidate),
                          ),
                        );
                      },
                      icon: Icon(
                        FontAwesomeIcons.eye,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Candidate details
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildCandidateTag(
                      candidate.uvGioitinh == 1 
                          ? FontAwesomeIcons.mars
                          : FontAwesomeIcons.venus,
                      candidate.uvGioitinh == 1 ? 'Nam' : 'Nữ',
                      candidate.uvGioitinh == 1 ? Colors.blue : Colors.pink,
                      theme,
                    ),
                    if (_calculateAge(candidate.uvNgaysinh) != null)
                      _buildCandidateTag(
                        FontAwesomeIcons.calendar,
                        '${_calculateAge(candidate.uvNgaysinh)} tuổi',
                        theme.colorScheme.secondary,
                        theme,
                      ),
                    if (candidate.uvnvNganhnghe != null)
                      _buildCandidateTag(
                        FontAwesomeIcons.briefcase,
                        candidate.uvnvNganhnghe!,
                        theme.colorScheme.tertiary,
                        theme,
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NTVInfoPage(ntdData: candidate),
                            ),
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.eye,
                          size: 14,
                          color: theme.colorScheme.primary,
                        ),
                        label: Text(
                          'Xem hồ sơ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Add contact functionality
                        },
                        icon: Icon(
                          FontAwesomeIcons.envelope,
                          size: 14,
                          color: theme.colorScheme.onPrimary,
                        ),
                        label: Text(
                          'Liên hệ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
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

  Widget _buildCandidateTag(IconData icon, String text, Color color, ThemeData theme) {
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


  Widget _buildEmptyState(ThemeData theme) {
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
              FontAwesomeIcons.userSlash,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy ứng viên',
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

  Widget _buildErrorState(ThemeData theme, String message) {
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
              'Có lỗi xảy ra',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCandidates,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  int? _calculateAge(String? birthDate) {
    if (birthDate == null || birthDate.isEmpty) return null;
    try {
      DateTime birth;
      if (birthDate.contains('/')) {
        final parts = birthDate.split('/');
        if (parts.length == 3) {
          birth = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else {
          return null;
        }
      } else {
        birth = DateTime.parse(birthDate);
      }

      final today = DateTime.now();
      int age = today.year - birth.year;
      if (today.month < birth.month ||
          (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return null;
    }
  }
}