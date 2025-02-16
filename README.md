# 📱ttld

A new Flutter project.

## 📝 Features

- [ ] User Authentication: ADMIN, NTV, NTD
- [ ] RegisterPage

### 📂 Project Structure

├── lib
│   ├── core
│   │   ├── api_client.dart
│   │   ├── constants
│   │   │   └── api_endpoints.dart
│   │   ├── di
│   │   │   └── providers.dart
│   │   ├── models
│   │   │   └── paginated_reponse.dart
│   │   ├── repositories
│   │   │   └── base_repository.dart
│   │   ├── router
│   │   │   └── app_router.dart
│   │   ├── services
│   │   │   └── auth_service.dart
│   │   └── utils
│   │       ├── default_toast_notification.dart
│   │       ├── extenstions.dart
│   │       ├── toast_enums.dart
│   │       ├── toast_meta.dart
│   │       ├── toast_notification.dart
│   │       └── toast_utils.dart
│   ├── features
│   │   ├── auth
│   │   │   ├── bloc
│   │   │   │   ├── auth_bloc.dart
│   │   │   │   ├── auth_event.dart
│   │   │   │   ├── auth_state.dart
│   │   │   │   ├── login_bloc.dart
│   │   │   │   ├── login_event.dart
│   │   │   │   └── login_state.dart
│   │   │   ├── enums
│   │   │   │   └── user_type.dart
│   │   │   ├── models
│   │   │   │   ├── login_request.dart
│   │   │   │   ├── login_response.dart
│   │   │   │   ├── signup_request.dart
│   │   │   │   └── user_data.dart
│   │   │   └── repositories
│   │   │       └── auth_repository.dart
│   │   └── ds-ld
│   │       ├── bloc
│   │       │   ├── ld_bloc.dart
│   │       │   ├── ld_event.dart
│   │       │   └── ld_state.dart
│   │       ├── models
│   │       │   ├── ld.dart
│   │       │   └── ld.g.dart
│   │       └── repositories
│   │           ├── ld_repository.dart
│   │           └── ld_repository_impl.dart
│   ├── helppers
│   │   ├── help.dart
│   │   ├── ny_logger.dart
│   │   └── validator
│   │       ├── rules.dart
│   │       ├── validate_exceptions.dart
│   │       ├── validations.dart
│   │       └── validator.dart
│   ├── main.dart
│   ├── pages
│   │   ├── home
│   │   │   ├── custom_bottom_nav_bar.dart
│   │   │   ├── home_page.dart
│   │   │   ├── notification_page.dart
│   │   │   ├── profile_page.dart
│   │   │   ├── screens
│   │   │   │   └── edit_profile.dart
│   │   │   └── search_page.dart
│   │   ├── login
│   │   │   └── login_page.dart
│   │   ├── signup
│   │   │   ├── bloc
│   │   │   │   ├── signup_bloc.dart
│   │   │   │   ├── signup_event.dart
│   │   │   │   └── signup_state.dart
│   │   │   └── signup.dart
│   │   └── splash
│   │       └── spash_page.dart
│   ├── themes
│   │   ├── base_theme_config.dart
│   │   ├── colors
│   │   │   ├── base_color_style.dart
│   │   │   ├── color_style.dart
│   │   │   ├── dark_theme_color.dart
│   │   │   └── light_theme_color.dart
│   │   ├── dart_theme.dart
│   │   ├── light_theme.dart
│   │   └── text
│   │       ├── app_theme.dart
│   │       ├── font.dart
│   │       └── text_theme.dart
│   └── widgets
│       ├── custom_text_field.dart
│       ├── logout_button.dart
│       ├── spacing.dart
│       └── user_type_selector.dart

### Main Dependencies

- **flutter**:

  ```yaml
  sdk: flutter
    cupertino_icons: ^1.0.8
    (Adds Cupertino Icons font for iOS-style icons. Use with the CupertinoIcons class.)
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

- Dev Dependencies

    flutter_test:
        sdk: flutter
    flutter_lints: ^5.0.0
    json_serializable: ^6.9.4
    build_runner: ^2.4.15
