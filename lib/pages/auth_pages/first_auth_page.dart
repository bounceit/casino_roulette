import 'dart:async';

import 'package:casino/pages/game_page/game_page.dart';
import 'package:casino/pages/main_of_main.dart';
import 'package:flutter/material.dart';

class FirstAuthorizationPage extends StatefulWidget {
  const FirstAuthorizationPage({Key? key}) : super(key: key);
  static const routeName = '/first_authorization_page';

  @override
  State<FirstAuthorizationPage> createState() => _FirstAuthorizationPageState();
}

class _FirstAuthorizationPageState extends State<FirstAuthorizationPage> {
  final bool shouldPop = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(
        context,
        MainPage.routeName,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        body: Column(
          children: [
            // const AppbarHeaderAuthorization(
            //   title: 'MemoryBox',
            //   subtitle: 'Твой голос всегда рядом',
            // ),
            SizedBox(
              height: screenHeight - 300.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const Text(
                      'Мы рады тебя видеть',
                      // style: twoBodyTextStyle,
                    ),

                    const Expanded(
                      child: SizedBox(),
                    ),
                    // Image.asset(
                    //   AppIcons.heart,
                    // ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    // const Text(
                    //     'Взрослые иногда нуждаются в \n сказке даже больше, чем дети',
                    //     style: twoBodyTextStyle,
                    //   ),
                    //   radius: 20.0,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
