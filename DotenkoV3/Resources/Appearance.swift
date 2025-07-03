//
//  Appearance.swift
//  DotenkoV3
//
//  ファイル概要: アプリ全体で使用するColor・Font・Imageを定義するファイル
//  統一されたデザインシステムを提供し、一元的な管理を行う
//

import SwiftUI

struct Appearance {
    
    // MARK: - カラーパレット
    struct Colors {
        
        // MARK: - メインカラー
        static let primaryGreen = Color(red: 0.0, green: 0.4, blue: 0.2) // 深緑（メインカラー）
        static let primary = primaryGreen // プライマリカラー（エイリアス）
        static let secondaryGreen = Color(red: 0.0, green: 0.5, blue: 0.3) // セカンダリ緑
        static let lightGreen = Color(red: 0.8, green: 0.9, blue: 0.8) // ライト緑
        
        // MARK: - 背景色
        static let backgroundPrimary = primaryGreen // メイン背景
        static let backgroundSecondary = Color(red: 0.95, green: 0.95, blue: 0.95) // セカンダリ背景
        static let backgroundDeepGreen = Color(red: 0.0, green: 0.3, blue: 0.15) // 深緑背景
        static let backgroundCard = Color.white // カード背景
        static let cardBackground = Color(red: 0.98, green: 0.98, blue: 0.98) // カード背景色
        static let backgroundModal = Color.black.opacity(0.5) // モーダル背景
        
        // MARK: - テキストカラー
        static let textPrimary = Color.white // メインテキスト（白）
        static let textSecondary = Color.black // セカンダリテキスト（黒）
        static let textOnPrimary = Color.white // プライマリ背景上のテキスト
        static let textAccent = primaryGreen // アクセントテキスト
        static let textError = Color.red // エラーテキスト
        static let textSuccess = Color.green // 成功テキスト
        static let textHint = Color.gray // ヒントテキスト
        
        // MARK: - ボタンカラー
        static let buttonPrimary = Color.white // プライマリボタン
        static let buttonSecondary = secondaryGreen // セカンダリボタン
        static let buttonDisabled = Color.gray // 無効ボタン
        static let buttonDanger = Color.red // 危険ボタン
        static let destructive = Color.red // 破壊的アクション用ボタン
        static let textOnDestructive = Color.white // 破壊的ボタン上のテキスト
        
        // MARK: - カードカラー
        static let cardSpades = Color.black // スペード
        static let cardHearts = Color.red // ハート
        static let cardDiamonds = Color.red // ダイヤ
        static let cardClubs = Color.black // クラブ
        static let cardJoker = Color.purple // ジョーカー
        static let cardBack = Color.blue // カード裏面
        
        // MARK: - ゲーム関連カラー
        static let playerActive = Color.yellow // アクティブプレイヤー
        static let playerInactive = Color.gray // 非アクティブプレイヤー
        static let cardSelected = Color.yellow.opacity(0.3) // 選択されたカード
        static let challengeZone = Color.orange // チャレンジゾーン
        
        // MARK: - システムカラー
        static let border = Color.gray.opacity(0.3) // ボーダー
        static let shadow = Color.black.opacity(0.2) // シャドウ
        static let overlay = Color.black.opacity(0.4) // オーバーレイ
    }
    
    // MARK: - フォント設定
    struct Fonts {
        
        // MARK: - システムフォント
        static let largeTitle = Font.largeTitle.weight(.bold) // 大タイトル
        static let title = Font.title.weight(.semibold) // タイトル
        static let title2 = Font.title2.weight(.medium) // サブタイトル
        static let headline = Font.headline.weight(.medium) // ヘッドライン
        static let body = Font.body // 本文
        static let callout = Font.callout // コールアウト
        static let subheadline = Font.subheadline // サブヘッドライン
        static let footnote = Font.footnote // 脚注
        static let caption = Font.caption // キャプション
        static let caption2 = Font.caption2 // 小キャプション
        
        // MARK: - カスタムフォント
        static let gameScore = Font.system(size: 24, weight: .bold, design: .monospaced) // ゲームスコア
        static let cardNumber = Font.system(size: 16, weight: .bold, design: .default) // カード番号
        static let timer = Font.system(size: 32, weight: .bold, design: .monospaced) // タイマー
        static let playerName = Font.system(size: 14, weight: .medium, design: .default) // プレイヤー名
        
        // MARK: - ボタンフォント
        static let buttonLarge = Font.title2.weight(.semibold) // 大ボタン
        static let buttonMedium = Font.headline.weight(.medium) // 中ボタン
        static let buttonSmall = Font.callout.weight(.medium) // 小ボタン
    }
    
    // MARK: - 画像リソース
    struct Images {
        
        // MARK: - アイコン
        static let defaultPlayerIcon = "person.circle" // デフォルトプレイヤーアイコン
        static let cameraIcon = "camera" // カメラアイコン
        static let photoIcon = "photo" // 写真アイコン
        static let settingsIcon = "gearshape" // 設定アイコン
        static let helpIcon = "questionmark.circle" // ヘルプアイコン
        static let homeIcon = "house" // ホームアイコン
        
        // MARK: - ゲーム関連アイコン
        static let playIcon = "play.fill" // 再生アイコン
        static let pauseIcon = "pause.fill" // 一時停止アイコン
        static let refreshIcon = "arrow.clockwise" // リフレッシュアイコン
        static let exitIcon = "xmark" // 終了アイコン
        static let checkIcon = "checkmark" // チェックアイコン
        static let warningIcon = "exclamationmark.triangle" // 警告アイコン
        
        // MARK: - カードスート
        static let spadeIcon = "suit.spade.fill" // スペード
        static let heartIcon = "suit.heart.fill" // ハート
        static let diamondIcon = "suit.diamond.fill" // ダイヤ
        static let clubIcon = "suit.club.fill" // クラブ
        
        // MARK: - ナビゲーション
        static let backIcon = "chevron.left" // 戻るアイコン
        static let forwardIcon = "chevron.right" // 進むアイコン
        static let upIcon = "chevron.up" // 上アイコン
        static let downIcon = "chevron.down" // 下アイコン
        
        // MARK: - 通信・状態
        static let connectedIcon = "wifi" // 接続済み
        static let disconnectedIcon = "wifi.slash" // 切断
        static let loadingIcon = "arrow.triangle.2.circlepath" // ローディング
        static let errorIcon = "exclamationmark.octagon" // エラー
        
        // MARK: - 音声
        static let soundOnIcon = "speaker.wave.2" // 音声ON
        static let soundOffIcon = "speaker.slash" // 音声OFF
        static let musicIcon = "music.note" // 音楽
    }
    
    // MARK: - レイアウト設定
    struct Layout {
        
        // MARK: - 角丸設定
        static let cornerRadiusSmall: CGFloat = 6 // 小角丸
        static let cornerRadiusMedium: CGFloat = 12 // 中角丸
        static let cornerRadiusLarge: CGFloat = 20 // 大角丸
        
        // MARK: - シャドウ設定
        static let shadowRadius: CGFloat = 4 // シャドウ半径
        static let shadowOffsetX: CGFloat = 0 // シャドウX軸オフセット
        static let shadowOffsetY: CGFloat = 2 // シャドウY軸オフセット
        
        // MARK: - ボーダー設定
        static let borderWidthThin: CGFloat = 1 // 細ボーダー
        static let borderWidthMedium: CGFloat = 2 // 中ボーダー
        static let borderWidthThick: CGFloat = 3 // 太ボーダー
        
        // MARK: - アニメーション設定
        static let animationSpring = Animation.spring(response: 0.5, dampingFraction: 0.8) // スプリングアニメーション
        static let animationEaseInOut = Animation.easeInOut(duration: 0.3) // イーズインアウト
        static let animationLinear = Animation.linear(duration: 0.2) // リニア
    }
} 