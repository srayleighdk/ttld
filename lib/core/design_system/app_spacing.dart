/// Spacing system for the TTLD application
/// Provides consistent spacing values across the app
class AppSpacing {
  AppSpacing._();

  // Base spacing unit (4px)
  static const double unit = 4.0;

  // Spacing scale
  static const double xs = unit; // 4px
  static const double sm = unit * 2; // 8px
  static const double md = unit * 3; // 12px
  static const double lg = unit * 4; // 16px
  static const double xl = unit * 5; // 20px
  static const double xxl = unit * 6; // 24px
  static const double xxxl = unit * 8; // 32px
  static const double huge = unit * 10; // 40px
  static const double massive = unit * 12; // 48px

  // Common spacing values
  static const double padding = lg; // 16px
  static const double margin = lg; // 16px
  static const double gap = md; // 12px
  static const double gutter = xxl; // 24px

  // Component-specific spacing
  static const double buttonPaddingVertical = md; // 12px
  static const double buttonPaddingHorizontal = xxl; // 24px
  static const double cardPadding = lg; // 16px
  static const double listItemPadding = lg; // 16px
  static const double sectionSpacing = xxxl; // 32px
  static const double screenPadding = xxl; // 24px
}
