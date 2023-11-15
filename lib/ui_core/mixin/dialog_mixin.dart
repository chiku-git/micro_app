import 'package:micro_memo/importer.dart';

mixin class DialogMixin {
  showConfirmDialog(
      {required BuildContext context,
       String? title,
       required String body,
       String positive = Strings.yes,
       required Function onPositiveAction,
       String negative = Strings.no,
       Function? onNegativeAction}) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final dialogBuilder = ConfirmDialogBuilder(context);
          dialogBuilder.title = title;
          dialogBuilder.body = body;
          dialogBuilder.positive = positive;
          dialogBuilder.onPositive = onPositiveAction;
          dialogBuilder.negative = negative;
          if (isNotNull(onNegativeAction)) {
            dialogBuilder.onNegative = onNegativeAction!;
          }

          return dialogBuilder.build();
        }
    );
  }
}