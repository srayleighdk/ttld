import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/blocs/sgdvl/sgdvl_bloc.dart';
import 'package:ttld/blocs/uv_dk_sgd/uv_dk_sgd_bloc.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';
import 'package:ttld/repositories/sgdvl_repository.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_bloc.dart';

class SGDVLRegistrationPage extends StatefulWidget {
  final SGDVL? sgdvl;
  
  const SGDVLRegistrationPage({
    super.key,
    this.sgdvl,
  });

  static const routePath = '/sgdvl-registration';

  @override
  State<SGDVLRegistrationPage> createState() => _SGDVLRegistrationPageState();
}

class _SGDVLRegistrationPageState extends State<SGDVLRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contentController = TextEditingController();
  
  SGDVL? _selectedSgdvl;
  String? _userId;
  
  @override
  void initState() {
    super.initState();
    _selectedSgdvl = widget.sgdvl;
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SGDVLBloc(locator<SGDVLRepository>())..add(LoadSGDVLs()),
        ),
        BlocProvider(
          create: (context) => locator<UvDkSGDBloc>(),
        ),
        // Always provide NTVBloc to avoid the error when navigating back
        BlocProvider<NTVBloc>.value(
          value: locator<NTVBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng ký phiên giao dịch việc làm'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<UvDkSGDBloc, UvDkSGDState>(
              listener: (context, state) {
                if (state is UvDkSGDRegistered) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Đăng ký thành công!'),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  // Navigate back to SGDVL page after successful registration
                  Navigator.pop(context);
                } else if (state is UvDkSGDRegistrationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Lỗi: ${state.message}')),
                        ],
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: locator<AuthBloc>(),
            builder: (context, authState) {
              if (authState is! AuthAuthenticated) {
                return _buildLoginRequired();
              }
              
              _userId = authState.userId;
              
              if (_selectedSgdvl != null) {
                return _buildRegistrationForm();
              }
              
              return BlocBuilder<SGDVLBloc, SGDVLState>(
                builder: (context, state) {
                  if (state is SGDVLInitial || state is SGDVLLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SGDVLError) {
                    return _buildErrorState(state.message);
                  }

                  if (state is SGDVLLoaded) {
                    return _buildSGDVLSelection(state.sgdvls);
                  }

                  return const Center(child: Text('Unknown state'));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginRequired() {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Vui lòng đăng nhập',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bạn cần đăng nhập để đăng ký tham gia phiên giao dịch việc làm',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.login),
              label: const Text('Đăng nhập'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: theme.colorScheme.error.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Có lỗi xảy ra',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                context.read<SGDVLBloc>().add(LoadSGDVLs());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSGDVLSelection(List<SGDVL> sgdvls) {
    final theme = Theme.of(context);
    
    if (sgdvls.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 80,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Không có phiên giao dịch nào',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Hiện tại chưa có phiên giao dịch việc làm nào được tổ chức',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn phiên giao dịch',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vui lòng chọn phiên giao dịch việc làm mà bạn muốn tham gia',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        
        // List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sgdvls.length,
            itemBuilder: (context, index) {
              final sgdvl = sgdvls[index];
              return _buildSGDVLSelectionCard(sgdvl);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSGDVLSelectionCard(SGDVL sgdvl) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSgdvl = sgdvl;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.event,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      sgdvl.pgdTen,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Ngày tổ chức', _formatDate(sgdvl.pgdNgay)),
              const SizedBox(height: 8),
              _buildInfoRow('Thời gian', sgdvl.pgdGio),
              const SizedBox(height: 8),
              _buildInfoRow('Địa điểm', sgdvl.pgdDiadiem),
              const SizedBox(height: 8),
              _buildInfoRow('Nhu cầu tuyển dụng', '${sgdvl.tongNhucauTd} người'),
              const SizedBox(height: 8),
              _buildInfoRow('Đã đăng ký', '${sgdvl.soUvDangkyPgd} ứng viên'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    final theme = Theme.of(context);
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Header with selected event info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.secondary.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedSgdvl = null;
                        });
                      },
                      icon: const Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.surface,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng ký tham gia',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedSgdvl!.pgdTen,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
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
          
          // Form content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event details card
                  _buildEventDetailsCard(),
                  
                  const SizedBox(height: 24),
                  
                  // Registration form
                  _buildFormFields(),
                ],
              ),
            ),
          ),
          
          // Submit button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: BlocBuilder<UvDkSGDBloc, UvDkSGDState>(
                  builder: (context, state) {
                    final isRegistering = state is UvDkSGDRegistering;
                    
                    return FilledButton.icon(
                      onPressed: isRegistering ? null : _handleRegistration,
                      icon: isRegistering 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.app_registration),
                      label: Text(isRegistering ? 'Đang đăng ký...' : 'Đăng ký tham gia'),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetailsCard() {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin phiên giao dịch',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Ngày tổ chức', _formatDate(_selectedSgdvl!.pgdNgay)),
          const SizedBox(height: 12),
          _buildInfoRow('Thời gian', _selectedSgdvl!.pgdGio),
          const SizedBox(height: 12),
          _buildInfoRow('Địa điểm', _selectedSgdvl!.pgdDiadiem),
          const SizedBox(height: 12),
          _buildInfoRow('Nhu cầu tuyển dụng', '${_selectedSgdvl!.tongNhucauTd} người'),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin đăng ký',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        
        // Email field
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email liên hệ *',
            hintText: 'Nhập email để nhận thông báo',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Email không hợp lệ';
            }
            return null;
          },
        ),
        
        const SizedBox(height: 20),
        
        // Content field
        TextFormField(
          controller: _contentController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Nội dung (tùy chọn)',
            hintText: 'Nhập thông tin bổ sung hoặc yêu cầu đặc biệt...',
            prefixIcon: const Icon(Icons.description_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            alignLabelWithHint: true,
          ),
          maxLength: 500,
        ),
        
        const SizedBox(height: 16),
        
        // Note
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Đơn đăng ký của bạn sẽ được xem xét và phản hồi qua email đã cung cấp.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _handleRegistration() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_userId == null || _selectedSgdvl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi xảy ra, vui lòng thử lại'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final registration = UvDkSGD(
      idUngvien: _userId!,
      idPhienGd: _selectedSgdvl!.id,
      ngaydk: DateTime.now().toIso8601String(),
      ngayPgd: _selectedSgdvl!.pgdNgay,
      tieude: 'Đăng ký tham gia phiên GDVL: ${_selectedSgdvl!.pgdTen}',
      noidung: _contentController.text.trim().isEmpty ? null : _contentController.text.trim(),
      email: _emailController.text.trim(),
      duyet: false,
      createdDate: DateTime.now().toIso8601String(),
      createdBy: _userId!,
      modifiredDate: DateTime.now().toIso8601String(),
      modifiredBy: _userId!,
    );

    context.read<UvDkSGDBloc>().add(RegisterForSGDVL(registration: registration));
  }
}
