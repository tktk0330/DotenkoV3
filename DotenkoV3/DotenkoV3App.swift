//
//  DotenkoV3App.swift
//  DotenkoV3
//
//  ファイル概要: DOTENKOアプリのメインエントリーポイント
//  AdMobテスト用のシンプルな構成
//

import SwiftUI
import GoogleMobileAds

@main
struct DotenkoV3App: App {
    
    // MARK: - Initialization
    init() {
        // AdMob初期化（Config.swiftから設定値を参照）
        MobileAds.shared.start(completionHandler: nil)
        print("AdMob initialized successfully with App ID: \(Config.appID)")
        
        // 縦画面固定設定（Info.plistでも設定済み）
        setupOrientation()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light) // ライトモード固定
        }
    }
    
    // MARK: - Private Methods
    
    /// 画面向き設定
    private func setupOrientation() {
        // 縦画面固定はInfo.plistで設定
        print("Orientation set to Portrait only")
    }
}
