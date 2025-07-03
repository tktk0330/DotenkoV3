//
//  Constants.swift
//  DotenkoV3
//
//  ファイル概要: アプリ全体で使用する定数を定義するファイル
//  環境に依存しない固定値のみを管理し、マジックナンバーの使用を避ける
//

import Foundation

struct Constants {
    
    // MARK: - アプリ基本情報
    struct AppInfo {
        static let name = "DOTENKO" // アプリ名
        static let displayName = "DOTENKO" // アプリ表示名
        static let minimumIOSVersion = "16.0" // 最小対応iOS版本
        static let version = "1.0.0" // アプリバージョン
    }
    
    // MARK: - 画面サイズ・レイアウト
    struct Layout {
        static let bannerAdHeight: CGFloat = 80 // バナー広告の高さ
        static let tabBarHeight: CGFloat = 83 // タブバーの高さ
        static let cornerRadius: CGFloat = 12 // 角丸の標準値
        static let standardPadding: CGFloat = 16 // 標準パディング
        static let smallPadding: CGFloat = 8 // 小パディング
        static let largePadding: CGFloat = 24 // 大パディング
        static let extraLargePadding: CGFloat = 32 // 特大パディング
    }
    
    // MARK: - アイコンサイズ
    struct IconSize {
        static let small: CGFloat = 20 // 小アイコン
        static let medium: CGFloat = 30 // 中アイコン
        static let large: CGFloat = 40 // 大アイコン
        static let gamePlayerIcon: CGFloat = 30 // ゲーム画面でのプレイヤーアイコン
        static let settingsIcon: CGFloat = 80 // 設定画面でのアイコン
        static let homeIcon: CGFloat = 60 // ホーム画面でのアイコン
    }
    
    // MARK: - カードサイズ
    struct CardSize {
        static let gameCardWidth: CGFloat = 50 // ゲーム画面でのカード幅
        static let gameCardHeight: CGFloat = 70 // ゲーム画面でのカード高さ
        static let handCardWidth: CGFloat = 100 // 手札カード幅
        static let handCardHeight: CGFloat = 140 // 手札カード高さ
    }
    
    // MARK: - ゲーム設定
    struct Game {
        static let maxPlayerCount = 5 // 最大プレイヤー数
        static let minPlayerCount = 2 // 最小プレイヤー数
        static let maxPlayerNameLength = 10 // プレイヤー名最大文字数
        static let maxRoomNameLength = 10 // ルーム名最大文字数
        static let initialCardCount = 2 // 初期配布カード数
        static let maxHandCards = 13 // 手札最大枚数
        static let challengeTimeLimit = 15 // チャレンジタイムリミット（秒）
        static let countdownTime = 5 // カウントダウン時間（秒）
        static let messageDisplayTime = 5 // メッセージ表示時間（秒）
        static let maxRoomWaitTime = 300 // ルーム待機最大時間（秒）
    }
    
    // MARK: - アニメーション時間
    struct Animation {
        static let fast = 0.2 // 高速アニメーション
        static let normal = 0.3 // 通常アニメーション
        static let slow = 0.5 // 低速アニメーション
        static let cardDealDuration = 0.5 // カード配布アニメーション時間
        static let cardPlayDuration = 0.3 // カード出しアニメーション時間
        static let fadeInDuration = 0.3 // フェードインアニメーション時間
        static let fadeOutDuration = 0.3 // フェードアウトアニメーション時間
        static let splashMinimumDuration = 1.0 // スプラッシュ最小表示時間
        static let splashMaximumDuration = 10.0 // スプラッシュ最大表示時間
    }
    
    // MARK: - Firebase設定
    struct Firebase {
        static let roomCollectionName = "rooms" // ルームコレクション名
        static let playersCollectionName = "players" // プレイヤーコレクション名
        static let gamesCollectionName = "games" // ゲームコレクション名
        static let maxDataSizeKB = 3 // 最大データサイズ（KB）
        static let connectionTimeoutSeconds = 5 // 接続タイムアウト（秒）
        static let retryCount = 3 // リトライ回数
        static let retryDelaySeconds = 1 // リトライ間隔（秒）
    }
    
    // MARK: - ユーザーデフォルト キー
    struct UserDefaultsKeys {
        static let playerName = "playerName" // プレイヤー名
        static let playerIconData = "playerIconData" // プレイヤーアイコンデータ
        static let selectedPlayerCount = "selectedPlayerCount" // 選択されたプレイヤー数
        static let gameRuleSettings = "gameRuleSettings" // ゲームルール設定
        static let soundEnabled = "soundEnabled" // 音声有効フラグ
        static let bgmEnabled = "bgmEnabled" // BGM有効フラグ
        static let isFirstLaunch = "isFirstLaunch" // 初回起動フラグ
    }
    
    // MARK: - エラーメッセージ
    struct ErrorMessages {
        static let networkError = "通信エラーが発生しました" // ネットワークエラー
        static let authenticationError = "認証に失敗しました" // 認証エラー
        static let roomNotFound = "ルームが見つかりません" // ルーム未発見
        static let roomFull = "ルームが満員です" // ルーム満員
        static let gameStartError = "ゲームを開始できませんでした" // ゲーム開始エラー
        static let syncError = "データの同期に失敗しました" // 同期エラー
        static let invalidInput = "入力内容が正しくありません" // 入力エラー
        static let unknownError = "予期しないエラーが発生しました" // 不明エラー
    }
    
    // MARK: - 成功メッセージ
    struct SuccessMessages {
        static let roomCreated = "ルームを作成しました" // ルーム作成成功
        static let roomJoined = "ルームに参加しました" // ルーム参加成功
        static let gameStarted = "ゲームを開始します" // ゲーム開始
        static let settingsSaved = "設定を保存しました" // 設定保存成功
    }
    
    // MARK: - ヒントメッセージ
    struct HintMessages {
        static let selectCards = "カードを選択してください" // カード選択ヒント
        static let waitingForPlayers = "他のプレイヤーを待っています" // 待機中ヒント
        static let yourTurn = "あなたのターンです" // ターンヒント
        static let challengeZone = "チャレンジゾーンが発動しました" // チャレンジゾーンヒント
        static let tapToStart = "タップしてスタート" // スタートヒント
    }
    
    // MARK: - 数値制限
    struct Limits {
        static let maxImageSizeKB = 500 // 最大画像サイズ（KB）
        static let maxTextLength = 100 // 最大テキスト長
        static let minPasswordLength = 6 // 最小パスワード長
        static let maxRetryAttempts = 3 // 最大リトライ回数
    }
    
    // MARK: - Development Settings
    
    /// 開発ビルドかどうかの判定
    /// DEBUGフラグまたはTESTINGフラグが設定されている場合はtrue
    static let isDebugBuild: Bool = {
        #if DEBUG || TESTING
        return true
        #else
        return false
        #endif
    }()
    
    /// テストUI機能を有効にするかどうか
    /// 開発ビルドでのみテストUI機能を表示
    static let enableTestUI: Bool = isDebugBuild
} 
