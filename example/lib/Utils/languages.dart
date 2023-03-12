import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'gu_IN': {
          'greeting': 'Kem Cho',
        },

        'en_US': {
          'greeting': 'Hello',
        },
      };
}