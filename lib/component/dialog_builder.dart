import 'package:micro_memo/importer.dart';

class ConfirmDialogBuilder extends DialogBuilder {
  ConfirmDialogBuilder(super.context);

  @override
  AlertDialog build() {
    return buildDialog(title: _title, content: _body);
  }

  @override
  List<Widget> getActions() {
    List<Widget> actions = [];

    // negative
    if (isNotNull(_negative)) {
      actions.add(
          TextButton(
              onPressed: () {
                dismiss();
                _onNegative?.call();
              },
              child: _negative!
          )
      );
    }

    // positive
    checkNonNull([_positive]);
    actions.add(
        TextButton(
            onPressed: () {
              dismiss();
              _onPositive.call();
            },
            child: _positive!
        )
    );

    return actions;
  }
}

abstract class DialogBuilder {
  BuildContext context;
  Text? _title;
  Text? _body;
  Text? _positive;
  Function _onPositive = () {
    throw UnimplementedError("should set _onPositive.");
  };
  Text? _negative;
  Function? _onNegative;

  DialogBuilder(this.context);

  set title(String? value) {
    if (isNotNull(value)) {
      _title = Text(
        value!,
        style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600
        ),
      );
    }
  }

  set body(String value) {
    _body = Text(value);
  }

  set onNegative(Function value) {
    _onNegative = value;
  }

  set negative(String value) {
    _negative = Text(value);
  }

  set onPositive(Function value) {
    _onPositive = value;
  }

  set positive(String value) {
    _positive = Text(value);
  }

  AlertDialog buildDialog({required Widget? title, required Widget? content}) {
    return AlertDialog(
      title: title,
      content: content,
      actions: getActions(),
    );
  }

  void dismiss() {
    Navigator.of(context).pop();
  }

  AlertDialog build();
  List<Widget> getActions();
}
