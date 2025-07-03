//
//  BaseScreenView.swift
//  DotenkoV3
//
//  ファイル概要:
//  画面の共通レイアウトパターンを提供する基底ビューコンポーネント
//  - 標準的なVStackレイアウト
//  - 共通のスタイリング
//  - 再利用可能な設計
//

import SwiftUI

// MARK: - Base Screen Components

/// 標準的な画面レイアウトの基底ビュー
/// 共通のレイアウトパターンを提供し、重複を削減
struct BaseScreenView<Content: View>: View {
    let title: String // 画面タイトル
    let subtitle: String? // サブタイトル（オプション）
    let backgroundColor: Color // 背景色
    let content: Content // 画面固有のコンテンツ
    
    /// イニシャライザ
    /// - Parameters:
    ///   - title: 画面タイトル
    ///   - subtitle: サブタイトル（オプション）
    ///   - backgroundColor: 背景色（デフォルト: 透明）
    ///   - content: 画面固有のコンテンツ
    init(
        title: String,
        subtitle: String? = nil,
        backgroundColor: Color = Color.clear,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // 背景色の設定
            if backgroundColor != Color.clear {
                backgroundColor
                    .ignoresSafeArea()
            }
            
            VStack(spacing: Constants.Layout.standardPadding) {
                // ヘッダー部分
                headerSection
                
                Spacer()
                
                // メインコンテンツ
                content
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// ヘッダーセクション
    @ViewBuilder
    private var headerSection: some View {
        VStack(spacing: Constants.Layout.smallPadding) {
            Text(title)
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
            }
        }
    }
}

/// 全画面表示用の基底ビュー
/// モーダルや全画面表示に特化したレイアウト
struct BaseFullScreenView<Content: View>: View {
    let title: String // 画面タイトル
    let subtitle: String? // サブタイトル（オプション）
    let backgroundColor: Color // 背景色
    let content: Content // 画面固有のコンテンツ
    
    /// イニシャライザ
    /// - Parameters:
    ///   - title: 画面タイトル
    ///   - subtitle: サブタイトル（オプション）
    ///   - backgroundColor: 背景色
    ///   - content: 画面固有のコンテンツ
    init(
        title: String,
        subtitle: String? = nil,
        backgroundColor: Color,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                // ヘッダー部分
                headerSection
                
                Spacer()
                
                // メインコンテンツ
                content
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// ヘッダーセクション
    @ViewBuilder
    private var headerSection: some View {
        VStack(spacing: Constants.Layout.smallPadding) {
            Text(title)
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    BaseScreenView(
        title: "サンプル画面",
        subtitle: "基底ビューのテスト"
    ) {
        VStack(spacing: Constants.Layout.smallPadding) {
            CommonButton(title: "ボタン1") {
                print("Button 1 tapped")
            }
            
            CommonButton(title: "ボタン2") {
                print("Button 2 tapped")
            }
        }
    }
} 