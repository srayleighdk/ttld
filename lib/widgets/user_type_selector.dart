import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttld/features/auth/enums/user_type.dart';

class UserTypeSelector extends StatelessWidget {
  final UserType selectedUserType;
  final ValueChanged<UserType> onUserTypeChanged;

  const UserTypeSelector({
    super.key,
    required this.selectedUserType,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'User Type',
        //   style: theme.textTheme.titleMedium,
        // ),
        const SizedBox(height: 8),
        SegmentedButton<UserType>(
          segments: <ButtonSegment<UserType>>[
            ButtonSegment<UserType>(
              value: UserType.admin,
              label: Tooltip(
                message: UserType.admin.tooltip,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(FontAwesomeIcons.userGear, size: 16),
                    const SizedBox(width: 8),
                    Text(UserType.admin.displayName),
                  ],
                ),
              ),
            ),
            ButtonSegment<UserType>(
              value: UserType.ntd,
              label: Tooltip(
                message: UserType.ntd.tooltip,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(FontAwesomeIcons.buildingUser, size: 16),
                    const SizedBox(width: 8),
                    Text(UserType.ntd.displayName),
                  ],
                ),
              ),
            ),
            ButtonSegment<UserType>(
              value: UserType.ntv,
              label: Tooltip(
                message: UserType.ntv.tooltip,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(FontAwesomeIcons.userTie, size: 16),
                    const SizedBox(width: 8),
                    Text(UserType.ntv.displayName),
                  ],
                ),
              ),
            ),
          ],
          selected: {selectedUserType},
          onSelectionChanged: (Set<UserType> newSelection) {
            onUserTypeChanged(newSelection.first);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return theme.colorScheme.primary;
                }
                return theme.colorScheme.surface;
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return theme.colorScheme.onPrimary;
                }
                return theme.colorScheme.onSurface;
              },
            ),
          ),
        ),
      ],
    );
  }
}
