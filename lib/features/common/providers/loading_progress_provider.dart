import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProgressProvider = StateProvider.autoDispose<int>((ref) => 0);
