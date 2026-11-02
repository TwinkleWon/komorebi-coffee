import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'KOMOREBI COFFEE';

  @override
  String get retry => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get close => '閉じる';

  @override
  String get seeAll => 'すべて見る';

  @override
  String staleData(String time) {
    return '$time 時点の保存データを表示しています';
  }

  @override
  String get offlineBanner => 'オフラインです · 保存済みのデータを表示中';

  @override
  String get backOnline => 'オンラインに復帰しました';

  @override
  String get errorNetworkTitle => 'オフラインです';

  @override
  String get errorNetworkMessage => 'インターネット接続を確認して、もう一度お試しください。';

  @override
  String get errorTimeoutTitle => '応答がありません';

  @override
  String get errorTimeoutMessage => '通信がタイムアウトしました。電波の良い場所でもう一度お試しください。';

  @override
  String get errorServerTitle => 'ただいま混み合っています';

  @override
  String errorServerMessage(int code) {
    return 'サーバーで問題が発生しました（$code）。しばらくしてからお試しください。';
  }

  @override
  String get errorGenericTitle => 'ご確認ください';

  @override
  String get errorUnknownMessage => '予期しないエラーが発生しました。';

  @override
  String get errorCouponAlreadyUsed => 'このクーポンはすでに使用されています。';

  @override
  String get errorCouponExpired => 'このクーポンは有効期限が切れています。';

  @override
  String get errorStoreClosed => '受け取り時間に店舗が営業していないか、モバイルオーダーに対応していません。';

  @override
  String get errorInsufficientPoints => 'ポイント残高が不足しています。';

  @override
  String get errorNotFound => 'お探しの情報が見つかりませんでした。';

  @override
  String get navHome => 'ホーム';

  @override
  String get navOrder => 'オーダー';

  @override
  String get navCard => '会員証';

  @override
  String get navCoupons => 'クーポン';

  @override
  String get navStores => '店舗';

  @override
  String get loginTagline => '木漏れ日のような、ひと休みを。';

  @override
  String get loginWithLine => 'LINEでログイン';

  @override
  String get loginTerms => 'ログインすると、利用規約とプライバシーポリシーに同意したものとみなされます。';

  @override
  String get loginDemoNote => 'デモ版のため、実際のLINE認証は行われません';

  @override
  String get greetingMorning => 'おはようございます';

  @override
  String get greetingAfternoon => 'こんにちは';

  @override
  String get greetingEvening => 'こんばんは';

  @override
  String greetingName(String name) {
    return '$name さん';
  }

  @override
  String get pointsBalance => '保有ポイント';

  @override
  String get showMemberCard => '会員証';

  @override
  String get quickOrder => 'モバイルオーダー';

  @override
  String get quickOrderSub => '並ばず受け取り';

  @override
  String get quickCoupons => 'クーポン';

  @override
  String quickCouponsSub(int count) {
    return '$count枚 使えます';
  }

  @override
  String get quickStores => '店舗を探す';

  @override
  String get quickStoresSub => '混雑もチェック';

  @override
  String get seasonalTitle => '焼き芋ほうじ茶ラテ';

  @override
  String get seasonalBody => '香ばしいほうじ茶に、焼き芋のやさしい甘さを重ねて。11月だけの一杯です。';

  @override
  String get seasonalCta => '注文する';

  @override
  String get homeNews => 'お知らせ';

  @override
  String get activeOrderTitle => 'ご注文の準備状況';

  @override
  String get cardTitle => '会員証';

  @override
  String get cardInstruction => 'お会計の際に、このコードをスタッフにご提示ください';

  @override
  String cardRefreshIn(int seconds) {
    return '$seconds秒後にコードが更新されます';
  }

  @override
  String get memberNumber => '会員番号';

  @override
  String nextRank(String rank, String points) {
    return '$rank まであと $points pt';
  }

  @override
  String get topRank => '最上位ランクです。いつもありがとうございます。';

  @override
  String lifetimePoints(String points) {
    return '累計 $points pt';
  }

  @override
  String get pointsHistory => 'ポイント履歴';

  @override
  String get pointsHistoryEmpty => 'まだポイント履歴はありません';

  @override
  String get pointReasonWelcome => '新規登録ボーナス';

  @override
  String pointReasonOrderEarn(int number) {
    return 'モバイルオーダー No.$number';
  }

  @override
  String pointReasonOrderSpend(int number) {
    return 'ポイント利用 No.$number';
  }

  @override
  String get couponsTitle => 'クーポン';

  @override
  String get couponsAvailable => '使えるクーポン';

  @override
  String get couponsHistory => '使用済み・期限切れ';

  @override
  String get couponsEmptyAvailable => '現在使えるクーポンはありません';

  @override
  String get couponsEmptyHistory => '使用済みのクーポンはありません';

  @override
  String couponExpiresOn(String date) {
    return '$dateまで';
  }

  @override
  String couponDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'あと$days日',
      zero: '本日まで',
    );
    return '$_temp0';
  }

  @override
  String get couponUsed => '使用済み';

  @override
  String get couponExpired => '期限切れ';

  @override
  String get couponConditions => 'ご利用条件';

  @override
  String get couponUse => 'このクーポンを使う';

  @override
  String get couponConfirmTitle => 'クーポンを使用しますか？';

  @override
  String get couponConfirmBody => 'レジでスタッフにお声がけのうえ、「使用する」を押してください。使用後は取り消せません。';

  @override
  String get couponConfirmAction => '使用する';

  @override
  String get couponRedeemedTitle => 'ご利用ありがとうございます';

  @override
  String get couponRedeemedBody => 'この画面をスタッフにご提示ください';

  @override
  String couponRedeemedAt(String time) {
    return '$time に使用';
  }

  @override
  String get storesTitle => '店舗';

  @override
  String storeOpenUntil(String time) {
    return '営業中 · $timeまで';
  }

  @override
  String storeClosedOpensAt(String time) {
    return '営業時間外 · $timeから';
  }

  @override
  String get storeOpen24h => '24時間営業';

  @override
  String get congestionLow => '空いています';

  @override
  String get congestionModerate => 'やや混雑';

  @override
  String get congestionHigh => '混雑';

  @override
  String get congestionClosed => '営業時間外';

  @override
  String get congestionTitle => '現在の混雑状況';

  @override
  String get storeHours => '営業時間';

  @override
  String get weekdays => '平日';

  @override
  String get weekends => '土日祝';

  @override
  String get storeAddress => '住所';

  @override
  String get storePhone => '電話番号';

  @override
  String get storeFeatures => '設備・サービス';

  @override
  String get featureWifi => 'Wi-Fi';

  @override
  String get featurePower => '電源';

  @override
  String get featureTerrace => 'テラス席';

  @override
  String get featureRoastery => '焙煎所併設';

  @override
  String get featureMobileOrder => 'モバイルオーダー';

  @override
  String get storeOrderHere => 'この店舗でモバイルオーダー';

  @override
  String get storeNoMobileOrder => 'この店舗はモバイルオーダーに対応していません';

  @override
  String get orderTitle => 'モバイルオーダー';

  @override
  String get pickupStore => '受け取り店舗';

  @override
  String get selectStore => '店舗を選択';

  @override
  String get selectStoreHint => 'タップして受け取り店舗を選んでください';

  @override
  String get changeStore => '変更';

  @override
  String get categoryAll => 'すべて';

  @override
  String get categoryCoffee => 'コーヒー';

  @override
  String get categoryTea => 'ティー';

  @override
  String get categorySeasonal => '季節限定';

  @override
  String get categoryFood => 'フード';

  @override
  String get soldOut => '売り切れ';

  @override
  String get size => 'サイズ';

  @override
  String get temperature => '温度';

  @override
  String get quantity => '数量';

  @override
  String addToCart(String price) {
    return 'カートに追加 · $price';
  }

  @override
  String get addedToCart => 'カートに追加しました';

  @override
  String get viewCart => 'カートを見る';

  @override
  String itemCount(int count) {
    return '$count点';
  }

  @override
  String get cartTitle => 'カート';

  @override
  String get cartEmpty => 'カートは空です';

  @override
  String get browseMenu => 'メニューを見る';

  @override
  String get pickupTime => '受け取り時間';

  @override
  String get pickupAsap => '最短 約5分';

  @override
  String get pickupIn15 => '15分後';

  @override
  String get pickupIn30 => '30分後';

  @override
  String get usePoints => 'ポイントを使う';

  @override
  String usePointsBalance(String points) {
    return '保有 $points pt';
  }

  @override
  String get subtotal => '小計';

  @override
  String get pointsDiscount => 'ポイント利用';

  @override
  String get total => '合計';

  @override
  String earnPreview(int points) {
    return 'このご注文で $points pt たまります';
  }

  @override
  String placeOrder(String price) {
    return '注文を確定する · $price';
  }

  @override
  String get payAtStore => 'お支払いは店頭で承ります（デモ版）';

  @override
  String get checkoutFailed => '注文を送信できませんでした';

  @override
  String get checkoutRetryNote => 'もう一度お試しいただいても、注文が重複することはありません。';

  @override
  String get orderThanks => 'ご注文ありがとうございます';

  @override
  String get orderNumberLabel => '注文番号';

  @override
  String get statusReceived => '受付済み';

  @override
  String get statusPreparing => '準備中';

  @override
  String get statusReady => '受け取り可能';

  @override
  String get readyMessage => 'カウンターでお受け取りください';

  @override
  String preparingMessage(String time) {
    return '$time 頃のお渡し予定です';
  }

  @override
  String get orderItems => 'ご注文内容';

  @override
  String get pointsEarned => '獲得ポイント';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get orderHistory => '注文履歴';

  @override
  String get orderHistoryEmpty => 'まだ注文はありません';

  @override
  String get newsTitle => 'お知らせ';

  @override
  String get newsEmpty => 'お知らせはありません';

  @override
  String get newsCampaign => 'キャンペーン';

  @override
  String get newsNewProduct => '新商品';

  @override
  String get newsInfo => 'お知らせ';

  @override
  String get markAllRead => 'すべて既読';

  @override
  String get settingsTitle => '設定';

  @override
  String get account => 'アカウント';

  @override
  String get linkedWithLine => 'LINE連携済み';

  @override
  String get general => '一般';

  @override
  String get language => '言語';

  @override
  String get pushNotifications => 'プッシュ通知';

  @override
  String get pushNotificationsSub => 'クーポンやキャンペーンのお知らせ';

  @override
  String get aboutApp => 'このアプリについて';

  @override
  String get version => 'バージョン';

  @override
  String get environment => '環境';

  @override
  String get demoNotice => 'KOMOREBI COFFEE は架空のカフェチェーンです。このアプリはポートフォリオ用のデモです。';

  @override
  String get devTools => '開発者ツール';

  @override
  String get devFailureRate => '疑似エラーの発生率';

  @override
  String get devSimulateOffline => 'オフラインを再現';

  @override
  String get devSimulateOfflineSub => '通信を遮断してキャッシュ表示を確認できます';

  @override
  String get devResetData => 'ローカルデータを初期化';

  @override
  String get devResetConfirm => 'ポイント・注文・クーポンの利用履歴がすべて削除されます。';

  @override
  String get logout => 'ログアウト';

  @override
  String get logoutConfirm => 'ログアウトしますか？';
}
