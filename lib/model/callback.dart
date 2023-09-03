import 'package:micro_memo/importer.dart';

class Callback {
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  Callback({required this.onSuccess, required this.onFailure});
}