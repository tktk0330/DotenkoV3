#!/bin/bash

# GitHub Secrets設定用ヘルパースクリプト
# 機密ファイルをBase64エンコードしてGitHub Secretsに設定するためのスクリプト

set -e

echo "🔐 GitHub Secrets設定ヘルパースクリプト"
echo "=================================="

# 色付きメッセージ用の関数
print_success() {
    echo "✅ $1"
}

print_warning() {
    echo "⚠️  $1"
}

print_error() {
    echo "❌ $1"
}

print_info() {
    echo "ℹ️  $1"
}

# Base64エンコード関数
encode_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        base64 -i "$file_path" | tr -d '\n'
    else
        print_error "ファイルが見つかりません: $file_path"
        return 1
    fi
}

echo ""
echo "📋 設定する必要があるGitHub Secrets:"
echo ""

# 1. Config.swiftのエンコード
CONFIG_SWIFT_PATH="DotenkoV3/Config/Config.swift"
if [ -f "$CONFIG_SWIFT_PATH" ]; then
    CONFIG_SWIFT_ENCODED=$(encode_file "$CONFIG_SWIFT_PATH")
    print_success "Config.swiftをエンコードしました"
    echo ""
    echo "🔑 Secret名: CONFIG_BASE64"
    echo "📄 値:"
    echo "$CONFIG_SWIFT_ENCODED"
    echo ""
    echo "---"
else
    print_warning "Config.swiftが見つかりません: $CONFIG_SWIFT_PATH"
fi

# 2. Info.plistのエンコード
INFO_PLIST_PATH="DotenkoV3/Info.plist"
if [ -f "$INFO_PLIST_PATH" ]; then
    INFO_PLIST_ENCODED=$(encode_file "$INFO_PLIST_PATH")
    print_success "Info.plistをエンコードしました"
    echo ""
    echo "🔑 Secret名: INFO_PLIST_BASE64"
    echo "📄 値:"
    echo "$INFO_PLIST_ENCODED"
    echo ""
    echo "---"
else
    print_warning "Info.plistが見つかりません: $INFO_PLIST_PATH"
fi

# 3. GoogleService-Info.plistのエンコード
GOOGLE_SERVICE_PLIST_PATH="DotenkoV3/GoogleService-Info.plist"
if [ -f "$GOOGLE_SERVICE_PLIST_PATH" ]; then
    GOOGLE_SERVICE_PLIST_ENCODED=$(encode_file "$GOOGLE_SERVICE_PLIST_PATH")
    print_success "GoogleService-Info.plistをエンコードしました"
    echo ""
    echo "🔑 Secret名: GOOGLE_SERVICE_INFO_PLIST_BASE64"
    echo "📄 値:"
    echo "$GOOGLE_SERVICE_PLIST_ENCODED"
    echo ""
    echo "---"
else
    print_warning "GoogleService-Info.plistが見つかりません: $GOOGLE_SERVICE_PLIST_PATH"
    print_info "Firebaseプロジェクトから取得して配置してください"
fi

echo ""
echo "📝 その他の設定が必要なSecrets:"
echo ""
echo "🔑 Secret名: SLACK_WEBHOOK_URL (オプション)"
echo "📄 説明: テスト失敗時の通知用SlackWebhook URL"
echo ""
echo "ℹ️ Firebase・AdMob設定はConfig.swiftで管理されています"
echo ""

echo "=================================="
echo "📋 GitHub Secretsの設定手順:"
echo ""
echo "1. GitHubリポジトリのSettings > Secrets and variables > Actions に移動"
echo "2. 'New repository secret' をクリック"
echo "3. 上記のSecret名と値を設定"
echo "4. 各Secretを保存"
echo ""
echo "🔗 参考: https://docs.github.com/en/actions/security-guides/encrypted-secrets"
echo ""

# GitHub CLI がインストールされている場合の自動設定オプション
if command -v gh &> /dev/null; then
    echo "🤖 GitHub CLI が検出されました"
    echo ""
        # Config.swift
        if [ -f "$CONFIG_SWIFT_PATH" ] && [ -n "$CONFIG_SWIFT_ENCODED" ]; then
            if echo "$CONFIG_SWIFT_ENCODED" | gh secret set CONFIG_BASE64 --body=-; then
                print_success "CONFIG_BASE64 を設定しました"
            else
                print_error "CONFIG_BASE64 の設定に失敗しました"
                exit 1
            fi
        fi
else
    print_info "GitHub CLI をインストールすると、Secretsの自動設定が可能です"
    print_info "インストール: https://cli.github.com/"
fi

echo ""
echo "🎉 設定完了後、GitHub Actionsでテストを実行してください"
echo "🔍 ワークフローログで機密ファイルの復元状況を確認できます" 