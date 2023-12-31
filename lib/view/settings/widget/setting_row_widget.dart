import 'package:micro_memo/importer.dart';

class SettingRow extends StatefulBaseWidget {
  final bool isTop;
  final bool isBottom;
  final Widget leading;
  final Widget trailing;
  final Function? onTap;

  const SettingRow({
    super.key,
    this.isTop = false,
    this.isBottom = false,
    required this.leading,
    required this.trailing,
    this.onTap
  });

  @override
  State<StatefulWidget> createState() => _SettingRowState();
}

/// 設定画面行用ウィジェット
class _SettingRowState extends BaseState<SettingRow> {
  Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColor.of(context).uiColors.borderColor;
    final isTappable = widget.onTap != null;

    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      onTapDown: (_) {
        if (isTappable) {
          applyOnTapEffect(onTapDown: true);
        }
      },
      onTapUp: (_) {
        if (isTappable) {
          applyOnTapEffect(onTapDown: false);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: () {
              return BorderRadius.vertical(
                  top: widget.isTop ? const Radius.circular(10) : Radius.zero,
                  bottom: widget.isBottom
                      ? const Radius.circular(10)
                      : Radius.zero);
            }.call(),
            border: Border(
              top: BorderSide(color: borderColor, width: 1),
              bottom: BorderSide(
                  color: borderColor,
                  width: !widget.isBottom ? 0 : 1
              ),
              left: BorderSide(color: borderColor, width: 1),
              right: BorderSide(color: borderColor, width: 1),
            )),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 12, bottom: 10),
                    child: widget.leading
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: widget.trailing,
              )
            ],
          ),
        ),
      ),
    );
  }

  void applyOnTapEffect({required bool onTapDown}) {
    setState(() {
      if (onTapDown) {
        _backgroundColor = AppColor.of(context).uiColors.onRowTapColor;
      } else {
        _backgroundColor = null;
      }
    });
  }
}