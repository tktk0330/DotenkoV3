//
//  TestViews.swift
//  DotenkoV3
//
//  ファイル概要:
//  開発・テスト用の画面コンポーネント
//  - 条件付きコンパイル対応
//  - ナビゲーション機能テスト
//  - 開発ビルドでのみ利用可能
//

import SwiftUI

#if DEBUG || TESTING

// MARK: - Test Screen Views

/// テスト画面1
/// スタック深度テスト用
struct TestView1: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "テスト画面1",
            subtitle: "スタック深度テスト"
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "戻る（Pop）") {
                    navigationManager.pop()
                }
                
                NavigationTestButton(title: "テスト画面3へ（Push）") {
                    navigationManager.push(TestView3())
                }
                
                NavigationTestButton(title: "全画面テストを開く") {
                    fullScreenManager.presentFullScreen(TestFullScreenView())
                }
            }
        }
    }
}

/// テスト画面2
/// ヘルプ画面からの遷移テスト用
struct TestView2: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "テスト画面2",
            subtitle: "ヘルプ画面からの遷移"
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "戻る（Pop）") {
                    navigationManager.pop()
                }
            }
        }
    }
}

/// テスト画面3
/// 最深層テスト用
struct TestView3: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "テスト画面3",
            subtitle: "最深層テスト"
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(title: "戻る（Pop）") {
                    navigationManager.pop()
                }
                
                NavigationTestButton(title: "ルートに戻る（PopToRoot）") {
                    navigationManager.popToRoot()
                }
                
                NavigationTestButton(title: "ホームに置き換え（Replace）") {
                    navigationManager.replace(with: HomeView())
                }
            }
        }
    }
}

/// テスト用全画面ビュー
/// 全画面スタックテスト用
struct TestFullScreenView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Appearance.Colors.primary,
                    Appearance.Colors.secondaryGreen
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                Text("テスト全画面ビュー")
                    .font(Appearance.Fonts.title)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Text("全画面スタックテスト")
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Spacer()
                
                VStack(spacing: Constants.Layout.smallPadding) {
                    NavigationTestButton(title: "マッチング画面に置き換え") {
                        fullScreenManager.replaceFullScreen(with: MatchingView())
                    }
                    
                    NavigationTestButton(title: "設定画面に置き換え") {
                        fullScreenManager.replaceFullScreen(with: GameRuleSettingsView())
                    }
                    
                    NavigationTestButton(title: "閉じる（Dismiss）") {
                        fullScreenManager.dismissFullScreen()
                    }
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
}

#endif

// MARK: - Fallback Views for Release Builds

#if !DEBUG && !TESTING

/// リリースビルド用のフォールバック
/// テスト画面が呼び出された場合の安全な代替表示
struct TestView1: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct TestView2: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct TestView3: View {
    var body: some View {
        Text("この機能は開発ビルドでのみ利用可能です")
            .font(Appearance.Fonts.body)
            .foregroundColor(Appearance.Colors.textSecondary)
    }
}

struct TestFullScreenView: View {
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
    TestView1()
    #else
    Text("テスト画面はリリースビルドでは利用できません")
    #endif
} 