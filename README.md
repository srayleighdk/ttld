# 📱ttld

A new Flutter project.

## 📝 Features

- [x] User Authentication: ADMIN, NTV, NTD
- [x] RegisterPage
- [x] LoginPage

### 📂 Project Structure

lib/
├── bloc
│   ├── tblDmChucDanh
│   │   ├── danhmuc_bloc.dart
│   │   ├── danhmuc_event.dart
│   │   └── danhmuc_state.dart
│   ├── tblDmChuyenMon
│   │   ├── chuyenmon_bloc.dart
│   │   ├── chuyenmon_event.dart
│   │   └── chuyenmon_state.dart
│   ├── tblDmDoiTuongChinhSach
│   │   ├── doituong_bloc.dart
│   │   ├── doituong_event.dart
│   │   └── doituong_state.dart
│   └── tblDmTTTanTat
│       ├── tantat_bloc.dart
│       ├── tantat_event.dart
│       └── tantat_state.dart
├── core
│   ├── api_client.dart
│   ├── constants
│   │   └── api_endpoints.dart
│   ├── di
│   │   ├── injection.dart
│   │   └── providers.dart
│   ├── models
│   │   └── paginated_reponse.dart
│   ├── repositories
│   │   └── base_repository.dart
│   ├── router
│   │   └── app_router.dart
│   ├── services
│   │   ├── auth_service.dart
│   │   ├── chuyenmon_api_service.dart
│   │   ├── doituongchinhsach_api_service.dart
│   │   └── tttantat_api_service.dart
│   └── utils
│       ├── default_toast_notification.dart
│       ├── extension_text.dart
│       ├── extenstions.dart
│       ├── toast_enums.dart
│       ├── toast_meta.dart
│       ├── toast_notification.dart
│       └── toast_utils.dart
├── features
│   ├── auth
│   │   ├── bloc
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   ├── auth_state.dart
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   ├── enums
│   │   │   └── user_type.dart
│   │   ├── models
│   │   │   ├── login_request.dart
│   │   │   ├── login_response.dart
│   │   │   ├── signup_request.dart
│   │   │   └── user_data.dart
│   │   └── repositories
│   │       └── auth_repository.dart
│   ├── ds-ld
│   │   ├── bloc
│   │   │   ├── ld_bloc.dart
│   │   │   ├── ld_event.dart
│   │   │   └── ld_state.dart
│   │   ├── models
│   │   │   ├── ld.dart
│   │   │   └── ld.g.dart
│   │   └── repositories
│   │       ├── ld_repository.dart
│   │       └── ld_repository_impl.dart
│   └── user_group
│       ├── bloc
│       │   ├── group_bloc.dart
│       │   ├── group_event.dart
│       │   └── group_state.dart
│       ├── models
│       │   ├── group.dart
│       │   └── group.g.dart
│       └── repository
│           └── group_repository.dart
├── helppers
│   ├── currency_input_match.dart
│   ├── form_validation.dart
│   ├── help.dart
│   ├── loading_styles.dart
│   ├── ny_color.dart
│   ├── ny_logger.dart
│   ├── ny_text_style.dart
│   └── validator
│       ├── rules.dart
│       ├── validate_exceptions.dart
│       ├── validations.dart
│       └── validator.dart
├── main.dart
├── models
│   ├── chuyenmon
│   │   ├── chuyenmon.dart
│   │   ├── chuyenmon.freezed.dart
│   │   └── chuyenmon.g.dart
│   ├── danhmuc
│   │   ├── danhmuc.dart
│   │   ├── danhmuc.freezed.dart
│   │   └── danhmuc.g.dart
│   ├── doituong_chinhsach
│   │   ├── doituong.dart
│   │   ├── doituong.freezed.dart
│   │   └── doituong.g.dart
│   └── tttantat
│       ├── tttantat.dart
│       ├── tttantat.freezed.dart
│       └── tttantat.g.dart
├── pages
│   ├── change_password
│   │   ├── bloc
│   │   │   ├── change_password_bloc.dart
│   │   │   ├── change_password_event.dart
│   │   │   └── change_password_state.dart
│   │   └── change_password.dart
│   ├── danhmuc
│   │   └── danhmuc_screen.dart
│   ├── error
│   │   └── error.dart
│   ├── forgot_password
│   │   ├── bloc
│   │   │   ├── forgot_password_bloc.dart
│   │   │   ├── forgot_password_event.dart
│   │   │   └── forgot_password_state.dart
│   │   └── forgot_password.dart
│   ├── home
│   │   ├── admin
│   │   │   ├── admin_home.dart
│   │   │   └── system
│   │   │       └── manager_groups.dart
│   │   ├── custom_bottom_nav_bar.dart
│   │   ├── home_page.dart
│   │   ├── notification_page.dart
│   │   ├── ntd
│   │   │   └── ntd_home.dart
│   │   ├── ntv
│   │   │   ├── bloc
│   │   │   │   ├── ntv_form_bloc.dart
│   │   │   │   ├── ntv_form_event.dart
│   │   │   │   └── ntv_form_state.dart
│   │   │   ├── model
│   │   │   │   ├── ntv_model.dart
│   │   │   │   └── ntv_model.g.dart
│   │   │   ├── ntv_form.dart
│   │   │   ├── ntv_form_screen.dart
│   │   │   ├── ntv_home.dart
│   │   │   ├── profile_page.dart
│   │   │   └── repository
│   │   │       └── ntv_repository.dart
│   │   ├── profile_page.dart
│   │   ├── screens
│   │   │   └── edit_profile.dart
│   │   └── search_page.dart
│   ├── login
│   │   └── login_page.dart
│   ├── signup
│   │   ├── bloc
│   │   │   ├── signup_bloc.dart
│   │   │   ├── signup_event.dart
│   │   │   └── signup_state.dart
│   │   └── signup.dart
│   └── splash
│       └── spash_page.dart
├── repositories
│   ├── tblDmChucDanh
│   │   ├── danhmuc_repository.dart
│   │   └── danhmuc_repository_impl.dart
│   ├── tblDmChuyenMon
│   │   ├── chuyenmon_repository.dart
│   │   └── chuyenmon_repository_impl.dart
│   ├── tblDmDoiTuongChinhSach
│   │   ├── doituong_repository.dart
│   │   └── doituong_repository_impl.dart
│   └── tblDmTTtantat
│       ├── tantat_repository.dart
│       └── tantat_repository_impl.dart
├── themes
│   ├── base_theme_config.dart
│   ├── colors
│   │   ├── base_color_style.dart
│   │   ├── color_style.dart
│   │   ├── dark_theme_color.dart
│   │   └── light_theme_color.dart
│   ├── dart_theme.dart
│   ├── light_theme.dart
│   └── text
│       ├── app_theme.dart
│       ├── font.dart
│       └── text_theme.dart
└── widgets
    ├── button
    │   ├── abstract
    │   │   └── app_button.dart
    │   ├── button.dart
    │   ├── button_state.dart
    │   └── partials
    │       ├── gradient_button_widget.dart
    │       ├── icon_button_widget.dart
    │       ├── outlined_button_widget.dart
    │       ├── primary_button_widget.dart
    │       ├── rounded_button_widget.dart
    │       ├── secondary_button_widget.dart
    │       ├── text_only_button_widget.dart
    │       └── transparency_button_widget.dart
    ├── custom_quick_link.dart
    ├── custom_text_field.dart
    ├── custom_user_profile.dart
    ├── field
    │   ├── cast.dart
    │   ├── date_time_picker.dart
    │   ├── field_base_state.dart
    │   ├── field.dart
    │   ├── form_checkbox.dart
    │   ├── form_chips.dart
    │   ├── form_picker.dart
    │   ├── form_style.dart
    │   └── form_switch_box.dart
    ├── form
    │   ├── bloc
    │   │   ├── form_bloc.dart
    │   │   ├── form_event.dart
    │   │   ├── form_state.dart
    │   │   ├── form_validate_bloc.dart
    │   │   ├── form_validate_event.dart
    │   │   └── form_validate_state.dart
    │   ├── ny_form.dart
    │   ├── ny_form_data.dart
    │   └── ny_form_item.dart
    ├── logout_button.dart
    ├── ny_future_builder.dart
    ├── spacing.dart
    ├── styles
    │   └── bottom_modal_sheet.dart
    └── user_type_selector.dart

### Main Dependencies

- **flutter**:

  ```yaml
  sdk: flutter
  cupertino_icons: ^1.0.8
  theme_provider: ^0.6.0
  google_fonts: ^6.2.1
  flutter_dotenv: ^5.2.1
  dio: ^5.8.0+1
  flutter_bloc: ^9.0.0
  equatable: ^2.0.7
  go_router: ^14.8.0
  pretty_dio_logger: ^1.4.0
  font_awesome_flutter: ^10.8.0
  flutter_styled_toast: ^2.2.1
  shared_preferences: ^2.5.2
  mask_text_input_formatter: ^2.9.0
  validated: ^2.0.0
  intl: ^0.19.0
  json_annotation: ^4.9.0
  flutter_secure_storage: ^9.2.4
  date_field: ^6.0.3+1
  skeletonizer: ^1.4.3
  recase: ^4.1.0
  flutter_multi_formatter: ^2.13.0
  freezed_annotation: ^2.4.4
  get_it: ^8.0.3

- Dev Dependencies

    ```yaml
    flutter_test:
        sdk: flutter
  flutter_lints: ^5.0.0
  json_serializable: ^6.9.4
  build_runner: ^2.4.15
  freezed: ^2.5.8
    ```
