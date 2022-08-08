import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'library_view.dart';
import 'library_viewModel.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LibraryViewModel(),
      child: const LibraryView(),
    );
  }
}
