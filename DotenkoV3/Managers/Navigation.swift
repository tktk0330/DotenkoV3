/*
 * Navigation.swift
 * 
 * ファイル概要:
 * アプリケーション全体のナビゲーション状態管理システム
 * - 画面遷移の制御
 * - ビュースタックの管理
 * - アニメーション付き画面切り替え
 * - 通常画面とフルスクリーン画面の分離管理
 * 
 * 主要機能:
 * - スタックベースのナビゲーション
 * - push/pop操作による画面遷移
 * - ObservableObjectによる状態通知
 * - MainActorによるUI安全性の確保
 * - 全画面表示専用のナビゲーション管理
 * 
 * 構成要素:
 * - ViewWrapper: ViewをHashableにラップ
 * - NavigationStateManager: 通常画面のナビゲーション管理
 * - NavigationAllViewStateManager: 全画面表示のナビゲーション管理
 * 
 * 作成日: 2024年12月
 */

import SwiftUI

// MARK: - View Wrapper

/// ViewをHashableにラップするための構造体
/// AnyViewを配列で管理するために必要な一意性を提供
struct ViewWrapper: Hashable {
    /// 一意識別子
    let id = UUID()
    
    /// ラップされたビュー
    let view: AnyView
    
    /// イニシャライザ
    /// - Parameter view: ラップするビュー
    init<V: View>(view: V) {
        self.view = AnyView(view)
    }
    
    /// Equatable プロトコル準拠
    /// - Parameters:
    ///   - lhs: 左辺のViewWrapper
    ///   - rhs: 右辺のViewWrapper
    /// - Returns: IDが一致する場合true
    static func == (lhs: ViewWrapper, rhs: ViewWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    /// Hashable プロトコル準拠
    /// - Parameter hasher: ハッシュ関数
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Navigation State Manager

/// 通常画面のナビゲーション状態管理クラス
/// スタックベースの画面遷移を提供
@MainActor
class NavigationStateManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// 現在表示している画面のスタック
    @Published private(set) var viewStack: [ViewWrapper] = []
    
    /// ナビゲーション中かどうか
    @Published private(set) var isNavigating: Bool = false
    
    // MARK: - Private Properties
    
    /// シングルトンインスタンス
    static let shared = NavigationStateManager()
    
    // MARK: - Initialization
    
    /// プライベートイニシャライザ（シングルトンパターン）
    private init() {}
    
    // MARK: - Public Methods
    
    /// 指定したViewにプッシュ遷移
    /// - Parameters:
    ///   - view: 表示するView
    ///   - animated: アニメーションを有効にするか
    func push<V: View>(_ view: V, animated: Bool = true) {
        guard !isNavigating else { return }
        
        let wrapper = ViewWrapper(view: view)
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performPush(wrapper)
            }
        } else {
            performPush(wrapper)
        }
        
        resetNavigatingState()
    }
    
    /// 現在の画面からポップ（戻る）
    /// - Parameter animated: アニメーションを有効にするか
    func pop(animated: Bool = true) {
        guard !isNavigating, viewStack.count > 1 else { return }
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performPop()
            }
        } else {
            performPop()
        }
        
        resetNavigatingState()
    }
    
    /// ルート画面まで戻る
    /// - Parameter animated: アニメーションを有効にするか
    func popToRoot(animated: Bool = true) {
        guard !isNavigating, viewStack.count > 1 else { return }
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performPopToRoot()
            }
        } else {
            performPopToRoot()
        }
        
        resetNavigatingState()
    }
    
    /// 現在のスタックを置き換え
    /// - Parameters:
    ///   - view: 表示するView
    ///   - animated: アニメーションを有効にするか
    func replace<V: View>(with view: V, animated: Bool = true) {
        guard !isNavigating else { return }
        
        let wrapper = ViewWrapper(view: view)
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performReplace(wrapper)
            }
        } else {
            performReplace(wrapper)
        }
        
        resetNavigatingState()
    }
    
    /// ナビゲーションスタックをクリア
    func resetToInitial() {
        withAnimation(.easeInOut(duration: 0.1)) {
            setupInitialScreen()
        }
    }
    
    /// テスト用：アニメーションなしでナビゲーションスタックをクリア
    func resetToInitialForTesting() {
        setupInitialScreen()
    }
    
    // MARK: - Private Methods
    
    /// 初期画面の設定
    private func setupInitialScreen() {
        viewStack.removeAll()
        isNavigating = false
    }
    
    /// ナビゲーション状態をリセット
    private func resetNavigatingState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isNavigating = false
        }
    }
    
    /// プッシュ処理の実行
    /// - Parameter wrapper: 新しい画面のラッパー
    private func performPush(_ wrapper: ViewWrapper) {
        isNavigating = true
        viewStack.append(wrapper)
    }
    
    /// ポップ処理の実行
    private func performPop() {
        isNavigating = true
        viewStack.removeLast()
    }
    
    /// ルートまでポップ処理の実行
    private func performPopToRoot() {
        isNavigating = true
        // ルートビュー（最初の要素）のみを残して他を削除
        if viewStack.count > 1 {
            viewStack = Array(viewStack.prefix(1))
        }
    }
    
    /// 置き換え処理の実行
    /// - Parameter wrapper: 新しい画面のラッパー
    private func performReplace(_ wrapper: ViewWrapper) {
        isNavigating = true
        
        if viewStack.isEmpty {
            viewStack.append(wrapper)
        } else {
            viewStack[viewStack.count - 1] = wrapper
        }
    }
    
    /// デバッグ用：現在のスタック状態を出力
    func printStackState() {
        print("=== Navigation Stack State ===")
        print("Stack Count: \(viewStack.count)")
        print("Is Navigating: \(isNavigating)")
        print("===============================")
    }
}

// MARK: - Navigation All View State Manager

/// 全画面表示専用のナビゲーション状態管理クラス
/// モーダルやオーバーレイなどの全画面表示を管理
@MainActor
class NavigationAllViewStateManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// 現在表示している全画面View
    @Published private(set) var currentFullScreenView: ViewWrapper?
    
    /// 全画面表示中かどうか
    @Published private(set) var isFullScreenPresented: Bool = false
    
    /// 全画面遷移中かどうか
    @Published private(set) var isTransitioning: Bool = false
    
    // MARK: - Private Properties
    
    /// シングルトンインスタンス
    static let shared = NavigationAllViewStateManager()
    
    /// 全画面ビュー履歴スタック
    private var viewStack: [ViewWrapper] = []
    
    // MARK: - Initialization
    
    /// プライベートイニシャライザ（シングルトンパターン）
    private init() {}
    
    // MARK: - Public Methods
    
    /// 全画面でViewを表示
    /// - Parameters:
    ///   - view: 表示するView
    ///   - animated: アニメーションを有効にするか
    func presentFullScreen<V: View>(_ view: V, animated: Bool = true) {
        guard !isTransitioning else { return }
        
        let wrapper = ViewWrapper(view: view)
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performPresentFullScreen(wrapper)
            }
        } else {
            performPresentFullScreen(wrapper)
        }
        
        resetTransitionState()
    }
    
    /// 全画面表示を閉じる
    /// - Parameter animated: アニメーションを有効にするか
    func dismissFullScreen(animated: Bool = true) {
        guard !isTransitioning, isFullScreenPresented else { return }
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performDismissFullScreen()
            }
        } else {
            performDismissFullScreen()
        }
        
        // 遷移状態のリセットのみ行う
        // currentFullScreenViewはperformDismissFullScreenで適切に処理される
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isTransitioning = false
        }
    }
    
    /// 全画面表示を別のViewに置き換え
    /// - Parameters:
    ///   - view: 表示するView
    ///   - animated: アニメーションを有効にするか
    func replaceFullScreen<V: View>(with view: V, animated: Bool = true) {
        guard !isTransitioning else { return }
        
        let wrapper = ViewWrapper(view: view)
        
        if animated {
            withAnimation(.easeInOut(duration: 0.1)) {
                performReplaceFullScreen(wrapper)
            }
        } else {
            performReplaceFullScreen(wrapper)
        }
        
        resetTransitionState()
    }
    
    /// デバッグ用：現在の全画面状態を出力
    func printFullScreenState() {
        print("=== Full Screen State ===")
        print("Is Presented: \(isFullScreenPresented)")
        print("Is Transitioning: \(isTransitioning)")
        print("Stack count: \(viewStack.count)")
        print("=========================")
    }
    
    /// テスト用：全画面状態を強制的にリセット
    func forceResetForTesting() {
        currentFullScreenView = nil
        isFullScreenPresented = false
        isTransitioning = false
        viewStack.removeAll()
    }
    
    // MARK: - Private Methods
    
    /// 遷移状態をリセット
    private func resetTransitionState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isTransitioning = false
        }
    }
    
    /// 全画面表示処理の実行
    /// - Parameter wrapper: 表示する画面のラッパー
    private func performPresentFullScreen(_ wrapper: ViewWrapper) {
        // 現在のビューがあればスタックに保存
        if let current = currentFullScreenView {
            viewStack.append(current)
        }
        
        isTransitioning = true
        currentFullScreenView = wrapper
        isFullScreenPresented = true
    }
    
    /// 全画面閉じる処理の実行
    private func performDismissFullScreen() {
        isTransitioning = true
        
        if !viewStack.isEmpty {
            // スタックから前のビューを復元
            currentFullScreenView = viewStack.removeLast()
        } else {
            // スタックが空の場合のみ全画面表示を完全に終了
            currentFullScreenView = nil
            isFullScreenPresented = false
        }
    }
    
    /// 全画面置き換え処理の実行
    /// - Parameter wrapper: 新しい画面のラッパー
    private func performReplaceFullScreen(_ wrapper: ViewWrapper) {
        isTransitioning = true
        currentFullScreenView = wrapper
    }
} 
