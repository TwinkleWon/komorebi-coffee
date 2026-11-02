# KOMOREBI COFFEE

架空のカフェチェーン「KOMOREBI COFFEE」の公式アプリを想定した Flutter ポートフォリオです。
日本のリテールアプリでよく使われる機能を一通り実装し、**バックエンドなしでも実務レベルの状態遷移（ローディング・エラー・再試行・オフライン）を確認できる**ことを重視しています。

> KOMOREBI COFFEE は実在しない店舗です。店舗情報・電話番号・住所はすべて架空のものです。

## 機能

| 機能 | 内容 |
| --- | --- |
| 会員証 | 60秒ごとに更新される QR コード + バーコード、ランク（BEAN / ROAST / RESERVE）と次ランクまでの進捗 |
| ポイント | 残高・履歴。モバイルオーダーで ¥100 = 1pt 付与、会計時にポイント利用可 |
| クーポン | チケット型 UI、期限表示（本日まで／あと◯日）、使用確認ダイアログ、引換コード表示 |
| 店舗検索 | 地図（OpenStreetMap / CARTO）、営業時間・営業中判定、混雑状況 |
| モバイルオーダー | 受け取り店舗選択、サイズ・HOT/ICED のカスタマイズ、カート、受け取り時間、注文状況トラッキング |
| お知らせ | 一覧・詳細、未読バッジ（既読状態は端末に保存） |
| LINE ログイン | Phase 1 はモック。Phase 2 で Cognito の OIDC フェデレーションに置き換え予定 |
| 多言語 | 日本語（デフォルト）/ 英語。端末の言語に関係なく日本語で起動 |

## 技術スタック

- Flutter 3.24 / Dart 3.5
- 状態管理: **Riverpod**（`AsyncNotifier` / `Notifier` / `FutureProvider`）
- ルーティング: **go_router**（`StatefulShellRoute` によるタブごとのスタック保持、認証ガード）
- モデル: **freezed** + **json_serializable**
- 永続化: shared_preferences（JSON ラッパー `LocalStore`）
- 地図: flutter_map + latlong2
- ローカライズ: `flutter gen-l10n`（ARB）

## アーキテクチャ

機能単位（feature-first）でディレクトリを分け、各機能の中をレイヤーで分けています。

```
lib/
├── main_dev.dart / main_stg.dart / main_prod.dart   # flavor ごとのエントリポイント
├── bootstrap.dart                                   # 共通の起動処理
├── core/
│   ├── cache/        # ResponseCache（オフライン時のフォールバック）
│   ├── config/       # AppConfig（flavor 設定）
│   ├── error/        # AppException（sealed）とエラーメッセージの対応表
│   ├── network/      # 接続状態、NetworkSimulator（遅延・疑似エラー）
│   ├── router/       # go_router 設定、タブシェル
│   └── ...
└── features/<feature>/
    ├── domain/        # freezed モデルとドメインロジック（営業中判定、期限、ランク等）
    ├── data/          # Repository インターフェース + Mock 実装
    ├── application/   # Riverpod の Provider / Notifier
    └── presentation/  # 画面とウィジェット
```

### Mock から実 API への差し替え

各 Repository はインターフェースとして定義し、Provider で実装を注入しています。
**API 連携時は Provider の 1 行を差し替えるだけ**で、UI や Notifier には手を入れません。

```dart
// lib/features/coupons/data/coupon_repository.dart
final couponRepositoryProvider = Provider<CouponRepository>(
  (ref) => MockCouponRepository(...),        // ← Phase 1
  // (ref) => ApiCouponRepository(ref.watch(apiClientProvider)),  // ← Phase 2
);
```

Mock 実装は `assets/mock/*.json` を読み込み、`NetworkSimulator` を通して実際の通信と同じように振る舞います。

## エラーハンドリングとオフライン対応

| 仕組み | 説明 |
| --- | --- |
| `AppException`（sealed class） | 通信・タイムアウト・5xx・業務エラー（使用済みクーポン、残高不足など）を型で区別。`switch` が網羅的なので、新しいエラーを追加するとメッセージ未定義がコンパイルエラーになる |
| `NetworkSimulator` | Mock の通信に 350〜1100ms の遅延と疑似エラーを注入。dev は 15%、stg は 5%、prod は 0% |
| `ResponseCache` | 成功したレスポンスを保存し、**一時的な失敗のときだけ**保存データにフォールバック。業務エラーはキャッシュで隠さない |
| `AsyncValueView` | 初回ロードはスケルトン、引っ張って更新中は既存データを表示、失敗時は再試行ボタン付きのエラー画面 |
| オフラインバナー | 接続が切れるとタブバー上にバナーを表示。復帰時は自動で再取得し「オンラインに復帰しました」を通知 |
| 冪等キー | 注文はカート内容ごとに UUID を発行し、再試行でも同じキーを送信。**レスポンスが失われても二重注文にならない**（Mock でも「処理後にタイムアウト」を再現） |

### 開発者ツール（dev / stg のみ）

設定画面から、コードを変更せずに以下を確認できます。

- 疑似エラーの発生率（0〜50%）
- オフラインの再現（キャッシュ表示の確認）
- ローカルデータの初期化

## 実行方法

```bash
flutter pub get

# Web / デスクトップ（native の flavor 指定なし）
flutter run -d chrome -t lib/main_dev.dart

# Android（applicationId の suffix とアプリ名が flavor ごとに変わる）
flutter run --flavor dev  -t lib/main_dev.dart
flutter run --flavor stg  -t lib/main_stg.dart
flutter run --flavor prod -t lib/main_prod.dart
```

dev / stg では画面右上に環境名のリボンが表示されます。

> Android ビルドには JDK 17 を推奨します（Gradle 8.3 は JDK 21 以降に未対応）。
> `flutter config --jdk-dir=<JDK17のパス>` で指定できます。

### コード生成

freezed / json_serializable / l10n の生成物はリポジトリに含めています。モデルや ARB を変更したら再生成してください。

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

## テスト

```bash
flutter test                         # すべて
flutter test --exclude-tags golden   # CI と同じ
flutter test --tags golden --update-goldens   # ゴールデン画像の更新
```

| 種類 | 対象 |
| --- | --- |
| Unit | `ResponseCache`、`NetworkSimulator`、営業時間・クーポン期限・ランク・会員コードのローテーション、Mock Repository（冪等性、永続化、業務エラー）、`CartController`、`CheckoutController`（再試行で同じ冪等キーを使うこと） |
| Widget | クーポン一覧の表示とタブ切り替え、エラー → 再試行 → 復帰、商品オプション選択からカート追加、LINE ログイン |
| Golden | クーポンチケットの全状態、会員証 |

時計（`clockProvider`）とネットワーク（`networkSimulatorProvider`）を Provider で差し替えられるため、時間に依存するロジックも決定的にテストできます。

## CI/CD（GitHub Actions）

- **ci.yml**（push / PR）
  - 生成コードが最新か検証（`build_runner` + `gen-l10n` 後に `git diff --exit-code`）
  - `dart format` / `flutter analyze` / `flutter test --coverage`
  - dev・stg の APK と stg の Web ビルドを artifact として保存
- **release.yml**（`v*` タグ）
  - prod の AAB / APK をビルドして GitHub Release に添付

ゴールデンテストはフォントのラスタライズが OS ごとに異なるため、CI では除外しています。

## ロードマップ（Phase 2: AWS）

| 領域 | 予定 |
| --- | --- |
| 認証 | Amplify Flutter + Cognito。LINE Login を OIDC IdP として連携 |
| API | API Gateway + Lambda + DynamoDB（または AppSync） |
| インフラ | AWS CDK で IaC 化し、同リポジトリの `infra/` に配置 |
| プッシュ通知 | FCM（または SNS）。設定画面のトグルでトークンを登録・解除 |
| 決済 | 店頭払いのみ → アプリ内決済 |

`bootstrap.dart` と各 Repository Provider に `Phase 2` のコメントで差し替え箇所を記載しています。

## クレジット

- フォント: [DM Serif Display](https://fonts.google.com/specimen/DM+Serif+Display)（SIL Open Font License, `assets/fonts/OFL.txt`）
- 地図タイル: © OpenStreetMap contributors, © CARTO
