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
                    bannerAdArea
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
    
    /// バナー広告エリア
    @ViewBuilder
    private var bannerAdArea: some View {
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
    
    // MARK: - Private Methods
    
    /// 初期ビューの設定
    private func setupInitialView() {
        // ホーム画面を初期表示として設定
        // スタックが空の場合のみホーム画面をプッシュ
        if navigationManager.viewStack.isEmpty {
            navigationManager.push(HomeView(), animated: false)
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
