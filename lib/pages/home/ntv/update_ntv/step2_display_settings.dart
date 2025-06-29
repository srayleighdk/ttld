import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ttld/widgets/field/custom_checkbox.dart';

class Step2DisplaySettings extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool? uvhtEmail;
  final bool? uvhtAddress;
  final bool? uvhtTelephone;
  final bool? newletterSubscription;
  final bool? jobsletterSubscription;
  final File? selectedFile;
  final File? selectedImage;
  final Function(bool?) onUvhtEmailChanged;
  final Function(bool?) onUvhtAddressChanged;
  final Function(bool?) onUvhtTelephoneChanged;
  final Function(bool?) onNewletterSubscriptionChanged;
  final Function(bool?) onJobsletterSubscriptionChanged;
  final Function() onPickFile;
  final Function() onPickImage;

  const Step2DisplaySettings({
    Key? key,
    required this.formKey,
    required this.uvhtEmail,
    required this.uvhtAddress,
    required this.uvhtTelephone,
    required this.newletterSubscription,
    required this.jobsletterSubscription,
    required this.selectedFile,
    required this.selectedImage,
    required this.onUvhtEmailChanged,
    required this.onUvhtAddressChanged,
    required this.onUvhtTelephoneChanged,
    required this.onNewletterSubscriptionChanged,
    required this.onJobsletterSubscriptionChanged,
    required this.onPickFile,
    required this.onPickImage,
  }) : super(key: key);

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
      ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(theme, title),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormSection(
            theme,
            'Hiển thị thông tin',
            [
              CustomCheckbox(
                label: 'Email',
                value: uvhtEmail ?? false,
                onChanged: onUvhtEmailChanged,
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Địa chỉ',
                value: uvhtAddress ?? false,
                onChanged: onUvhtAddressChanged,
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Số điện thoại',
                value: uvhtTelephone ?? false,
                onChanged: onUvhtTelephoneChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Đăng ký nhận thông báo',
            [
              CustomCheckbox(
                label: 'Đăng ký nhận bản tin',
                value: newletterSubscription ?? false,
                onChanged: onNewletterSubscriptionChanged,
              ),
              const SizedBox(height: 12),
              CustomCheckbox(
                label: 'Đăng ký nhận thông báo việc làm',
                value: jobsletterSubscription ?? false,
                onChanged: onJobsletterSubscriptionChanged,
              ),
            ],
          ),
          _buildFormSection(
            theme,
            'Tài liệu đính kèm',
            [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CV của bạn',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedFile != null
                                ? selectedFile!.path.split('/').last
                                : 'Chưa chọn file',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: onPickFile,
                          icon: Icon(Icons.upload_file, size: 16),
                          label: Text('Chọn File CV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
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
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ảnh đại diện',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (selectedImage != null)
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              size: 32,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: onPickImage,
                                icon: Icon(Icons.photo_library, size: 16),
                                label: Text('Chọn Ảnh'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              if (selectedImage != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  selectedImage!.path.split('/').last,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
