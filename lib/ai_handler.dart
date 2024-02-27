import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(
      receiveTimeout: 20000,
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = CompleteText(prompt: message, model: kTranslateModelV3);
      final response = await _openAI.onCompleteText(request: request);

      if (response != null && response.choices.isNotEmpty) {
        return response.choices[0].text.trim();
      } else {
        return 'Some thing went wrong ';
      }
    } catch (e) {
      return 'something wwent wrong';
    }
  }

  void dispose() {
    _openAI.close();
  }
}
