import 'package:micro_memo/importer.dart';

mixin class NavigateMixin {
  navigate({required BuildContext context, required String path, IVO? ivo}) {
    Navigator.pushNamed(context, path, arguments: ivo);
  }

  Future<dynamic> startForResult({required BuildContext context,
                                  required Widget page}) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page)
    );
  }

  void finish({required BuildContext context}) {
    finishWithResult(context: context, result: null);
  }

  void finishWithResult({required BuildContext context, dynamic result}) {
    Navigator.pop(context, result);
  }
}