import 'package:casino/pages/auth_pages/registration_pages/bloc/auth_bloc.dart';
import 'package:casino/pages/auth_pages/registration_pages/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  static const routeName = '/registration_page';
  final PageController _controller = PageController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Register'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              AuthWidget(
                controller: _controller,
                phoneController: phoneController,
                otpController: otpController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
