import 'package:dart_mpesa_advanced/dart_mpesa.dart';

abstract class MpesaService {
  late Mpesa mpesa;
  Future<MpesaResponse> process();
}
