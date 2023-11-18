import 'package:micro_memo/importer.dart';

class HomePage extends StatefulBaseWidget {
  static const String route = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(appSettings);
    viewModel.loadMemos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.homeTitle),
          actions: [
            IconButton(
                onPressed: () {
                  navigate(
                      context: context,
                      path: SettingsPage.route
                  );
                },
                icon: const Icon(Icons.settings))
          ],
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
          stream: viewModel.queryMemos(),
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (data.results.isEmpty) {
              return const Center(child: Text(Strings.noMemos));
            }

            final memos = data.results.toList();
            return ListView.builder(
                itemCount: memos.length,
                itemBuilder: (context, index) {
                  return _HomeRow(
                      memo: memos[index],
                      viewModel: viewModel
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            navigate(
                context: context,
                path: CreateMemoPage.route,
                ivo: MemoPageIVO()
            );
          },
        ),
      ),
    );
  }

  void loadMemos() {
    setState(() {
      viewModel.loadMemos();
    });
  }
}

class _HomeRow extends StatelessBaseWidget {
  final Memo memo;
  final HomeViewModel viewModel;

   _HomeRow({required this.memo, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    initialize(context);

    return ListenableBuilder(
      listenable: viewModel.appSettings.notifier,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColor.of(context).uiColors.borderColor
                  )
              )
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            title: Text(
              memo.firstLine,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: createTrailing(context, memo),
            ),
            onTap: () {
              final ivo = MemoPageIVO(memo: memo);
              if (viewModel.isEnabledPasscode && memo.isPrivate) {
                LockPage.tryUnlock(context, onUnlocked: () {
                  navigate(context: context, path: MemoPage.route, ivo: ivo);
                });
              } else {
                navigate(context: context, path: MemoPage.route, ivo: ivo);
              }
            },
          ),
        );
      },
    );
  }

  @override
  initialize(BuildContext context) {
    // NOP
  }

  List<Widget> createTrailing(BuildContext context, Memo memo) {
    List<Widget> trailing = [];

    if (viewModel.isEnabledPasscode && memo.isPrivate) {
      trailing.add(const Icon(size: 22, Icons.lock));
    }

    trailing.add(createContextMenu(context, memo));

    return trailing;
  }

  Widget createContextMenu(BuildContext context, Memo memo) {
    final listMenus = viewModel.getListMenus(memo);

    return PopupMenuButton<HomeListMenu>(
      elevation: 1,
      icon: const Icon(color: Colors.grey, Icons.more_vert),
      onSelected: (HomeListMenu item) {
        switch (item) {
          case HomeListMenu.delete:
            showConfirmDialog(
                context: context,
                title: Strings.deleteMemoTitle,
                body: Strings.deleteMemoBody,
                onPositiveAction: () {
                  viewModel.deleteMemo(memo);
                }
            );
            break;
          case HomeListMenu.closed:
            viewModel.updateMemoPrivacy(memo, true);
            break;
          case HomeListMenu.opened:
            showConfirmDialog(
                context: context,
                title: Strings.requireVerifyPasscode,
                body: Strings.confirmToVerifyPasscode,
                onPositiveAction: () {
                  tryUnlock(context, () {
                    viewModel.updateMemoPrivacy(memo, false);
                  });
                });
            break;
          case HomeListMenu.registerTemplate:
            if (memo.isPrivate) {
              showConfirmDialog(
                  context: context,
                  title: Strings.requireVerifyPasscode,
                  body: Strings.confirmToVerifyPasscode,
                  onPositiveAction: () {
                    tryUnlock(context, () {
                      MemoPageIVO ivo = MemoPageIVO(memo: memo);
                      navigate(context: context, path: RegisterTemplatePage.route, ivo: ivo);
                    });
                  });
            } else {
              MemoPageIVO ivo = MemoPageIVO(memo: memo);
              navigate(context: context, path: RegisterTemplatePage.route, ivo: ivo);
            }
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) {
        return listMenus.map((item) => PopupMenuItem(
          padding: const EdgeInsets.all(0),
          value: item,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: item.icon,
              ),
              Text(item.name, style: const TextStyle(fontSize: 16),)
            ],
          ),
        ))
            .toList();
      },
    );
  }

  void tryUnlock(BuildContext context, Function onUnlocked) {
    LockPage.tryUnlock(context, onUnlocked: onUnlocked);
  }
}