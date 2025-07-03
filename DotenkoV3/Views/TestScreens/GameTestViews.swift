//
//  GameTestViews.swift
//  DotenkoV3
//
//  ファイル概要:
//  ゲーム関連のテスト用画面コンポーネント
//  - 条件付きコンパイル対応
//  - 全画面表示機能テスト
//  - 開発ビルドでのみ利用可能
//

import SwiftUI

#if DEBUG || TESTING

// MARK: - Game Test Views

/// マッチング画面
/// 全画面表示テスト用
struct MatchingView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseFullScreenView(
            title: "マッチング画面",
            subtitle: "全画面表示テスト",
            backgroundColor: Appearance.Colors.backgroundDeepGreen
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "ゲーム画面に置き換え") {
                    fullScreenManager.replaceFullScreen(with: GameView())
                }
                
                NavigationTestButton(title: "結果画面に置き換え") {
                    fullScreenManager.replaceFullScreen(with: ResultView())
                }
                
                NavigationTestButton(title: "閉じる（Dismiss）") {
                    fullScreenManager.dismissFullScreen()
                }
            }
        }
    }
}

/// ゲーム画面
/// 全画面表示テスト用
struct GameView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseFullScreenView(
            title: "ゲーム画面",
            subtitle: "全画面表示テスト",
            backgroundColor: Appearance.Colors.backgroundDeepGreen
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "結果画面に置き換え") {
                    fullScreenManager.replaceFullScreen(with: ResultView())
                }
                
                NavigationTestButton(title: "マッチング画面に戻る") {
                    fullScreenManager.replaceFullScreen(with: MatchingView())
                }
                
                NavigationTestButton(title: "ホームに戻る（Dismiss）") {
                    fullScreenManager.dismissFullScreen()
                }
            }
        }
    }
}

/// 結果画面
/// 全画面表示テスト用
struct ResultView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseFullScreenView(
            title: "結果画面",
            subtitle: "全画面表示テスト",
            backgroundColor: Appearance.Colors.backgroundSecondary
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "もう一度ゲーム") {
                    fullScreenManager.replaceFullScreen(with: GameView())
                }
                
                NavigationTestButton(title: "ホームに戻る（Dismiss）") {
                    fullScreenManager.dismissFullScreen()
                }
            }
        }
    }
}

/// ゲームルール設定画面
/// 全画面モーダルテスト用
struct GameRuleSettingsView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseFullScreenView(
            title: "ゲームルール設定",
            subtitle: "全画面モーダルテスト",
            backgroundColor: Appearance.Colors.backgroundModal
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "ゲーム開始画面に移動") {
                    fullScreenManager.replaceFullScreen(with: MatchingView())
                }
                
                NavigationTestButton(title: "設定完了（Dismiss）") {
                    fullScreenManager.dismissFullScreen()
                }
            }
        }
    }
}

#endif

// MARK: - Fallback Views for Release Builds

#if !DEBUG && !TESTING

/// リリースビルド用のフォールバック
/// ゲーム画面が呼び出された場合の安全な代替表示
struct MatchingView: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct GameView: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct ResultView: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct GameRuleSettingsView: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

#endif

// MARK: - Preview

#Preview {
    #if DEBUG || TESTING
    MatchingView()
    #else
    Text("ゲーム画面はリリースビルドでは利用できません")
    #endif
} 