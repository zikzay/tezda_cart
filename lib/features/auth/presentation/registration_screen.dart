import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_cart/app/router/app_router.dart';
import 'package:tezda_cart/core/utils/validators.dart';
import 'package:tezda_cart/core/widgets/form_text_field.dart';
import '../providers/auth_provider.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  bool _isSubmitted = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      final isSuccess = await ref.read(authProvider.notifier).register(
            email: _emailController.text,
            password: _passwordController.text,
          );
      if (isSuccess) {
        Navigator.pushReplacementNamed(context, AppRouter.productList);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create your \naccount',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Enter your details to get started',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  FormTextField(
                    labelText: 'Email',
                    controller: _emailController,
                    onChange: _validateForm,
                    validator: Validator.validateEmail,
                  ),
                  SizedBox(height: 16),
                  FormTextField(
                    isPassWordField: true,
                    labelText: 'Password',
                    controller: _passwordController,
                    validator: (val) => Validator.notEmpty(val, 'Password'),
                    onChange: _validateForm,
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
                      'Register',
                      style: TextStyle(color: const Color.fromARGB(255, 193, 145, 0)),
                    ),
                  ),
                  SizedBox(height: 48),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, AppRouter.login);
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
