//
//  DotenkoV3Tests.swift
//  DotenkoV3Tests
//
//  NavigationManagerとNavigationAllViewStateManagerの単体テスト
//  SwiftTestingフレームワークを使用
//

import Testing
import SwiftUI
@testable import DotenkoV3

@MainActor
struct NavigationManagerTests {
    
    var navigationManager: NavigationStateManager
    var fullScreenManager: NavigationAllViewStateManager
    
    init() {
        navigationManager = NavigationStateManager.shared
        fullScreenManager = NavigationAllViewStateManager.shared
    }
    
    // MARK: - Helper Methods
    
    /// 全画面表示を完全にリセットするヘルパーメソッド
    /// 内部スタックが空になるまで繰り返しdismissを実行
    private func resetFullScreenCompletely() async {
        // 最大10回まで試行（無限ループ防止）
        for _ in 0..<10 {
            if !fullScreenManager.isFullScreenPresented {
                break
            }
            fullScreenManager.dismissFullScreen(animated: false)
            // CI環境でも安定するように待機時間を長めに設定
            try? await Task.sleep(for: .milliseconds(150))
        }
        
        // 遷移状態が完了するまで待機
        for _ in 0..<10 {
            if !fullScreenManager.isTransitioning {
                break
            }
            try? await Task.sleep(for: .milliseconds(150))
        }
        
        // 最終的な状態確認のための追加待機
        try? await Task.sleep(for: .milliseconds(100))
    }
    
    /// ナビゲーション状態を安定化させるヘルパーメソッド
    /// 非同期処理の完了を確実に待機
    private func waitForNavigationStability() async {
        // ナビゲーション状態の安定化を待つ
        for _ in 0..<10 {
            if !navigationManager.isNavigating {
                break
            }
            try? await Task.sleep(for: .milliseconds(100))
        }
        
        // 追加の安定化待機（CI環境対応）
        try? await Task.sleep(for: .milliseconds(150))
    }
    
    // MARK: - Core Navigation Tests (主要機能のみ)
    
    @Test("Push操作のテスト")
    func pushOperation() async {
        // 初期化
        navigationManager.resetToInitial()
        await waitForNavigationStability()
        
        let testView = Text("Test View")
        
        // Push操作を実行
        navigationManager.push(testView, animated: false)
        await waitForNavigationStability()
        
        // スタックに追加されたことを確認
        #expect(navigationManager.viewStack.count >= 1, "Pushでスタックに追加される")
    }
    
    @Test("Replace操作のテスト")
    func replaceOperation() async {
        // 初期化
        navigationManager.resetToInitial()
        await waitForNavigationStability()
        
        let firstView = Text("First View")
        let replacementView = Text("Replacement View")
        
        // 最初にPush
        navigationManager.push(firstView, animated: false)
        await waitForNavigationStability()
        let initialCount = navigationManager.viewStack.count
        
        // Replace操作
        navigationManager.replace(with: replacementView, animated: false)
        await waitForNavigationStability()
        
        // スタック数は変わらない
        #expect(navigationManager.viewStack.count == initialCount, "Replaceでスタック数は変わらない")
    }
    
    // MARK: - Full Screen Tests (全画面機能)
    
    @Test("全画面表示のPresentFullScreen操作テスト")
    func presentFullScreenOperation() async {
        // 初期化
        await resetFullScreenCompletely()
        
        let testView = Text("Full Screen Test View")
        
        // 全画面表示
        fullScreenManager.presentFullScreen(testView, animated: false)
        // 全画面表示の安定化を待つ
        try? await Task.sleep(for: .milliseconds(200))
        
        #expect(fullScreenManager.currentFullScreenView != nil, "全画面ビューが設定される")
        #expect(fullScreenManager.isFullScreenPresented == true, "全画面表示フラグがtrueになる")
        
        // テスト終了時のクリーンアップ
        await resetFullScreenCompletely()
    }
    
    @Test("全画面表示のReplaceFullScreen操作テスト")
    func replaceFullScreenOperation() async {
        // 初期化
        await resetFullScreenCompletely()
        
        let firstView = Text("First Full Screen View")
        let replacementView = Text("Replacement Full Screen View")
        
        // 最初の全画面表示
        fullScreenManager.presentFullScreen(firstView, animated: false)
        try? await Task.sleep(for: .milliseconds(200))
        #expect(fullScreenManager.currentFullScreenView != nil, "最初の全画面ビューが表示される")
        #expect(fullScreenManager.isFullScreenPresented == true, "全画面表示フラグがtrueになる")
        
        // 置き換え（replaceFullScreenはisFullScreenPresentedを変更しない）
        fullScreenManager.replaceFullScreen(with: replacementView, animated: false)
        try? await Task.sleep(for: .milliseconds(200))
        #expect(fullScreenManager.currentFullScreenView != nil, "置き換え後も全画面ビューが表示される")
        #expect(fullScreenManager.isFullScreenPresented == true, "全画面表示フラグは変わらない")
        
        // テスト終了時のクリーンアップ
        await resetFullScreenCompletely()
    }
    
    // MARK: - Integration Tests (統合テスト)
    
    @Test("通常画面と全画面の連携テスト")
    func navigationAndFullScreenIntegration() async {
        // 初期化
        navigationManager.resetToInitial()
        await resetFullScreenCompletely()
        await waitForNavigationStability()
        
        let normalView = Text("Normal View")
        let fullScreenView = Text("Full Screen View")
        
        // 通常画面をPush
        navigationManager.push(normalView, animated: false)
        await waitForNavigationStability()
        let normalStackCount = navigationManager.viewStack.count
        
        // 全画面を表示
        fullScreenManager.presentFullScreen(fullScreenView, animated: false)
        try? await Task.sleep(for: .milliseconds(200))
        #expect(fullScreenManager.currentFullScreenView != nil, "全画面ビューが表示される")
        
        // 通常画面スタックは影響を受けない
        #expect(navigationManager.viewStack.count == normalStackCount, "通常画面スタックは影響を受けない")
        
        // 全画面表示中でも通常画面スタックは独立して動作
        #expect(fullScreenManager.isFullScreenPresented == true, "全画面が表示されている")
        
        // テスト終了時のクリーンアップ
        await resetFullScreenCompletely()
    }
    
    // MARK: - Basic Safety Tests (基本安全性テスト)
    
    @Test("空スタックでの操作安全性テスト")
    func emptyStackSafetyTest() async {
        // 初期化
        navigationManager.resetToInitial()
        await waitForNavigationStability()
        
        // 空スタックでの操作がクラッシュしないことを確認
        navigationManager.pop(animated: false) // クラッシュしないことを確認
        navigationManager.popToRoot(animated: false) // クラッシュしないことを確認
        
        // 操作後の安定化を待つ
        await waitForNavigationStability()
        
        // 基本的な操作が問題なく実行できることを確認
        #expect(true, "空スタックでの操作が安全に実行された")
    }
    
    @Test("全画面状態の基本テスト")
    func fullScreenBasicTest() async {
        // 初期化
        await resetFullScreenCompletely()
        
        #expect(fullScreenManager.currentFullScreenView == nil, "初期状態では全画面ビューは表示されていない")
        #expect(fullScreenManager.isFullScreenPresented == false, "初期状態では全画面表示されていない")
        #expect(fullScreenManager.isTransitioning == false, "初期状態では遷移中ではない")
    }
}
