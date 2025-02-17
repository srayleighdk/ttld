import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/pages/home/ntv/bloc/ntv_form_bloc.dart';
import 'package:ttld/pages/home/ntv/model/ntv_model.dart';

class NTVFormScreen extends StatefulWidget {
  final Ntv? existingNtv; // Null for create mode

  const NTVFormScreen({super.key, this.existingNtv});

  @override
  State<NTVFormScreen> createState() => _NTVFormScreenState();
}

class _NTVFormScreenState extends State<NTVFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _uvUsernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<AuthBloc>(context).state;
    if (state is AuthAuthenticated) {
      _nameController.text = state.userName;
      // _emailController.text = state.email;
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final ntv = Ntv(
      uvUsername: _uvUsernameController.text,
      id: widget.existingNtv?.id ?? 0, // Use existing ID if updating
      uvHoten: _nameController.text.trim(),
      uvEmail: _emailController.text.trim(),
    );

    if (widget.existingNtv == null) {
      context.read<NTVFormBloc>().add(CreateUserEvent(ntv));
    } else {
      context.read<NTVFormBloc>().add(UpdateUserEvent(ntv));
    }

    Navigator.pop(context, ntv); // Return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingNtv == null ? "Create User" : "Edit User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value!.isEmpty ? "Name cannot be empty" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Email cannot be empty" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(widget.existingNtv == null ? "Create" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
