import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);
  static const routeName = '/rating_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('RatingPage')),
    );
  }
}
