import 'package:micro_memo/importer.dart';
import 'package:micro_memo/ui_core/mixin/dialog_mixin.dart';
import 'package:micro_memo/ui_core/mixin/navigator_mixin.dart';

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

abstract class StatelessUseAppSettingsWidget
    extends StatelessBaseWidget with UseAppSettingsMixin {
  StatelessUseAppSettingsWidget({super.key, required AppSettings appSettings}) {
    this.appSettings = appSettings;
  }
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
