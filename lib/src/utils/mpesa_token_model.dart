import 'dart:io';

import 'package:hive/hive.dart';

part 'mpesa_token_model.g.dart';

final envVarMap = Platform.environment;
final String? projectPath = envVarMap["PWD"];

@HiveType(typeId: 0)
class MpesaTokenModel {
  MpesaTokenModel([this.token, this.expires]);

  HiveInterface get hive => Hive;

  static final String _boxLabel = 'mpesa_token';

  void init() {
    Hive.init(projectPath!);
    Hive.registerAdapter<MpesaTokenType>(MpesaTokenTypeAdapter());
    Hive.registerAdapter<MpesaTokenModel>(MpesaTokenModelAdapter());
  }

  @HiveField(0)
  String? token;
  @HiveField(1)
  DateTime? expires;

  bool isNotExpired() {
    if (expires?.isAfter(DateTime.now().subtract(const Duration(minutes: 4))) ??
        true) {
      // expires
      return false;
    } else {
      //still valid
      return true;
    }
  }

  Future<Box> get openBox async => await Hive.openBox(_boxLabel);

  Box get box => Hive.box(_boxLabel);

  Future<MpesaTokenModel?> fetch(MpesaTokenType key) async {
    await openBox;
    var _res = box.get(key.value) as MpesaTokenModel?;
    await box.close();
    return _res;
  }

  Future<void> put(MpesaTokenModel value, MpesaTokenType key) async {
    await openBox;
    var _res = await box.put(key.value, value);
    await box.close();
    return _res;
  }
}

@HiveType(typeId: 1)
enum MpesaTokenType {
  @HiveField(0)
  normal,
  @HiveField(1)
  stk
}

extension MpesaTokenTypeValue on MpesaTokenType {
  String get value {
    switch (this) {
      case MpesaTokenType.stk:
        return 'stk';
      default:
        return 'normal';
    }
  }
}
