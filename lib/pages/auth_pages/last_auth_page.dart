import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class LastAuthorizationPage extends StatefulWidget {
  const LastAuthorizationPage({Key? key}) : super(key: key);
  static const routeName = '/last_authorization_page';

  @override
  State<LastAuthorizationPage> createState() => _LastAuthorizationPageState();
}

class _LastAuthorizationPageState extends State<LastAuthorizationPage> {
  final bool shouldPop = false;
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Phoenix.rebirth(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                'Мы рады тебя видеть',
              ),
              const SizedBox(
                height: 50.0,
              ),
              // Image.asset(
              //   AppIcons.heart,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
