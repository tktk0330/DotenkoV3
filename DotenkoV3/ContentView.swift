//
//  ContentView.swift
//  DotenkoV3
//
//  ファイル概要: AdMobバナー広告テスト用のメイン画面
//  シンプルな構成でバナー広告の動作確認を行う
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    var body: some View {
        VStack {
            // メインコンテンツエリア
            VStack(spacing: 20) {
                Text("AdMob テスト")
                    .font(.largeTitle)
                    .padding()
                
                Text("バナー広告の動作確認")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // テスト用コンテンツ
                VStack(spacing: 10) {
                    Text("広告表示テスト中...")
                        .font(.body)
                    
                    Text("画面下部にバナー広告が表示されます")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // AdMobバナー広告
            AdMobBannerView()
                .frame(height: 60)
        }
        .ignoresSafeArea(.container, edges: .bottom) // 広告エリアを画面下端に固定
    }
}

// MARK: - AdMobバナー広告View
struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSizeBanner)
        
        // Config.swiftからAd Unit IDを参照
        bannerView.adUnitID = Config.bannerID
        
        // ルートビューコントローラーを設定
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            bannerView.rootViewController = rootViewController
        }
        
        // 広告リクエスト
        let request = Request()
        bannerView.load(request)
        
        return bannerView
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {
        // 更新処理は特に不要
    }
}

#Preview {
    ContentView()
}
