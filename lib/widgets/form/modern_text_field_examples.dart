import 'package:flutter/material.dart';
import 'package:ttld/widgets/form/modern_text_field.dart';
import 'package:ttld/helppers/form_validation.dart';

/// Example page demonstrating various ModernTextField configurations
/// This file shows how to use the new text field widget in different scenarios
class ModernTextFieldExamples extends StatefulWidget {
  const ModernTextFieldExamples({super.key});

  @override
  State<ModernTextFieldExamples> createState() => _ModernTextFieldExamplesState();
}

class _ModernTextFieldExamplesState extends State<ModernTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for different fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();
  final _bioController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _bioController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModernTextField Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Basic Text Fields'),
              
              // Basic text field
              ModernTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                prefixIcon: const Icon(Icons.person_outlined),
                validators: [FormValidator.rule('required')],
                helperText: 'This field is required',
              ),

              // Email field
              ModernTextField.email(
                controller: _emailController,
                required: true,
              ),

              // Phone field
              ModernTextField.phone(
                controller: _phoneController,
                required: true,
              ),

              // Password field
              ModernTextField.password(
                controller: _passwordController,
                required: true,
                strengthLevel: 2,
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Number Fields'),

              // Age field (integer only)
              ModernTextField.number(
                label: 'Age',
                hint: 'Enter your age',
                controller: _ageController,
                required: true,
                allowDecimals: false,
                min: 18,
                max: 100,
              ),

              // Salary field (with decimals)
              ModernTextField.number(
                label: 'Expected Salary',
                hint: 'Enter expected salary',
                controller: _salaryController,
                allowDecimals: true,
                min: 0,
                prefixText: '\$ ',
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Text Area'),

              // Bio text area
              ModernTextField.textArea(
                label: 'Bio',
                hint: 'Tell us about yourself...',
                helperText: 'Maximum 500 characters',
                controller: _bioController,
                maxLength: 500,
                minLines: 3,
                maxLines: 6,
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Search Field'),

              // Search field
              ModernTextField.search(
                hint: 'Search for jobs, companies...',
                controller: _searchController,
                onChanged: (value) {
                  print('Searching for: $value');
                },
                onSubmitted: (value) {
                  print('Search submitted: $value');
                },
                onClear: () {
                  print('Search cleared');
                },
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Different Styles'),

              // Compact style
              ModernTextField(
                label: 'Compact Field',
                hint: 'This uses compact styling',
                style: ModernTextFieldStyle.compact(),
              ),

              // Prominent style
              ModernTextField(
                label: 'Prominent Field',
                hint: 'This uses prominent styling',
                style: ModernTextFieldStyle.prominent(),
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Special Cases'),

              // Read-only field
              ModernTextField(
                label: 'Read Only',
                hint: 'This field is read-only',
                readOnly: true,
                controller: TextEditingController(text: 'Cannot edit this'),
                prefixIcon: const Icon(Icons.lock_outlined),
              ),

              // Disabled field
              ModernTextField(
                label: 'Disabled',
                hint: 'This field is disabled',
                enabled: false,
                prefixIcon: const Icon(Icons.block),
              ),

              // Custom validation
              ModernTextField(
                label: 'Custom Validation',
                hint: 'Must contain "flutter"',
                customValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!value.toLowerCase().contains('flutter')) {
                    return 'Must contain the word "flutter"';
                  }
                  return null;
                },
                validateOnChange: true,
              ),

              const SizedBox(height: 32),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Submit Form'),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Print form data
      print('Form Data:');
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Phone: ${_phoneController.text}');
      print('Age: ${_ageController.text}');
      print('Salary: ${_salaryController.text}');
      print('Bio: ${_bioController.text}');
    } else {
      // Form has errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

/// Example of a login form using ModernTextField
class LoginFormExample extends StatefulWidget {
  const LoginFormExample({super.key});

  @override
  State<LoginFormExample> createState() => _LoginFormExampleState();
}

class _LoginFormExampleState extends State<LoginFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              
              const SizedBox(height: 32),
              
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Sign in to your account',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              
              const SizedBox(height: 32),

              ModernTextField.email(
                controller: _emailController,
                required: true,
                style: ModernTextFieldStyle.prominent(),
              ),

              ModernTextField.password(
                controller: _passwordController,
                required: true,
                style: ModernTextFieldStyle.prominent(),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sign In'),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  // Navigate to forgot password
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}

/// Example of a registration form using ModernTextField
class RegistrationFormExample extends StatefulWidget {
  const RegistrationFormExample({super.key});

  @override
  State<RegistrationFormExample> createState() => _RegistrationFormExampleState();
}

class _RegistrationFormExampleState extends State<RegistrationFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0;

  // Step 1 controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Step 2 controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Step 3 controllers
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 3,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentStep = index),
          children: [
            _buildPersonalInfoStep(),
            _buildSecurityStep(),
            _buildProfessionalInfoStep(),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step 1 of 3',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: ModernTextField(
                  label: 'First Name',
                  hint: 'Enter your first name',
                  controller: _firstNameController,
                  validators: [FormValidator.rule('required')],
                  prefixIcon: const Icon(Icons.person_outlined),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ModernTextField(
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  controller: _lastNameController,
                  validators: [FormValidator.rule('required')],
                ),
              ),
            ],
          ),

          ModernTextField.email(
            controller: _emailController,
            required: true,
          ),

          ModernTextField.phone(
            controller: _phoneController,
            required: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step 2 of 3',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),

          ModernTextField.password(
            controller: _passwordController,
            required: true,
            strengthLevel: 2,
          ),

          ModernTextField.password(
            label: 'Confirm Password',
            hint: 'Confirm your password',
            controller: _confirmPasswordController,
            required: true,
            customValidator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional Information',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step 3 of 3',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),

          ModernTextField(
            label: 'Company',
            hint: 'Enter your company name',
            controller: _companyController,
            prefixIcon: const Icon(Icons.business_outlined),
          ),

          ModernTextField(
            label: 'Position',
            hint: 'Enter your job title',
            controller: _positionController,
            prefixIcon: const Icon(Icons.work_outlined),
          ),

          ModernTextField.number(
            label: 'Years of Experience',
            hint: 'Enter years of experience',
            controller: _experienceController,
            allowDecimals: false,
            min: 0,
            max: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Previous'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep < 2 ? _nextStep : _submitRegistration,
              child: Text(_currentStep < 2 ? 'Next' : 'Register'),
            ),
          ),
        ],
      ),
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      if (_currentStep < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  bool _validateCurrentStep() {
    // This is a simplified validation - in a real app you'd validate specific fields per step
    return _formKey.currentState?.validate() ?? false;
  }

  void _submitRegistration() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}