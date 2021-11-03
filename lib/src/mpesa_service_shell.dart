import 'package:dart_mpesa/dart_mpesa.dart';

abstract class MpesaService {
  late Mpesa mpesa;
  Future<MpesaResponse> process();
}
