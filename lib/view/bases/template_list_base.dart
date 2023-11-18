import 'package:micro_memo/importer.dart';

abstract class TemplateListBasePage extends StatelessBaseWidget {
  static const String route = "/template/list";
  final TemplateListViewModel viewModel = TemplateListViewModel();
  TemplateListBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    initialize(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.template),
          automaticallyImplyLeading: canBack(),
          actions: buildActions(context),
        ),
        body: StreamBuilder(
          stream: viewModel.templates?.changes,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (data.results.isEmpty) {
              return const Center(child: Text(Strings.noTemplates));
            }

            final templates = data.results.toList();
            return ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];

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
                        template.firstLine,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: getTrailing(context, template),
                      onTap: () {
                        Future(() {
                          onTapRow(context, template);
                        });
                      },
                    ),
                  );
                }
            );
          },
        )
    );
  }

  @override
  initialize(BuildContext context) {
    viewModel.loadTemplates();
  }

  bool canBack();
  List<Widget> buildActions(BuildContext context);
  Widget? getTrailing(BuildContext context, Memo template);
  onTapRow(BuildContext context, Memo template);
}