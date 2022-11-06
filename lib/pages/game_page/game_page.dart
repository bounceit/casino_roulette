import 'dart:math';

import 'package:casino/repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:roulette/roulette.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  static const routeName = '/game_page';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  static final _random = Random();
  final user = AuthRepositories.instance.user;

  late RouletteController _controller;
  bool _clockwise = true;

  final colors = <Color>[Colors.red, Colors.black];

  @override
  void initState() {
    // Initialize the controller
    final values = <int>[
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36
    ];
    final group = RouletteGroup.uniform(
      values.length,
      colorBuilder: ((index) => Colors.red),
      textBuilder: (index) => (index + 1).toString(),
    );
    _controller = RouletteController(vsync: this, group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                  ),
                  Expanded(child: SizedBox()),
                  Text('20000'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.monetization_on),
                  ),
                ],
              ),
              MyRoulette(controller: _controller),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Обратное вращение: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _clockwise,
                    onChanged: (onChanged) {
                      setState(() {
                        _controller.resetAnimation();
                        _clockwise = !_clockwise;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: TextButton(
          // Use the controller to run the animation with rollTo method
          onPressed: () => _controller.rollTo(
            3,
            clockwise: _clockwise,
            offset: _random.nextDouble(),
          ),
          child: const Icon(Icons.refresh_rounded),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RouletteController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Roulette(
              // Provide controller to update its state
              controller: controller,
              // Configure roulette's appearance
              style: const RouletteStyle(
                  centerStickSizePercent: 0.1,
                  dividerThickness: 2,
                  textLayoutBias: 1,
                  centerStickerColor: Colors.black,
                  textStyle: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
