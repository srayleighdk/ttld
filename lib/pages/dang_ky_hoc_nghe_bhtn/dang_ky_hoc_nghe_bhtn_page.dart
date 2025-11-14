import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Đăng ký học nghề BHTN (Vocational Training with Unemployment Insurance)
/// This page shows available training courses that users can register for
/// Uses API: /nghiep-vu/hoso-dtn
class DangKyHocNgheBHTNPage extends StatefulWidget {
  static const String routePath = '/ntv_home/dang-ky-hoc-nghe-bhtn';

  const DangKyHocNgheBHTNPage({super.key});

  @override
  State<DangKyHocNgheBHTNPage> createState() => _DangKyHocNgheBHTNPageState();
}

class _DangKyHocNgheBHTNPageState extends State<DangKyHocNgheBHTNPage> {
  // TODO: Implement API service to fetch courses from tblDmNgheDaoTao and bhtnKhoadaotao
  final List<Map<String, dynamic>> _courses = [
    {
      'name': 'Sửa chữa máy nông nghiệp',
      'status': 'Hệ đào tạo:Sơ cấp',
    },
    {
      'name': 'May công nghiệp',
      'status': 'Hệ đào tạo:Sơ cấp',
    },
    {
      'name': 'Chăm nuôi heo',
      'status': 'Hệ đào tạo:Nghề hạn',
    },
    {
      'name': 'Bếp chuyên nghiệp',
      'status': 'Hệ đào tạo:Nghề hạn',
    },
    {
      'name': 'Phơ chế thức uống',
      'status': 'Hệ đào tạo:Nghề hạn',
    },
    {
      'name': 'Kỹ thuật làm Bánh Âu',
      'status': 'Hệ đào tạo:Nghề hạn',
    },
    {
      'name': 'Lái xe hạng B2',
      'status': 'Hệ đào tạo:Sơ cấp',
    },
    {
      'name': 'Lái xe hạng D',
      'status': 'Hệ đào tạo:Sơ cấp',
    },
    {
      'name': 'Nâng hạng CPI X',
      'status': 'Hệ đào tạo:Sơ cấp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Đăng ký học nghề BHTN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.graduationCap,
                      color: theme.colorScheme.onPrimary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DANH SÁCH NGÀNH NGHỀ ĐÀO TẠO',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Chọn khóa đào tạo phù hợp với bạn',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Course list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return _buildCourseCard(context, course, theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    Map<String, dynamic> course,
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to course detail or registration form
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đăng ký khóa: ${course['name']}'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  FontAwesomeIcons.bookOpen,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Course info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['name'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        course['status'],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                FontAwesomeIcons.chevronRight,
                color: theme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
