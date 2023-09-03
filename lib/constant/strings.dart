import 'package:micro_memo/importer.dart';

class Strings {
  // 共通
  static const appTitle = "シンプルメモ";
  static const yes = "はい";
  static const no = "いいえ";
  static String ellipsis = String.fromCharCode(0x2026);
  static const requireVerifyPasscode = "$passcodeの入力が必要です";
  // ホーム
  static const homeTitle = "ホーム";
  static const noMemos = "メモがありません";
  static const homeListMenuDelete = "削除";
  static const homeListMenuClosed = "非公開";
  static const homeListMenuOpened = "公開";
  static const confirmChangeToPublicBody = "このメモを公開しますか";
  static const homeListMenuRegisterTemplate = "テンプレート登録";
  static const confirmToVerifyPasscode = "パスコードを入力しますか";
  // メモ
  static const createMemoTitle = "メモ作成";
  static const createTemplateTitle = "テンプレート作成";
  static const registerTemplateTitle = "テンプレート登録";
  static const writeMemo = "メモを記入する...";
  static const deleteMemoTitle = "メモを削除しますか";
  static const deleteMemoBody = "削除したメモは戻せません";
  static const save = "保存";
  static const overwrite = "上書きする";
  static const addToEnd = "末尾に追記する";
  static const cancel = "キャンセル";
  // 設定
  static const settingsTitle = "設定";
  static const settingsPasscode = passcode;
  static const usePasscode = "$passcodeを使用する";
  static const registerPasscode = "$passcodeを登録する";
  static const settled = "設定済";
  static const unSettled = "未設定";
  static const confirmDisablePasscodeBody = "OFFにしますか";
  static const confirmRegisterPasscode = "パスコードを登録しますか";
  static const requirePasscodeOnLaunch = "起動時にパスコードを必要とする";
  // パスコード
  static const passcode = "パスコード";
  static const inputPasscode = "$passcodeを入力してください";
  static const inputCurrentPasscode = "現在の$inputPasscode";
  static const inputNewPasscode = "新しい$inputPasscode";
  static const confirmPasscode = "$passcodeの確認";
  static const invalidPasscode = "$passcodeが正しくありません";
  static const invalidLengthPasscode = "$passcodeは${AppConfig.passcodeLength}桁で入力してください";
  static const noMatchPasscode = "$passcodeが一致しません";
  // テンプレート
  static const template = "テンプレート";
  static const createTemplate = "$templateを作成する";
  static const editTemplate = "$templateを編集する";
  static const noTemplates = "$templateはありません";
  static const confirmDeleteTemplateTitle = "$templateを削除しますか";
  static const confirmDeleteTemplateBody = "$templateは元に戻せません";
}