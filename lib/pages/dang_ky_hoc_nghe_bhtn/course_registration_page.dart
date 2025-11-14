import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/models/bhtn_khoadaotao/bhtn_khoadaotao_model.dart';
import 'package:intl/intl.dart';

/// Course registration page for BHTN training courses
class CourseRegistrationPage extends StatefulWidget {
  static const String routePath = '/ntv_home/dang-ky-hoc-nghe-bhtn/registration';
  
  final BhtnKhoadaotao course;

  const CourseRegistrationPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseRegistrationPage> createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  // Form fields
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitRegistration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // TODO: Integrate with /nghiep-vu/hoso-dtn API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      context.pop(true); // Return true to indicate success
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thất bại: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký khóa học'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Course Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.graduationCap,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.course.name ?? 'Không có tên',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      icon: FontAwesomeIcons.clock,
                      label: 'Thời gian đào tạo',
                      value: widget.course.sothangdaotao != null
                          ? '${widget.course.sothangdaotao!.toInt()} tháng'
                          : 'Chưa xác định',
                      theme: theme,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      icon: FontAwesomeIcons.moneyBill,
                      label: 'Học phí',
                      value: widget.course.hocphi != null
                          ? currencyFormat.format(widget.course.hocphi)
                          : 'Miễn phí',
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Registration Form
            Text(
              'Thông tin đăng ký',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Note field
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Ghi chú (không bắt buộc)',
                hintText: 'Nhập ghi chú nếu có...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(FontAwesomeIcons.noteSticky),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Info notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.circleInfo,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sau khi đăng ký, bạn sẽ nhận được thông báo xác nhận qua email hoặc số điện thoại đã đăng ký.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submitRegistration,
              icon: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(FontAwesomeIcons.paperPlane),
              label: Text(_isSubmitting ? 'Đang xử lý...' : 'Đăng ký ngay'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
