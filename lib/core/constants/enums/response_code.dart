import 'dart:math';

import 'package:cos_challenge/core/constants/mocks/cos_challenge.dart';

enum ResponseCode {
  success,
  multipleChoices,
  error;

  const ResponseCode();

  R whenConst<R>({
    required R success,
    required R multipleChoices,
    required R error,
  }) {
    switch (this) {
      case ResponseCode.success:
        return success;
      case ResponseCode.multipleChoices:
        return multipleChoices;
      case ResponseCode.error:
        return error;
    }
  }

  String get mockMultipleChoices => MockData().multipleChoices;

  String get mockSuccess => MockData().success;

  String get mockError {
    final delay = Random().nextInt(5) + 1;

    return MockData().error(delay);
  }
}
