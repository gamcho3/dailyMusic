import 'package:daily_music/features/common/providers/loading_progress_provider.dart';
import 'package:daily_music/utils/functions/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateMusicScreen extends ConsumerStatefulWidget {
  const CreateMusicScreen({super.key});

  @override
  ConsumerState<CreateMusicScreen> createState() => _CreateMusicScreenState();
}

class _CreateMusicScreenState extends ConsumerState<CreateMusicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var count = ref.watch(loadingProgressProvider);
    print(count);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //유튜브 공유Url 문자열을 잘라서 코드만 추출하기
                  final code = _textController.text
                      .split('?')[0]
                      .split('be/')[1]
                      .replaceAll(' ', '');

                  CustomMethod.downloadMusic(code, ref, context);
                }
              },
              child: const Text(
                "완료",
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            customField(label: '주소를 입력해 주세요'),
          ],
        ),
      ),
    );
  }

  Padding customField({required String label}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _textController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return '빈값은 안됩니다.';
          }

          if (value != null && !value.contains('https')) {
            return '올바른 주소를 입력하세요';
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
