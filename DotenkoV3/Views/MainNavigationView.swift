//
//  MainNavigationView.swift
//  DotenkoV3
//
//  ファイル概要:
//  アプリケーション全体のメインナビゲーションを管理するルートビュー
//  - 通常画面とフルスクリーン画面の切り替え制御
//  - バナー広告の統合配置
//  - 各画面へのルーティング処理
//

import SwiftUI
// TODO: 広告実装時にコメントを解除
// import GoogleMobileAds
/// アプリケーションのメインナビゲーションView
struct MainNavigationView: View {
    
    // MARK: - Environment Objects
    
    @StateObject private var navigationManager = NavigationStateManager.shared
    @StateObject private var fullScreenManager = NavigationAllViewStateManager.shared
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景色（全画面共通）
                Appearance.Colors.backgroundPrimary
                    .ignoresSafeArea()
                
                // メインコンテンツエリア
                VStack(spacing: 0) {
                    // 上部コンテンツエリア
                    contentArea
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: geometry.size.height - Constants.Layout.bannerAdHeight
                        )
                    
                    // バナー広告（全画面固定表示）
                    // AdMobBannerView()
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: Constants.Layout.bannerAdHeight)
                        .overlay(
                            Text("広告エリア")
                                .font(.caption)
                                .foregroundColor(.gray)
                        )
                }
                
                // 全画面モーダル表示
                if fullScreenManager.isFullScreenPresented,
                   let fullScreenView = fullScreenManager.currentFullScreenView {
                    fullScreenView.view
                        .transition(.opacity.combined(with: .scale))
                        .zIndex(1000)
                }
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear {
            setupInitialView()
        }
    }
    
    // MARK: - Computed Properties
    
    /// メインコンテンツエリア
    @ViewBuilder
    private var contentArea: some View {
        if let currentView = navigationManager.viewStack.last {
            // 現在のビュースタックの最上位を表示
            currentView.view
        } else {
            // スタックが空の場合のフォールバック表示
            // 初期化処理完了まで空の状態を表示
            Color.clear
        }
    }
    
    // MARK: - Private Methods
    
    /// 初期ビューの設定
    private func setupInitialView() {
        // ホーム画面を初期表示として設定
        // スタックが空の場合のみホーム画面をプッシュ
        if navigationManager.viewStack.isEmpty {
            navigationManager.push(createHomeView(), animated: false)
        }
    }
    
    // MARK: - View Factories
    
    /// ホーム画面の作成
    @ViewBuilder
    private func createHomeView() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("ホーム画面")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("DOTENKO")
                .font(Appearance.Fonts.largeTitle)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            // 画面遷移テスト用ボタン群
            VStack(spacing: Constants.Layout.smallPadding) {
                // 通常画面遷移テスト
                Group {
                    NavigationTestButton(
                        title: "ヘルプ画面へ（Push）",
                        action: {
                            navigationManager.push(createHelpView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "設定画面へ（Push）",
                        action: {
                            navigationManager.push(createSettingsView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "テスト画面1へ（Push）",
                        action: {
                            navigationManager.push(createTestView1())
                        }
                    )
                }
                
                // 全画面遷移テスト
                Group {
                    NavigationTestButton(
                        title: "マッチング画面（全画面）",
                        action: {
                            fullScreenManager.presentFullScreen(createMatchingView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "ゲーム画面（全画面）",
                        action: {
                            fullScreenManager.presentFullScreen(createGameView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "設定モーダル（全画面）",
                        action: {
                            fullScreenManager.presentFullScreen(createGameRuleSettingsView())
                        }
                    )
                }
                
                // スタック操作テスト
                Group {
                    NavigationTestButton(
                        title: "ルートに戻る（PopToRoot）",
                        action: {
                            navigationManager.popToRoot()
                        }
                    )
                    
                    NavigationTestButton(
                        title: "デバッグ：スタック状態表示",
                        action: {
                            navigationManager.printStackState()
                            fullScreenManager.printFullScreenState()
                        }
                    )
                }
            }
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// ヘルプ画面の作成
    @ViewBuilder
    private func createHelpView() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("ヘルプ画面")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("通常画面遷移テスト")
                .font(Appearance.Fonts.headline)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(
                    title: "戻る（Pop）",
                    action: {
                        navigationManager.pop()
                    }
                )
                
                NavigationTestButton(
                    title: "テスト画面2へ（Push）",
                    action: {
                        navigationManager.push(createTestView2())
                    }
                )
                
                NavigationTestButton(
                    title: "ホームに置き換え（Replace）",
                    action: {
                        navigationManager.replace(with: createHomeView())
                    }
                )
            }
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// 設定画面の作成
    @ViewBuilder
    private func createSettingsView() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("設定画面")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("通常画面遷移テスト")
                .font(Appearance.Fonts.headline)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(
                    title: "戻る（Pop）",
                    action: {
                        navigationManager.pop()
                    }
                )
                
                NavigationTestButton(
                    title: "ヘルプ画面へ（Push）",
                    action: {
                        navigationManager.push(createHelpView())
                    }
                )
                
                NavigationTestButton(
                    title: "ルートに戻る（PopToRoot）",
                    action: {
                        navigationManager.popToRoot()
                    }
                )
            }
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// テスト画面1の作成
    @ViewBuilder
    private func createTestView1() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("テスト画面1")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("スタック深度テスト")
                .font(Appearance.Fonts.headline)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(
                    title: "戻る（Pop）",
                    action: {
                        navigationManager.pop()
                    }
                )
                
                NavigationTestButton(
                    title: "テスト画面3へ（Push）",
                    action: {
                        navigationManager.push(createTestView3())
                    }
                )
                
                NavigationTestButton(
                    title: "全画面テストを開く",
                    action: {
                        fullScreenManager.presentFullScreen(createTestFullScreenView())
                    }
                )
            }
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// テスト画面2の作成
    @ViewBuilder
    private func createTestView2() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("テスト画面2")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("ヘルプ画面からの遷移")
                .font(Appearance.Fonts.headline)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            NavigationTestButton(
                title: "戻る（Pop）",
                action: {
                    navigationManager.pop()
                }
            )
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// テスト画面3の作成
    @ViewBuilder
    private func createTestView3() -> some View {
        VStack(spacing: Constants.Layout.standardPadding) {
            Text("テスト画面3")
                .font(Appearance.Fonts.title)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Text("最深層テスト")
                .font(Appearance.Fonts.headline)
                .foregroundColor(Appearance.Colors.textPrimary)
            
            Spacer()
            
            VStack(spacing: Constants.Layout.smallPadding) {
                NavigationTestButton(
                    title: "戻る（Pop）",
                    action: {
                        navigationManager.pop()
                    }
                )
                
                NavigationTestButton(
                    title: "ルートに戻る（PopToRoot）",
                    action: {
                        navigationManager.popToRoot()
                    }
                )
                
                NavigationTestButton(
                    title: "ホームに置き換え（Replace）",
                    action: {
                        navigationManager.replace(with: createHomeView())
                    }
                )
            }
            
            Spacer()
        }
        .padding(Constants.Layout.standardPadding)
    }
    
    /// マッチング画面の作成
    @ViewBuilder
    private func createMatchingView() -> some View {
        ZStack {
            Appearance.Colors.backgroundDeepGreen
                .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                Text("マッチング画面")
                    .font(Appearance.Fonts.title)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Text("全画面表示テスト")
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Spacer()
                
                VStack(spacing: Constants.Layout.smallPadding) {
                    NavigationTestButton(
                        title: "ゲーム画面に置き換え",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createGameView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "結果画面に置き換え",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createResultView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "閉じる（Dismiss）",
                        action: {
                            fullScreenManager.dismissFullScreen()
                        }
                    )
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// ゲーム画面の作成
    @ViewBuilder
    private func createGameView() -> some View {
        ZStack {
            Appearance.Colors.backgroundDeepGreen
                .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                Text("ゲーム画面")
                    .font(Appearance.Fonts.title)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Text("全画面表示テスト")
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Spacer()
                
                VStack(spacing: Constants.Layout.smallPadding) {
                    NavigationTestButton(
                        title: "結果画面に置き換え",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createResultView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "マッチング画面に戻る",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createMatchingView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "ホームに戻る（Dismiss）",
                        action: {
                            fullScreenManager.dismissFullScreen()
                        }
                    )
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// 結果画面の作成
    @ViewBuilder
    private func createResultView() -> some View {
        ZStack {
            Appearance.Colors.backgroundSecondary
                .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                Text("結果画面")
                    .font(Appearance.Fonts.title)
                    .foregroundColor(Appearance.Colors.textSecondary)
                
                Text("全画面表示テスト")
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textSecondary)
                
                Spacer()
                
                VStack(spacing: Constants.Layout.smallPadding) {
                    NavigationTestButton(
                        title: "もう一度ゲーム",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createGameView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "ホームに戻る（Dismiss）",
                        action: {
                            fullScreenManager.dismissFullScreen()
                        }
                    )
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// ゲームルール設定画面の作成
    @ViewBuilder
    private func createGameRuleSettingsView() -> some View {
        ZStack {
            Appearance.Colors.backgroundModal
                .ignoresSafeArea()
            
            VStack(spacing: Constants.Layout.standardPadding) {
                Text("ゲームルール設定")
                    .font(Appearance.Fonts.title)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Text("全画面モーダルテスト")
                    .font(Appearance.Fonts.headline)
                    .foregroundColor(Appearance.Colors.textPrimary)
                
                Spacer()
                
                VStack(spacing: Constants.Layout.smallPadding) {
                    NavigationTestButton(
                        title: "ゲーム開始画面に移動",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createMatchingView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "設定完了（Dismiss）",
                        action: {
                            fullScreenManager.dismissFullScreen()
                        }
                    )
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
    
    /// テスト用全画面ビューの作成
    @ViewBuilder
    private func createTestFullScreenView() -> some View {
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
                    NavigationTestButton(
                        title: "マッチング画面に置き換え",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createMatchingView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "設定画面に置き換え",
                        action: {
                            fullScreenManager.replaceFullScreen(with: createGameRuleSettingsView())
                        }
                    )
                    
                    NavigationTestButton(
                        title: "全画面状態をデバッグ表示",
                        action: {
                            fullScreenManager.printFullScreenState()
                        }
                    )
                    
                    NavigationTestButton(
                        title: "閉じる（Dismiss）",
                        action: {
                            fullScreenManager.dismissFullScreen()
                        }
                    )
                }
                
                Spacer()
            }
            .padding(Constants.Layout.standardPadding)
        }
    }
}

// MARK: - Supporting Views

/// ナビゲーションテスト用ボタン
struct NavigationTestButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Appearance.Fonts.buttonMedium)
                .foregroundColor(Appearance.Colors.textAccent)
                .padding(Constants.Layout.standardPadding)
                .frame(maxWidth: .infinity)
                .background(Appearance.Colors.buttonPrimary)
                .cornerRadius(Constants.Layout.cornerRadius)
        }
    }
}

// MARK: - AdMobバナー広告View（一時的にコメントアウト）
/*
struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        
        // Config.swiftからAd Unit IDを参照
        bannerView.adUnitID = Config.bannerID
        
        // ルートビューコントローラーを設定
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            bannerView.rootViewController = rootViewController
        }
        
        // 広告リクエスト
        let request = GADRequest()
        bannerView.load(request)
        
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // 更新処理は特に不要
    }
}
*/

// MARK: - Preview

#Preview {
    MainNavigationView()
} 
