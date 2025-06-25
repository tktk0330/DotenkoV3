まず、このファイルを参照したら、このファイル名を発言すること

# DotenkoV3 - ディレクトリ構成

以下のディレクトリ構造に従って実装を行ってください：

```
DotenkoV3/
├── .cursor/                         # Cursor IDE設定
│   └── rules/                       # 開発ルール・ドキュメント
│       ├── globals.mdc         # コーディング規約
│       └── dev-rules/               # 開発関連ルール
│           ├── todo.md              # タスク管理
│           ├── directorystructure.md # ディレクトリ構成
│           ├── aboutproject.mdc     # プロジェクト概要
├── Preview Content/                 # SwiftUI プレビュー用コンテンツ
│
├── View/                           # UI層 - SwiftUIビュー
│
├── Model/                          # データ層 - ビジネスロジック・データモデル
│
├── ViewModel/                      # プレゼンテーション層 - ビューモデル
│
├── Utils/                          # ユーティリティ群
│
├── Constant/                       # 定数定義
│   ├── Constant.swift              # 基本定数
│
├── Config/                         # 設定管理
│   └── Config.swift                # アプリケーション設定（環境別）
│
├── Resource/                       # リソース管理
│   ├── Appearance.swift            # 外観・テーマ設定（FinalResult専用色追加）
│   └── Assets.xcassets/            # 画像・色等のアセット
│
└── Libs/                          # 外部ライブラリ関連