import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class NTVInfoPage extends StatelessWidget {
  final TblHoSoUngVienModel? ntdData;
  const NTVInfoPage({super.key, this.ntdData});

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
          'Thông tin ứng viên',
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
      body:
          ntdData == null ? _buildEmptyState(context) : _buildContent(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 80,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Không có dữ liệu ứng viên',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thông tin ứng viên không khả dụng',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
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
          child: _buildProfileHeader(context),
        ),

        // Content Sections
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildJobPreferencesSection(context),
              const SizedBox(height: 16),
              _buildPersonalInfoSection(context),
              const SizedBox(height: 16),
              _buildContactInfoSection(context),
              const SizedBox(height: 16),
              _buildAdditionalInfoSection(context),
              const SizedBox(height: 32),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
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
              // Avatar
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
                child: ntdData?.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          ntdData!.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(theme),
                        ),
                      )
                    : _buildDefaultAvatar(theme),
              ),

              const SizedBox(height: 16),

              // Name
              Text(
                ntdData?.uvHoten ?? 'Không có tên',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Job Title
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ntdData?.cvMongMuon ?? 'Chưa xác định vị trí',
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
                    Icons.work_history_outlined,
                    'Kinh nghiệm',
                    '${ntdData?.uvcmKinhnghiem ?? 0} năm',
                  ),
                  _buildStatItem(
                    context,
                    Icons.visibility_outlined,
                    'Lượt xem',
                    '${ntdData?.uvSolanxem ?? 0}',
                  ),
                  _buildStatItem(
                    context,
                    Icons.chat_bubble_outline,
                    'Phỏng vấn',
                    '${ntdData?.interview ?? 0}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(ThemeData theme) {
    return Icon(
      Icons.person,
      size: 50,
      color: theme.colorScheme.primary,
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

  Widget _buildJobPreferencesSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Mong muốn công việc',
      icon: Icons.work_outline,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.business_center_outlined,
          title: 'Ngành nghề',
          value: ntdData?.uvnvNganhnghe,
        ),
        _buildInfoTile(
          context,
          icon: Icons.school_outlined,
          title: 'Trình độ học vấn',
          value: ntdData?.uvcmTrinhdo,
        ),
        _buildInfoTile(
          context,
          icon: Icons.location_on_outlined,
          title: 'Nơi làm việc mong muốn',
          value: ntdData?.uvnvNoilamviec,
        ),
        _buildInfoTile(
          context,
          icon: Icons.schedule_outlined,
          title: 'Thời gian làm việc',
          value: ntdData?.uvnvThoigian,
        ),
        _buildInfoTile(
          context,
          icon: Icons.attach_money_outlined,
          title: 'Mức lương mong muốn',
          value: ntdData?.uvnvTienluong != null
              ? '${NumberFormat('#,###').format(ntdData!.uvnvTienluong)} VNĐ'
              : null,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Thông tin cá nhân',
      icon: Icons.person_outline,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.cake_outlined,
          title: 'Ngày sinh',
          value: ntdData?.uvNgaysinh != null
              ? DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(ntdData!.uvNgaysinh!))
              : null,
        ),
        _buildInfoTile(
          context,
          icon: Icons.wc_outlined,
          title: 'Giới tính',
          value: _getGenderText(ntdData?.uvGioitinh),
        ),
        _buildInfoTile(
          context,
          icon: Icons.credit_card_outlined,
          title: 'CMND/CCCD',
          value: ntdData?.uvSoCmnd,
        ),
        _buildInfoTile(
          context,
          icon: Icons.date_range_outlined,
          title: 'Ngày cấp',
          value: ntdData?.uvNgaycap,
        ),
        _buildInfoTile(
          context,
          icon: Icons.location_city_outlined,
          title: 'Nơi cấp',
          value: ntdData?.uvNoicap,
        ),
        _buildInfoTile(
          context,
          icon: Icons.groups_outlined,
          title: 'Dân tộc',
          value: ntdData?.tenDanToc,
        ),
        _buildInfoTile(
          context,
          icon: Icons.favorite_outline,
          title: 'Tình trạng hôn nhân',
          value: ntdData?.uvHonnhan,
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
          icon: Icons.email_outlined,
          title: 'Email',
          value: ntdData?.uvEmail,
          isSelectable: true,
        ),
        _buildInfoTile(
          context,
          icon: Icons.phone_outlined,
          title: 'Số điện thoại',
          value: ntdData?.uvDienthoai,
          isSelectable: true,
        ),
        _buildInfoTile(
          context,
          icon: Icons.home_outlined,
          title: 'Địa chỉ chi tiết',
          value: ntdData?.uvDiachichitiet,
        ),
        _buildInfoTile(
          context,
          icon: Icons.location_on_outlined,
          title: 'Địa chỉ liên hệ',
          value: ntdData?.diachilienhe,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection(BuildContext context) {
    return _buildSection(
      context,
      title: 'Thông tin bổ sung',
      icon: Icons.info_outline,
      children: [
        _buildInfoTile(
          context,
          icon: Icons.computer_outlined,
          title: 'Trình độ tin học',
          value: ntdData?.uvcmTrinhdotinhoc,
        ),
        _buildInfoTile(
          context,
          icon: Icons.language_outlined,
          title: 'Trình độ ngoại ngữ',
          value: ntdData?.uvcmTrinhdongoaingu,
        ),
        _buildInfoTile(
          context,
          icon: Icons.star_outline,
          title: 'Kỹ năng',
          value: ntdData?.uvcmKynang,
        ),
        _buildInfoTile(
          context,
          icon: Icons.note_outlined,
          title: 'Ghi chú',
          value: ntdData?.uvGhichu,
        ),
        _buildInfoTile(
          context,
          icon: Icons.calendar_today_outlined,
          title: 'Ngày duyệt hồ sơ',
          value: ntdData?.ngayduyet != null
              ? DateFormat('dd/MM/yyyy HH:mm').format(ntdData!.ngayduyet!)
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
  }) {
    final theme = Theme.of(context);
    final displayValue = value?.isNotEmpty == true ? value! : 'Chưa cập nhật';
    final hasValue = value?.isNotEmpty == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                    fontWeight: hasValue ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getGenderText(int? gender) {
    switch (gender) {
      case 1:
        return 'Nam';
      case 0:
        return 'Nữ';
      default:
        return null;
    }
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
              leading: const Icon(Icons.download_outlined),
              title: const Text('Tải xuống CV'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement download CV functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Chia sẻ thông tin'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: const Text('Lưu ứng viên'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement save candidate functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.message_outlined),
              title: const Text('Gửi tin nhắn'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement messaging functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
