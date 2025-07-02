# GitHub Secrets設定ガイド

このドキュメントでは、DotenkoV3プロジェクトの機密ファイルをGitHub Secretsで管理する方法を説明します。

## 概要

以下の機密ファイルをGitHub Secretsで管理し、GitHub Actions実行時に自動復元します：

- `DotenkoV3/Config/Config.swift` - アプリ設定情報（AdMob設定を含む）
- `DotenkoV3/Info.plist` - iOS基本設定情報
- `DotenkoV3/GoogleService-Info.plist` - Firebase設定情報

**重要**: AdMob設定は`Config.swift`で管理されていますが、Firebase連携には`GoogleService-Info.plist`が必要です。

## 設定手順

### 1. 自動設定スクリプトの実行

```bash
./scripts/setup-secrets.sh
```

このスクリプトは以下の処理を行います：
- 機密ファイルのBase64エンコード
- GitHub CLI使用時の自動Secret設定
- 手動設定用の値表示

### 2. 手動でのGitHub Secrets設定

GitHub CLI がない場合は、以下の手順で手動設定してください：

1. GitHubリポジトリの **Settings** > **Secrets and variables** > **Actions** に移動
2. **New repository secret** をクリック
3. 以下のSecretsを設定：

#### 必須Secrets

| Secret名 | 説明 | 取得方法 |
|---------|------|---------|
| `CONFIG_BASE64` | Config.swiftのBase64エンコード値 | スクリプトで出力される値を使用 |
| `INFO_PLIST_BASE64` | Info.plistのBase64エンコード値 | スクリプトで出力される値を使用 |
| `GOOGLE_SERVICE_INFO_PLIST_BASE64` | GoogleService-Info.plistのBase64エンコード値 | スクリプトで出力される値を使用 |

#### オプションSecrets

| Secret名 | 説明 |
|---------|------|
| `SLACK_WEBHOOK_URL` | テスト失敗時の通知用Slack Webhook URL |

### 3. Firebase設定ファイルの取得

`GoogleService-Info.plist`をFirebaseコンソールから取得してください：

1. [Firebase Console](https://console.firebase.google.com/) にアクセス
2. プロジェクトを選択
3. **Project Settings** > **General** > **Your apps**
4. iOSアプリの設定から `GoogleService-Info.plist` をダウンロード
5. `DotenkoV3/GoogleService-Info.plist` に配置
6. スクリプトを再実行してSecretsを更新

### 4. AdMob設定の取得

AdMob IDをGoogle AdMobコンソールから取得してください：

1. [AdMob Console](https://apps.admob.com/) にアクセス
2. アプリを選択
3. **App settings** でアプリケーションID（`ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx`）を確認
4. **Ad units** でバナー広告ID（`ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx`）を確認

## GitHub Actions での動作

### 機密ファイル復元プロセス

1. **Checkout**: リポジトリのコードを取得
2. **Restore Secret Files**: 
   - GitHub SecretsからBase64値を取得
   - Base64デコードしてファイルを復元
   - 環境変数を使用してID値を置換
   - ダミーファイル作成（Secretsが未設定の場合）
3. **Build & Test**: 通常のビルド・テスト実行
4. **Cleanup**: 機密ファイルを削除（セキュリティ確保）

### ログでの確認方法

GitHub Actionsのログで以下のメッセージを確認できます：

```
✅ Config.swift restored from secrets
✅ Info.plist restored from secrets
✅ GoogleService-Info.plist restored from secrets
ℹ️ AdMob設定はConfig.swiftで管理されています
```

## セキュリティ考慮事項

### 機密ファイルの保護

- 機密ファイルは`.gitignore`で除外済み
- GitHub Actionsでは実行後に自動削除
- Base64エンコードによる安全な保存

### アクセス制御

- Repository SecretsはリポジトリのCollaboratorのみアクセス可能
- Organization Secretsを使用する場合は適切なアクセスポリシーを設定

## トラブルシューティング

### よくある問題

#### 1. ファイルが見つからないエラー
```
⚠️ CONFIG_BASE64 secret not found
⚠️ INFO_PLIST_BASE64 secret not found, using existing file
⚠️ GOOGLE_SERVICE_INFO_PLIST_BASE64 secret not found
```
**解決方法**: GitHub SecretsにBase64エンコード値を設定してください

#### 2. Base64デコードエラー
```
❌ Failed to decode secret file
```
**解決方法**: Base64エンコード値が正しいか確認し、改行文字が含まれていないことを確認

### デバッグ方法

1. GitHub Actionsのログを確認
2. "Restore Secret Files" ステップの出力を確認
3. 必要に応じてスクリプトを再実行

## 参考リンク

- [GitHub Docs - Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Firebase Console](https://console.firebase.google.com/)
- [Google AdMob Console](https://apps.admob.com/)
- [GitHub CLI](https://cli.github.com/)

## 更新履歴

- 2025-01-27: 初版作成
- GitHub Secrets対応の実装完了 