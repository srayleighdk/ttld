import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';
import 'package:ttld/core/utils/launch_utils.dart';
import 'package:ttld/blocs/chapnoi/chapnoi_bloc.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/core/utils/toast_utils.dart';

String getGioiTinhString(int? gioiTinh) {
  if (gioiTinh == null) return '';
  switch (gioiTinh) {
    case -1:
      return 'Nam và Nữ';
    case 0:
      return 'Nữ';
    case 1:
      return 'Nam';
    default:
      return '';
  }
}

String getTrinhDoName(dynamic id) {
  if (id == null) return '';

  // Convert to string if it's an integer
  String stringId = id is int ? id.toString() : id;

  // Assuming you have a list of trinhDo objects fetched and stored
  final trinhDoList = locator<List<TrinhDoHocVan>>();

  final trinhDo = trinhDoList.firstWhere(
    (item) => item.id == stringId,
    orElse: () => TrinhDoHocVan(id: stringId, name: 'Chưa có'),
  );

  return trinhDo.displayName;
}

String getNganhNgheName(dynamic id) {
  if (id == null) return '';

  // Convert to string if it's an integer
  String stringId = id is int ? id.toString() : id;

  List<NganhNgheTD> nganhNgheList = [];
  try {
    nganhNgheList = locator<List<NganhNgheTD>>();
  } catch (e) {
    // If not registered yet, use empty list
    nganhNgheList = [];
  }

  final nganhNghe = nganhNgheList.isNotEmpty
      ? nganhNgheList.firstWhere(
          (item) => item.id == stringId,
          orElse: () => NganhNgheTD(id: stringId, name: 'Chưa có'),
        )
      : NganhNgheTD(id: stringId, name: 'Chưa có');

  return nganhNghe.displayName;
}

class NTDInfoPage extends StatefulWidget {
  final dynamic ntdData;
  const NTDInfoPage({super.key, this.ntdData});

  @override
  State<NTDInfoPage> createState() => _NTDInfoPageState();
}

class _NTDInfoPageState extends State<NTDInfoPage> {
  Ntd? ntd;
  bool isLoading = true;
  bool isApplying = false;
  final repository = locator<NTDRepository>();
  late final ChapNoiBloc _chapNoiBloc;
  late final AuthBloc _authBloc;
  // Track active subscriptions for cleanup
  final List<StreamSubscription> _activeSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _chapNoiBloc = locator<ChapNoiBloc>();
    _authBloc = locator<AuthBloc>();
    _loadNTDData();
  }

  @override
  void dispose() {
    // Don't close _chapNoiBloc here as it's managed by the locator
    // and might be needed by other pages

    // Cancel any active subscriptions
    for (var subscription in _activeSubscriptions) {
      subscription.cancel();
    }
    _activeSubscriptions.clear();

    super.dispose();
  }

  void _loadNTDData() async {
    try {
      int idDoanhNghiep = (widget.ntdData['idDoanhNghiep'] is int)
          ? widget.ntdData['idDoanhNghiep']
          : int.parse(widget.ntdData['idDoanhNghiep']);

      final value = await repository.getNtdById(idDoanhNghiep);
      setState(() {
        ntd = value;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _applyForJob() async {
    final authState = _authBloc.state;
    if (authState is! AuthAuthenticated || authState.userType != 'ntv') {
      ToastUtils.showErrorToast(
        context,
        'Bạn cần đăng nhập với tài khoản ứng viên để ứng tuyển',
      );
      return;
    }

    if (widget.ntdData == null || widget.ntdData['tuyendungId'] == null) {
      ToastUtils.showErrorToast(
        context,
        'Không thể ứng tuyển: Thiếu thông tin tuyển dụng',
      );
      return;
    }

    setState(() {
      isApplying = true;
    });

    try {
      final now = DateTime.now();
      final formattedDate = _formatDateForAPI(now);

      final chapNoi = ChapNoiModel(
        idKieuChapNoi:
            'GGT', // Use proper connection type code (Giấy giới thiệu)
        idUngVien: authState.userId,
        idDoanhNghiep: widget.ntdData['idDoanhNghiep'].toString(),
        idTuyenDung: widget.ntdData['tuyendungId'].toString(),
        ngayMuonHs: formattedDate,
        ngayTraHs: formattedDate, // Send null for optional date
        ghiChu: 'Ứng tuyển từ ứng dụng di động',
        idKetQua: 0, // Pending status
        displayOrder: 0, // Default display order
      );

      // Create a StreamSubscription variable that will be properly cleaned up
      StreamSubscription? streamSubscription;

      // Define the listener function
      void handleState(state) {
        if (state is ChapNoiListLoaded) {
          if (mounted) {
            setState(() {
              isApplying = false;
            });
            ToastUtils.showSuccessToast(
              context,
              'Ứng tuyển thành công! Hồ sơ của bạn đã được gửi đến nhà tuyển dụng.',
            );
          }
          // Use Future.delayed to ensure the bloc operation completes before navigation
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.of(context).pop(); // Go back to job list
            }
          });

          // Cancel subscription after handling the response
          streamSubscription?.cancel();
          streamSubscription = null;
        } else if (state is ChapNoiError) {
          if (mounted) {
            setState(() {
              isApplying = false;
            });
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
      setState(() {
        isApplying = false;
      });
      ToastUtils.showErrorToast(
        context,
        'Có lỗi xảy ra khi ứng tuyển: $e',
      );
    }
  }

  bool _isCurrentUserNTV() {
    final authState = _authBloc.state;
    return authState is AuthAuthenticated && authState.userType == 'ntv';
  }

  String _formatDateForAPI(DateTime dateTime) {
    // Format: "dd-MM-yyyy"
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  Widget _buildApplyButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: isApplying ? null : _applyForJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: isApplying
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Đang ứng tuyển...',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.paperPlane,
                            size: 18,
                            color: theme.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Ứng Tuyển Ngay',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  // Add to favorites functionality
                  ToastUtils.showInfoToast(
                    context,
                    'Tính năng lưu việc làm sẽ được cập nhật sớm',
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.heart,
                  size: 18,
                  color: theme.colorScheme.outline,
                ),
                tooltip: 'Lưu việc làm',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        title: Text(
          'Thông tin tuyển dụng',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: widget.ntdData == null
          ? _buildEmptyState(context)
          : isLoading
              ? _buildLoadingState(context)
              : _buildContent(context),
      bottomNavigationBar: _isCurrentUserNTV() && widget.ntdData != null
          ? _buildApplyButton(context)
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_off_outlined,
            size: 80,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Không có dữ liệu tuyển dụng',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin tuyển dụng không khả dụng',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Đang tải thông tin...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Profile Header
        SliverToBoxAdapter(
          child: _buildJobHeader(context),
        ),

        // Content Sections
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildJobDetailsSection(context),
              const SizedBox(height: 16),
              _buildCompanyInfoSection(context),
              const SizedBox(height: 16),
              _buildContactInfoSection(context),
              const SizedBox(height: 32),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            children: [
              // Company Logo/Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.business_center,
                  size: 50,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 16),

              // Job Title
              Text(
                widget.ntdData['tuyendung'] ?? 'Không có tiêu đề',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Company Name
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ntd?.ntdTen ?? 'Đang tải tên công ty...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Quick Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    context,
                    Icons.people_outline,
                    'Số lượng',
                    '${widget.ntdData['soLuong'] ?? 0}',
                  ),
                  _buildStatItem(
                    context,
                    Icons.calendar_today_outlined,
                    'Ngày đăng',
                    _formatDate(widget.ntdData['ngayDang']),
                  ),
                  _buildStatItem(
                    context,
                    Icons.visibility_outlined,
                    'ID',
                    '${widget.ntdData['tuyendungId'] ?? 0}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.onPrimary,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildJobDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Chi tiết tuyển dụng',
      icon: Icons.work_outline,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.badge_outlined,
          title: 'Vị trí tuyển dụng',
          value: widget.ntdData['tuyendung'],
        ),
        _buildInfoTile(
          context,
          icon: Icons.people_outline,
          title: 'Số lượng cần tuyển',
          value: widget.ntdData['soLuong']?.toString(),
        ),
        _buildInfoTile(
          context,
          icon: Icons.wc_outlined,
          title: 'Yêu cầu giới tính',
          value: getGioiTinhString(widget.ntdData['gioiTinh']),
        ),
        _buildInfoTile(
          context,
          icon: Icons.school_outlined,
          title: 'Trình độ học vấn',
          value: getTrinhDoName(widget.ntdData['trinhDo']),
        ),
        _buildInfoTile(
          context,
          icon: Icons.business_center_outlined,
          title: 'Ngành nghề',
          value: getNganhNgheName(widget.ntdData['nganhNghe']),
        ),
        _buildInfoTile(
          context,
          icon: Icons.description_outlined,
          title: 'Mô tả công việc',
          value: widget.ntdData['moTaCongViec'],
        ),
        _buildInfoTile(
          context,
          icon: Icons.calendar_today_outlined,
          title: 'Ngày đăng tuyển',
          value: widget.ntdData['ngayDang'],
        ),
      ],
    );
  }

  Widget _buildCompanyInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Thông tin công ty',
      icon: Icons.business_outlined,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.business_outlined,
          title: 'Tên công ty',
          value: ntd?.ntdTen,
        ),
        _buildInfoTile(
          context,
          icon: Icons.category_outlined,
          title: 'Lĩnh vực hoạt động',
          value: ntd?.ntdLinhvuchoatdong,
        ),
        _buildInfoTile(
          context,
          icon: Icons.person_outline,
          title: 'Người đại diện',
          value: ntd?.ntdNguoilienhe,
        ),
        _buildInfoTile(
          context,
          icon: Icons.location_on_outlined,
          title: 'Địa chỉ công ty',
          value: ntd?.ntdDiachichitiet,
        ),
        _buildInfoTile(
          context,
          icon: Icons.info_outline,
          title: 'Giới thiệu công ty',
          value: ntd?.ntdGioithieu,
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Thông tin liên hệ',
      icon: Icons.contact_phone_outlined,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.phone_outlined,
          title: 'Số điện thoại',
          value: ntd?.ntdDienthoai,
          isSelectable: true,
          onTap: ntd?.ntdDienthoai != null
              ? () => launchPhoneCall(context, ntd!.ntdDienthoai!)
              : null,
        ),
        _buildInfoTile(
          context,
          icon: Icons.email_outlined,
          title: 'Email liên hệ',
          value: ntd?.ntdEmail,
          isSelectable: true,
          onTap: ntd?.ntdEmail != null
              ? () => _copyToClipboard(
                  context, ntd!.ntdEmail!, 'Email đã được sao chép')
              : null,
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? value,
    bool isSelectable = false,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final displayValue = value?.isNotEmpty == true ? value! : 'Chưa cập nhật';
    final hasValue = value?.isNotEmpty == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 18,
                color: hasValue
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    SelectableText(
                      displayValue,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: hasValue
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.outline,
                        fontWeight:
                            hasValue ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null && hasValue)
                Icon(
                  Icons.touch_app_outlined,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM').format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Chỉnh sửa thông tin'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement edit functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Chia sẻ tin tuyển dụng'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: const Text('Lưu tin tuyển dụng'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement save functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: const Text('Xem danh sách ứng viên'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement view candidates functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
