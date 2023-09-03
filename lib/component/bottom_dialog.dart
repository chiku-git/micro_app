import 'package:micro_memo/importer.dart';

class ChoicesWidget extends StatelessWidget {
  final double height;
  final double width;
  final List<ChoicesButtonAttr> buttonAttrs;
  final double spacing;

  const ChoicesWidget({
    super.key,
    required this.height,
    required this.width,
    required this.buttonAttrs,
    required this.spacing
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: buildButtons(context),
        ),
      ),
    );
  }

  List<Widget> buildButtons(BuildContext context) {
    List<Widget> widgets = [];
    final last = buttonAttrs.length - 1;


    widgets.add(const Margin(height: 10));
    buttonAttrs.asMap().forEach((index, attr) {
      Widget button;
      if (index != last) {
        button = Column(
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                ),
                onPressed: () => _createOnPressed(context, attr.onClicked),
                child: Text(
                    attr.text,
                    style: TextStyle(
                        color: attr.textColor
                    )
                )
            ),
            Margin(height: spacing)
          ],
        );
      } else {
        button = TextButton(
            style: TextButton.styleFrom(
              minimumSize:  const Size(150, 50),
            ),
            onPressed: () => _createOnPressed(context, attr.onClicked),
            child: Text(
                attr.text,
                style: TextStyle(
                    color: attr.textColor
                )
            )
        );
      }

      widgets.add(button);
    });

    return widgets;
  }

  Future _createOnPressed(BuildContext context, Function? onPressed) {
    return Future(() {
      onPressed?.call();
      Navigator.pop(context);
    });
  }
}

class ChoicesButtonAttr {
  final String text;
  final Color? textColor;
  final Function? onClicked;

  ChoicesButtonAttr({
    required this.text,
    this.textColor,
    this.onClicked,
  });
}