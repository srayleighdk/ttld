import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 85,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Fully opaque background
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
              _buildModernNavItem(
                context: context,
                index: 0,
                label: 'Trang chủ',
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
              ),
              _buildModernNavItem(
                context: context,
                index: 1,
                label: 'Thông báo',
                icon: FontAwesomeIcons.bell,
                selectedIcon: FontAwesomeIcons.solidBell,
                badgeCount: 3, // Example badge count
              ),
              _buildModernNavItem(
                context: context,
                index: 2,
                label: 'Hồ sơ',
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
              ),
              _buildModernNavItem(
                context: context,
                index: 3,
                label: 'Liên hệ',
                icon: FontAwesomeIcons.envelope,
                selectedIcon: FontAwesomeIcons.solidEnvelope,
              ),
        ],
      ),
    );
  }

  Widget _buildModernNavItem({
    required BuildContext context,
    required int index,
    required String label,
    required IconData icon,
    required IconData selectedIcon,
    int? badgeCount,
  }) {
    final theme = Theme.of(context);
    final isSelected = widget.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onDestinationSelected(index);
          _animationController.forward().then((_) {
            _animationController.reverse();
          });
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _scaleAnimation.value : 1.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6), // Reduced padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon container with modern design
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: isSelected ? 44 : 36, // Reduced sizes
                      height: isSelected ? 44 : 36, // Reduced sizes
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(isSelected ? 16 : 12),
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.primary.withOpacity(0.8),
                                ],
                              )
                            : null,
                        color: isSelected ? null : Colors.transparent,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: FaIcon(
                                isSelected ? selectedIcon : icon,
                                key: ValueKey(isSelected),
                                size:
                                    isSelected ? 20 : 18, // Reduced icon sizes
                                color: isSelected
                                    ? Colors.white
                                    : theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                              ),
                            ),
                          ),
                          // Badge for notifications
                          if (badgeCount != null && badgeCount > 0)
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(
                                        0.3), // More subtle border for transparent background
                                    width: 1.5, // Slightly thinner border
                                  ),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  badgeCount > 99
                                      ? '99+'
                                      : badgeCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    // Label with modern typography
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.6),
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: isSelected ? 10 : 9, // Reduced font sizes
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
