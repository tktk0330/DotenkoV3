//
//  HomeView.swift
//  DotenkoV3
//
//  ファイル概要:
//  アプリケーションのホーム画面
//  - メインエントリーポイント
//  - 各機能への導線
//  - 開発ビルドでのテスト機能
//

import SwiftUI

/// ホーム画面
/// アプリケーションのメインエントリーポイントとなる画面
struct HomeView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "ホーム画面",
            subtitle: "DOTENKO"
        ) {
            VStack(spacing: Constants.Layout.smallPadding) {
                // 本番機能のボタン群
                productionButtons
                
                // 開発ビルドでのみテスト機能を表示
                if Constants.enableTestUI {
                    testButtons
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    /// 本番機能のボタン群
    @ViewBuilder
    private var productionButtons: some View {
        Group {
            CommonButton(title: "ヘルプ") {
                navigationManager.push(HelpView())
            }
            
            CommonButton(title: "設定") {
                navigationManager.push(SettingsView())
            }
            
            // 今後追加される本番機能のボタンをここに配置
        }
    }
    
    /// テスト機能のボタン群（開発ビルドでのみ表示）
    @ViewBuilder
    private var testButtons: some View {
        Group {
            // セクション区切り
            Divider()
                .padding(.vertical, Constants.Layout.smallPadding)
            
            Text("テスト機能")
                .font(Appearance.Fonts.caption)
                .foregroundColor(Appearance.Colors.textSecondary)
            
            // 通常画面遷移テスト
            NavigationTestButton(title: "テスト画面1へ（Push）") {
                navigationManager.push(TestView1())
            }
            
            // 全画面遷移テスト
            NavigationTestButton(title: "マッチング画面（全画面）") {
                fullScreenManager.presentFullScreen(MatchingView())
            }
            
            NavigationTestButton(title: "ゲーム画面（全画面）") {
                fullScreenManager.presentFullScreen(GameView())
            }
            
            NavigationTestButton(title: "設定モーダル（全画面）") {
                fullScreenManager.presentFullScreen(GameRuleSettingsView())
            }
            
            // スタック操作テスト
            NavigationTestButton(title: "ルートに戻る（PopToRoot）") {
                navigationManager.popToRoot()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
} 