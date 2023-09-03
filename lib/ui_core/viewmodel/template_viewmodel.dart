import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart' as realm;

final class TemplateListViewModel extends ViewModel {
  realm.RealmResults<Memo>? templates;

  TemplateListViewModel(): super() {
    _initialize();
  }

  _initialize() {
    templates = null;
  }

  loadTemplates() {
    templates = repo.fetchAllTemplate();
  }

  delete(Memo template) {
    repo.deleteTemplate(template);
  }
}