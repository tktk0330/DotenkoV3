//
//  CommonButton.swift
//  DotenkoV3
//
//  ファイル概要:
//  アプリケーション全体で使用される共通ボタンコンポーネント
//  - 統一されたスタイリング
//  - 再利用可能な設計
//

import SwiftUI

// MARK: - Common Button Components

/// 標準的なアクションボタン
/// アプリケーション全体で統一されたスタイリングを提供
struct CommonButton: View {
    let title: String // ボタンタイトル
    let action: () -> Void // タップ時のアクション
    let style: ButtonStyle // ボタンスタイル
    
    /// ボタンスタイルの定義
    enum ButtonStyle {
        case primary // プライマリボタン
        case secondary // セカンダリボタン
        case destructive // 破壊的アクション用
        case navigation // ナビゲーション用（テスト機能）
        
        /// スタイルに応じた背景色
        var backgroundColor: Color {
            switch self {
            case .primary:
                return Appearance.Colors.buttonPrimary
            case .secondary:
                return Appearance.Colors.buttonSecondary
            case .destructive:
                return Appearance.Colors.destructive
            case .navigation:
                return Appearance.Colors.buttonPrimary
            }
        }
        
        /// スタイルに応じたテキスト色
        var textColor: Color {
            switch self {
            case .primary, .navigation:
                return Appearance.Colors.textAccent
            case .secondary:
                return Appearance.Colors.textPrimary
            case .destructive:
                return Appearance.Colors.textOnDestructive
            }
        }
        
        /// スタイルに応じたフォント
        var font: Font {
            switch self {
            case .primary, .secondary, .destructive:
                return Appearance.Fonts.buttonLarge
            case .navigation:
                return Appearance.Fonts.buttonMedium
            }
        }
    }
    
    /// イニシャライザ
    /// - Parameters:
    ///   - title: ボタンタイトル
    ///   - style: ボタンスタイル（デフォルト: .primary）
    ///   - action: タップ時のアクション
    init(title: String, style: ButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style.font)
                .foregroundColor(style.textColor)
                .padding(Constants.Layout.standardPadding)
                .frame(maxWidth: .infinity)
                .background(style.backgroundColor)
                .cornerRadius(Constants.Layout.cornerRadius)
        }
    }
}

// MARK: - Specialized Button Components

/// ナビゲーションテスト用ボタン
/// 開発ビルドでのみ表示される特殊なボタン
struct NavigationTestButton: View {
    let title: String // ボタンタイトル
    let action: () -> Void // タップ時のアクション
    
    var body: some View {
        CommonButton(title: title, style: .navigation, action: action)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: Constants.Layout.standardPadding) {
        CommonButton(title: "プライマリボタン", style: .primary) {
            print("Primary button tapped")
        }
        
        CommonButton(title: "セカンダリボタン", style: .secondary) {
            print("Secondary button tapped")
        }
        
        CommonButton(title: "危険なアクション", style: .destructive) {
            print("Destructive button tapped")
        }
        
        NavigationTestButton(title: "ナビゲーションテスト") {
            print("Navigation test button tapped")
        }
    }
    .padding()
} 