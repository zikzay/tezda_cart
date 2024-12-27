import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda_cart/app/router/app_router.dart';
import 'package:tezda_cart/core/utils/validators.dart';
import 'package:tezda_cart/core/widgets/form_text_field.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _image;
  bool _isSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<void> _pickImage(WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
      ref.read(authProvider.notifier).updateUserInfo(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            image: _image,
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  _validateForm(String _) {
    if (_isSubmitted) {
      _formKey.currentState!.validate();
    }
  }

  void _submitForm() async {
    _isSubmitted = true;
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).updateUserInfo(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            image: _image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider.notifier).getUserInfo().then((user) {
      _firstNameController.text = user?.firstName ?? '';
      _lastNameController.text = user?.lastName ?? '';
      _emailController.text = user?.email ?? '';
      _image = user?.image;
      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
        ),
        backgroundColor: Colors.black,
        foregroundColor: const Color.fromARGB(255, 193, 145, 0),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout().then((res) {
                if (res == true) {
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage(ref),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!))
                        : AssetImage('assets/images/user-avatar.jpg') as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 16),
              FormTextField(
                labelText: 'Email',
                hintText: 'Enter email',
                controller: _emailController,
                onChange: _validateForm,
                validator: Validator.validateEmail,
              ),
              SizedBox(height: 16),
              FormTextField(
                labelText: 'First name',
                hintText: 'Enter first name',
                controller: _firstNameController,
                onChange: _validateForm,
                validator: (val) => Validator.notEmpty(val, 'First name'),
              ),
              SizedBox(height: 16),
              FormTextField(
                labelText: 'Last name',
                hintText: 'Enter last name',
                controller: _lastNameController,
                onChange: _validateForm,
                validator: (val) => Validator.notEmpty(val, 'Last name'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 1,
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: const Color.fromARGB(255, 193, 145, 0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
