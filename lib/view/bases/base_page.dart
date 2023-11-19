import 'package:micro_memo/importer.dart';

abstract class StatefulBaseWidget extends StatefulWidget {
  const StatefulBaseWidget({super.key});
}

abstract class StatelessBaseWidget
    extends StatelessWidget
    with DialogMixin, NavigateMixin {

  final Repository repo = Repository.instance;

  StatelessBaseWidget({super.key});

  initialize(BuildContext context);
}

abstract class BaseState<T extends StatefulBaseWidget>
    extends State<T>
    with UseAppSettingsMixin, DialogMixin, NavigateMixin {

  @override
  void initState() {
    super.initState();
    appSettings = AppSettings(context);
  }
}
