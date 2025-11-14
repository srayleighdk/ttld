import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:ttld/core/utils/launch_utils.dart';
import 'package:ttld/core/utils/toast_utils.dart';

class LienHePage extends StatelessWidget {
  const LienHePage({super.key, this.region = Region.lamDong});

  final Region region;

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ToastUtils.showSuccessToast(context, 'Đã sao chép vào clipboard');
  }

  Future<void> _openZalo(String zaloId) async {
    final Uri zaloUri = Uri.parse('zalo://zalo.me/$zaloId');
    final Uri webUri = Uri.parse('https://zalo.me/$zaloId');

    try {
      final bool launched = await launchUrl(
        zaloUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // If zalo:// scheme failed, try the web URL
        await launchUrl(
          webUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // If zalo:// scheme throws error, fall back to web URL
      await launchUrl(
        webUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 117.0), // Added bottom padding for navigation bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Modern Header
                _buildModernHeader(theme),
                const SizedBox(height: 24),
                
                // Quick Contact Actions
                _buildQuickContactActions(theme, context),
                const SizedBox(height: 24),
                
                // Main Contact Information
                _buildModernContactCard(context),
                const SizedBox(height: 24),
                
                // Additional Information
                _buildAdditionalInfo(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Liên Hệ Với Chúng Tôi',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Trung tâm dịch vụ việc làm',
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.mapLocationDot,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _getRegionDisplayName(),
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

  Widget _buildQuickContactActions(ThemeData theme, BuildContext context) {
    final contactInfo = _getContactInfo();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
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
                FontAwesomeIcons.bolt,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Liên Hệ Nhanh',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Gọi Điện',
                  FontAwesomeIcons.phone,
                  Colors.green,
                  () => launchPhoneCall(context, contactInfo['phone']!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Email',
                  FontAwesomeIcons.envelope,
                  Colors.blue,
                  () => _copyToClipboard(context, contactInfo['email']!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Zalo',
                  FontAwesomeIcons.commentDots,
                  const Color(0xFF0068FF),
                  () => _openZalo(contactInfo['zalo']!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  theme,
                  'Website',
                  FontAwesomeIcons.globe,
                  Colors.purple,
                  () => _openWebsite(contactInfo['website']!),
                ),
              ),
            ],
          ),
        ],
      ),
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
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
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernContactCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final contactInfo = _getContactInfo();
    final branches = _getBranches();
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Office Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FontAwesomeIcons.building,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contactInfo['name']!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Văn phòng chính',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Contact Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildContactItem(
                  theme,
                  FontAwesomeIcons.locationDot,
                  'Địa chỉ',
                  contactInfo['address']!,
                  Colors.red,
                  null,
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  theme,
                  FontAwesomeIcons.phone,
                  'Điện thoại',
                  contactInfo['phone']!,
                  Colors.green,
                  () => launchPhoneCall(context, contactInfo['phone']!),
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  theme,
                  FontAwesomeIcons.envelope,
                  'Email',
                  contactInfo['email']!,
                  Colors.blue,
                  () => _copyToClipboard(context, contactInfo['email']!),
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  theme,
                  FontAwesomeIcons.globe,
                  'Website',
                  contactInfo['website']!,
                  Colors.purple,
                  () => _openWebsite(contactInfo['website']!),
                ),
                const SizedBox(height: 16),
                _buildZaloContactItem(
                  theme,
                  contactInfo['zaloName']!,
                  contactInfo['zalo']!,
                ),
              ],
            ),
          ),
          
          // Branches
          if (branches.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.sitemap,
                    color: colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Chi nhánh & Văn phòng',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            ...branches.map((branch) => _buildBranchCard(theme, context, branch)),
          ],
        ],
      ),
    );
  }

  Widget _buildContactItem(
    ThemeData theme,
    IconData icon,
    String label,
    String value,
    Color color,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: onTap != null ? color : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                FontAwesomeIcons.externalLink,
                color: color,
                size: 12,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildZaloContactItem(ThemeData theme, String displayName, String zaloId) {
    const zaloColor = Color(0xFF0068FF);
    
    return InkWell(
      onTap: () => _openZalo(zaloId),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: zaloColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: zaloColor.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: zaloColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: SvgPicture.asset(
                'assets/zalo_icon/zalo-icon-svg.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(zaloColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zalo',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    displayName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: zaloColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              FontAwesomeIcons.externalLink,
              color: zaloColor,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard(ThemeData theme, BuildContext context, Map<String, String> branch) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
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
                FontAwesomeIcons.mapPin,
                color: colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  branch['name']!,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (branch['address'] != null) ...[
            _buildBranchContactItem(
              theme,
              FontAwesomeIcons.locationDot,
              branch['address']!,
              Colors.red,
              null,
            ),
            const SizedBox(height: 8),
          ],
          if (branch['phone'] != null) ...[
            _buildBranchContactItem(
              theme,
              FontAwesomeIcons.phone,
              branch['phone']!,
              Colors.green,
              () => launchPhoneCall(context, branch['phone']!),
            ),
            const SizedBox(height: 8),
          ],
          if (branch['email'] != null) ...[
            _buildBranchContactItem(
              theme,
              FontAwesomeIcons.envelope,
              branch['email']!,
              Colors.blue,
              () => _copyToClipboard(context, branch['email']!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBranchContactItem(
    ThemeData theme,
    IconData icon,
    String value,
    Color color,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: onTap != null ? color : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onTap != null)
              Icon(
                FontAwesomeIcons.externalLink,
                color: color,
                size: 10,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
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
                FontAwesomeIcons.circleInfo,
                color: colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Thông Tin Hỗ Trợ',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            theme,
            FontAwesomeIcons.clock,
            'Giờ làm việc',
            'Thứ 2 - Thứ 6: 7:30 - 11:30, 13:30 - 17:00',
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            theme,
            FontAwesomeIcons.userTie,
            'Dịch vụ hỗ trợ',
            'Tư vấn việc làm, Đăng ký tuyển dụng, Hỗ trợ ứng viên',
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            theme,
            FontAwesomeIcons.language,
            'Ngôn ngữ hỗ trợ',
            'Tiếng Việt, English',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    ThemeData theme,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: color,
            size: 14,
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
              const SizedBox(height: 2),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getRegionDisplayName() {
    switch (region) {
      case Region.lamDong:
        return 'Tỉnh Lâm Đồng';
      case Region.giaLai:
      default:
        return 'Tỉnh Gia Lai';
    }
  }

  Map<String, String> _getContactInfo() {
    switch (region) {
      case Region.lamDong:
        return {
          'name': 'TRUNG TÂM DỊCH VỤ VIỆC LÀM LÂM ĐỒNG',
          'address': 'Số 172 Nguyễn Văn Trỗi, phường 2, thành phố Đà Lạt, tỉnh Lâm Đồng',
          'phone': '02633822360',
          'email': 'vieclamlamdong@gmail.com',
          'website': 'http://vieclamlamdong.vn',
          'zalo': '0918007245',
          'zaloName': 'TRUNG TÂM DVVL LÂM ĐỒNG',
        };
      case Region.giaLai:
      default:
        return {
          'name': 'Trung tâm dịch vụ việc làm tỉnh Gia Lai',
          'address': 'Gia Lai',
          'phone': '0260000000',
          'email': 'info@vieclamgialai.gov.vn',
          'website': 'http://vieclamgialai.gov.vn/',
          'zalo': '',
          'zaloName': 'Trung tâm DVVL tỉnh Gia Lai',
        };
    }
  }

  List<Map<String, String>> _getBranches() {
    switch (region) {
      case Region.lamDong:
        return [
          {
            'name': 'Văn phòng Bảo Lộc',
            'address': 'Số 147 Phan Bội Châu, phường 1, Tp. Bảo Lộc, tỉnh Lâm Đồng',
            'phone': '02633822360',
            'email': 'vieclamlamdong@gmail.com',
          },
        ];
      case Region.giaLai:
      default:
        return [];
    }
  }
}
