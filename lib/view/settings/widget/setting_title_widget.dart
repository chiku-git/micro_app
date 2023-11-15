import 'package:micro_memo/importer.dart';

class SettingTitle extends StatelessWidget {
  final String title;
  const SettingTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Text(title),
    );
  }
}