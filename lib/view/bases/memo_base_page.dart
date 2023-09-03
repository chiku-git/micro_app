import 'package:micro_memo/importer.dart';

abstract class MemoBasePage extends StatefulBaseWidget {
  static const String memoRoute = "/memo";
  static const String templateRoute = "/template";
  final MemoPageIVO ivo;

  const MemoBasePage({super.key, required this.ivo});
}