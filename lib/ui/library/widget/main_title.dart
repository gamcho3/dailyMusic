import 'package:flutter/material.dart';

import '../../../utils/theme/constants.dart';

class MainTitle extends StatelessWidget {
  final String title;
  const MainTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 15, top: 15),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
