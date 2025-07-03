//
//  HelpView.swift
//  DotenkoV3
//
//  ファイル概要:
//  アプリケーションのヘルプ画面
//  - 使い方の説明
//  - よくある質問
//  - サポート情報
//

import SwiftUI

/// ヘルプ画面
/// アプリケーションの使い方やサポート情報を表示する画面
struct HelpView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        BaseScreenView(
            title: "ヘルプ画面",
            subtitle: "使い方とサポート"
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
            // 例: FAQ、お問い合わせ、チュートリアルなど
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
            
            NavigationTestButton(title: "テスト画面2へ（Push）") {
                navigationManager.push(TestView2())
            }
            
            NavigationTestButton(title: "ホームに置き換え（Replace）") {
                navigationManager.replace(with: HomeView())
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HelpView()
} 