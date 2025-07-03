//
//  SettingsView.swift
//  DotenkoV3
//
//  ファイル概要:
//  アプリケーションの設定画面
//  - アプリケーション設定
//  - ユーザー設定
//  - システム設定
//

import SwiftUI

/// 設定画面
/// アプリケーションの各種設定を管理する画面
struct SettingsView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "設定画面",
            subtitle: "アプリケーション設定"
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
            CommonButton(title: "戻る") {
                navigationManager.pop()
            }
            
            // 今後追加される本番機能のボタンをここに配置
            // 例: 通知設定、プライバシー設定、アカウント設定など
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
            
            NavigationTestButton(title: "ヘルプ画面へ（Push）") {
                navigationManager.push(HelpView())
            }
            
            NavigationTestButton(title: "ルートに戻る（PopToRoot）") {
                navigationManager.popToRoot()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
} 