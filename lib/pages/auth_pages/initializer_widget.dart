import 'package:casino/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import 'first_auth_page.dart';
import 'first_page.dart';

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({Key? key}) : super(key: key);
  static const routeName = '/initializer_widget';
  final isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : AuthRepositories.instance.user == null
            ? const FirstPage()
            : const FirstAuthorizationPage();
  }
}
