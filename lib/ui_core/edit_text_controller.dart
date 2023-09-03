import 'package:micro_memo/importer.dart';

class EditTextController extends TextEditingController {
  late final TextValidator? _validator;
  late final String initText;

  EditTextController({required String text,
                      TextValidator? validator}) : super(text: text) {
    _validator = validator;
    initText = text;
  }

  void onTextChanged(String text) {
    _validator?.value = text;
  }

  void selectFirst() {
    _setSelection(0);
  }

  void selectEnd() {
    _setSelection(text.length);
  }

  void _setSelection(int offset) {
    selection = TextSelection.fromPosition(TextPosition(offset: offset));
  }

  bool isValid() {
    if (_validator == null) return true;

    return _validator!.isValid();
  }

  void dropLast() {
    if (text.isEmpty) return;

    text = text.substring(0, text.length - 1);
  }

  void reset() {
    text = initText;
  }

  void append(String text) {
    this.text += text;
  }
}
