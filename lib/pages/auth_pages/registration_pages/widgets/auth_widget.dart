import 'dart:async';

import 'package:casino/pages/auth_pages/registration_pages/widgets/text_field_captcha.dart';
import 'package:casino/pages/game_page/game_page.dart';
import 'package:casino/widgets/ucategorized/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../last_auth_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget(
      {Key? key,
      required this.controller,
      required this.otpController,
      required this.phoneController})
      : super(key: key);
  final PageController controller;
  final TextEditingController phoneController;
  final TextEditingController otpController;

  void buttonContinue(
    BuildContext context,
    state,
  ) {
    if (phoneController.text.isNotEmpty && state.status == AuthStatus.initial) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthBloc>(context).add(
        PhoneNumberVerificationIdEvent(
          phone: phoneController.text,
        ),
      );
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if (state.status == AuthStatus.codeSent) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthBloc>(context).add(
        PhoneAuthCodeVerificationIdEvent(
            phone: phoneController.text,
            smsCode: otpController.text,
            verificationId: state.verificationId),
      );
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Timer(
            const Duration(milliseconds: 1),
            () => Navigator.pushNamed(
              context,
              LastAuthorizationPage.routeName,
            ),
          );
        }
      });
    } else if (state.status == AuthStatus.failed) {
      BlocProvider.of<AuthBloc>(context).add(
        PhoneNumberVerificationIdEvent(
          phone: phoneController.text,
        ),
      );
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if (state.status == AuthStatus.failedCodeSent) {
      BlocProvider.of<AuthBloc>(context).add(
        PhoneNumberVerificationIdEvent(
          phone: phoneController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: screenHeight - 350.0,
              width: screenWidth,
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Phone(
                    phoneController: phoneController,
                  ),
                  _Sms(
                    otpController: otpController,
                    controller: controller,
                    phoneController: phoneController,
                  ),
                  const LastAuthorizationPage(),
                ],
              ),
            ),
            Positioned(
              top: 100.0,
              left: (screenWidth - 275.0) / 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: state.status == AuthStatus.loading
                        ? null
                        : () => buttonContinue(
                              context,
                              state,
                            ),
                    child: Text(state.status == AuthStatus.failed ||
                            state.status == AuthStatus.failedCodeSent
                        ? 'Отправить еще раз'
                        : 'Продолжыть'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        GamePage.routeName,
                      );
                    },
                    child: const Text(
                      'Позже',
                      style: TextStyle(
                        fontSize: 24.0,
                        // color: AppColors.colorText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Регистрация привяжет твои сказки к облаку, после чего они всегда будут с тобой',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _Sms extends StatelessWidget {
  const _Sms(
      {Key? key,
      required this.otpController,
      required this.controller,
      required this.phoneController})
      : super(key: key);
  final TextEditingController otpController;
  final TextEditingController phoneController;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            state.status == AuthStatus.loading
                ? const Text(
                    'Регистрация телефона ...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.codeSent
                ? const Text(
                    'Введи код из смс, чтобы мы \n  тебя запомнили',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failed
                ? const Text(
                    'Ошибка ввода номера',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failedCodeSent
                ? const Text(
                    'Отправить смс еще раз',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10.0,
            ),
            state.status == AuthStatus.loading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
            state.status == AuthStatus.codeSent
                ? TextFieldCaptcha(
                    controller: otpController,
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failed
                ? TextFieldInput(
                    controller: phoneController,
                  )
                : const SizedBox.shrink(),
            state.status == AuthStatus.failedCodeSent
                ? TextFieldCaptcha(
                    controller: otpController,
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

class _Phone extends StatelessWidget {
  const _Phone({Key? key, required this.phoneController}) : super(key: key);
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Введи номер телефона',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFieldInput(
            controller: phoneController,
          ),
        ),
      ],
    );
  }
}
