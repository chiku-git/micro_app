import 'package:micro_memo/importer.dart';

class PasscodeSettingWidget extends StatefulBaseWidget {
  final SettingsViewModel viewModel;

  const PasscodeSettingWidget({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => _PasscodeSettingState();
}

class _PasscodeSettingState extends BaseState<PasscodeSettingWidget> {
  late final SettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingTitle(
            title: Strings.settingsPasscode
        ),
        SettingRow(
            isTop: true,
            leading: const Text(Strings.usePasscode),
            trailing: ListenableBuilder(
                listenable: _viewModel.appSettings.notifier,
                builder: (context, child) {
                  return Switch(
                      value: _viewModel.isEnabledPasscode,
                      onChanged: _switchPasscodeEnable);
                })
        ),
        SettingRow(
            leading: const Text(Strings.requirePasscodeOnLaunch),
            trailing: ListenableBuilder(
                listenable: _viewModel.appSettings.notifier,
                builder: (BuildContext context, Widget? child) {
                  return ListenableBuilder(
                    listenable: _viewModel.hasRegisteredPasscodeNotifier,
                    builder: (BuildContext context, Widget? child) {
                      return Switch(
                          value: _viewModel.lockOnLaunched,
                          onChanged: _viewModel.hasRegisteredPasscode
                              ? (flag) => _viewModel.switchLockOnLaunch(flag)
                              : null);
                    },
                  );
                })
        ),
        SettingRow(
            isBottom: true,
            leading: const Text(Strings.registerPasscode),
            trailing: ListenableBuilder(
                listenable: _viewModel.hasRegisteredPasscodeNotifier,
                builder: (context, child) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          _viewModel.hasRegisteredPasscode
                              ? Strings.settled
                              : Strings.unSettled,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: UIColor.darkGray),
                        ),
                      ),
                      const Icon(Icons.navigate_next)
                    ],
                  );
                }
            ),
            onTap: () {
              _proceedRegisterPasscode(alsoSwitchEnable: false);
            })
      ],
    );
  }

  /// パスコード使用有無を切り替える
  Future<void> _switchPasscodeEnable(bool isEnabled) async {
    if (_viewModel.hasRegisteredPasscode) {
      if (isEnabled) {
        _viewModel.switchEnablePasscode(isEnabled);
      } else {
        confirmDisablePasscode();
      }
    } else {
      confirmRegisterPasscode();
    }
  }

  void confirmDisablePasscode() {
    showConfirmDialog(
        context: context,
        title: Strings.requireVerifyPasscode,
        body: Strings.confirmDisablePasscodeBody,
        onPositiveAction: () {
          LockPage.tryUnlock(context, onUnlocked: () {
            _viewModel.switchEnablePasscode(false);
            _viewModel.switchLockOnLaunch(false);
          });
        });
  }

  void confirmRegisterPasscode() {
    showConfirmDialog(
        context: context,
        title: Strings.requireVerifyPasscode,
        body: Strings.confirmRegisterPasscode,
        onPositiveAction: () {
          _proceedRegisterPasscode(alsoSwitchEnable: true);
        });
  }

  void _proceedRegisterPasscode({bool alsoSwitchEnable = false}) async {
    final page = PasscodeRegisterPage(
        ivo: PasscodeRegisterPageIVO(_viewModel.hasRegisteredPasscode)
    );
    startForResult(context: context, page: page).then((isSuccessful) => {
      if (isOK(isSuccessful)) {
        _viewModel.onSuccessRegisterPasscode(alsoSwitchEnable)
      }
    });
  }
}