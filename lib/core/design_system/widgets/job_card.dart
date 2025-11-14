import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/core/design_system/app_colors.dart';
import 'package:ttld/core/design_system/app_radius.dart';
import 'package:ttld/core/design_system/app_shadows.dart';
import 'package:ttld/core/design_system/app_spacing.dart';
import 'package:ttld/core/design_system/app_typography.dart';

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String? companyName;
  final String? location;
  final String? salary;
  final int? quantity;
  final String? experience;
  final String? postedDate;
  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final String? companyLogoUrl;

  const JobCard({
    super.key,
    required this.jobTitle,
    this.companyName,
    this.location,
    this.salary,
    this.quantity,
    this.experience,
    this.postedDate,
    this.onTap,
    this.onApply,
    this.companyLogoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.card,
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Company logo + title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company logo/avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: companyLogoUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                companyLogoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildDefaultLogo(),
                              ),
                            )
                          : _buildDefaultLogo(),
                    ),
                    SizedBox(width: AppSpacing.md),
                    // Job title and company
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobTitle,
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (companyName != null) ...[
                            SizedBox(height: 4),
                            Text(
                              companyName!,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: AppSpacing.md),
                
                // Job details with icons
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  children: [
                    if (location != null)
                      _buildInfoChip(
                        icon: FontAwesomeIcons.locationDot,
                        label: location!,
                        color: AppColors.info,
                      ),
                    if (salary != null)
                      _buildInfoChip(
                        icon: FontAwesomeIcons.moneyBill,
                        label: salary!,
                        color: AppColors.success,
                      ),
                    if (quantity != null)
                      _buildInfoChip(
                        icon: FontAwesomeIcons.users,
                        label: '$quantity người',
                        color: AppColors.warning,
                      ),
                  ],
                ),
                
                if (experience != null || postedDate != null) ...[
                  SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      if (experience != null) ...[
                        _buildBadge(
                          icon: FontAwesomeIcons.briefcase,
                          label: experience!,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: AppSpacing.sm),
                      ],
                      if (postedDate != null)
                        Expanded(
                          child: Text(
                            postedDate!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ],
                
                if (onApply != null) ...[
                  SizedBox(height: AppSpacing.md),
                  Divider(height: 1, color: AppColors.border),
                  SizedBox(height: AppSpacing.md),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onTap,
                          icon: Icon(
                            FontAwesomeIcons.circleInfo,
                            size: 14,
                          ),
                          label: Text('Chi tiết'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.button,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: onApply,
                          icon: Icon(
                            FontAwesomeIcons.paperPlane,
                            size: 14,
                          ),
                          label: Text('Ứng tuyển'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.button,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm,
                            ),
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

  Widget _buildDefaultLogo() {
    return Center(
      child: Icon(
        FontAwesomeIcons.building,
        size: 20,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 10,
            color: color,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
