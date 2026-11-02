import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ja'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In ja, this message translates to:
  /// **'KOMOREBI COFFEE'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In ja, this message translates to:
  /// **'閉じる'**
  String get close;

  /// No description provided for @seeAll.
  ///
  /// In ja, this message translates to:
  /// **'すべて見る'**
  String get seeAll;

  /// No description provided for @staleData.
  ///
  /// In ja, this message translates to:
  /// **'{time} 時点の保存データを表示しています'**
  String staleData(String time);

  /// No description provided for @offlineBanner.
  ///
  /// In ja, this message translates to:
  /// **'オフラインです · 保存済みのデータを表示中'**
  String get offlineBanner;

  /// No description provided for @backOnline.
  ///
  /// In ja, this message translates to:
  /// **'オンラインに復帰しました'**
  String get backOnline;

  /// No description provided for @errorNetworkTitle.
  ///
  /// In ja, this message translates to:
  /// **'オフラインです'**
  String get errorNetworkTitle;

  /// No description provided for @errorNetworkMessage.
  ///
  /// In ja, this message translates to:
  /// **'インターネット接続を確認して、もう一度お試しください。'**
  String get errorNetworkMessage;

  /// No description provided for @errorTimeoutTitle.
  ///
  /// In ja, this message translates to:
  /// **'応答がありません'**
  String get errorTimeoutTitle;

  /// No description provided for @errorTimeoutMessage.
  ///
  /// In ja, this message translates to:
  /// **'通信がタイムアウトしました。電波の良い場所でもう一度お試しください。'**
  String get errorTimeoutMessage;

  /// No description provided for @errorServerTitle.
  ///
  /// In ja, this message translates to:
  /// **'ただいま混み合っています'**
  String get errorServerTitle;

  /// No description provided for @errorServerMessage.
  ///
  /// In ja, this message translates to:
  /// **'サーバーで問題が発生しました（{code}）。しばらくしてからお試しください。'**
  String errorServerMessage(int code);

  /// No description provided for @errorGenericTitle.
  ///
  /// In ja, this message translates to:
  /// **'ご確認ください'**
  String get errorGenericTitle;

  /// No description provided for @errorUnknownMessage.
  ///
  /// In ja, this message translates to:
  /// **'予期しないエラーが発生しました。'**
  String get errorUnknownMessage;

  /// No description provided for @errorCouponAlreadyUsed.
  ///
  /// In ja, this message translates to:
  /// **'このクーポンはすでに使用されています。'**
  String get errorCouponAlreadyUsed;

  /// No description provided for @errorCouponExpired.
  ///
  /// In ja, this message translates to:
  /// **'このクーポンは有効期限が切れています。'**
  String get errorCouponExpired;

  /// No description provided for @errorStoreClosed.
  ///
  /// In ja, this message translates to:
  /// **'受け取り時間に店舗が営業していないか、モバイルオーダーに対応していません。'**
  String get errorStoreClosed;

  /// No description provided for @errorInsufficientPoints.
  ///
  /// In ja, this message translates to:
  /// **'ポイント残高が不足しています。'**
  String get errorInsufficientPoints;

  /// No description provided for @errorNotFound.
  ///
  /// In ja, this message translates to:
  /// **'お探しの情報が見つかりませんでした。'**
  String get errorNotFound;

  /// No description provided for @navHome.
  ///
  /// In ja, this message translates to:
  /// **'ホーム'**
  String get navHome;

  /// No description provided for @navOrder.
  ///
  /// In ja, this message translates to:
  /// **'オーダー'**
  String get navOrder;

  /// No description provided for @navCard.
  ///
  /// In ja, this message translates to:
  /// **'会員証'**
  String get navCard;

  /// No description provided for @navCoupons.
  ///
  /// In ja, this message translates to:
  /// **'クーポン'**
  String get navCoupons;

  /// No description provided for @navStores.
  ///
  /// In ja, this message translates to:
  /// **'店舗'**
  String get navStores;

  /// No description provided for @loginTagline.
  ///
  /// In ja, this message translates to:
  /// **'木漏れ日のような、ひと休みを。'**
  String get loginTagline;

  /// No description provided for @loginWithLine.
  ///
  /// In ja, this message translates to:
  /// **'LINEでログイン'**
  String get loginWithLine;

  /// No description provided for @loginTerms.
  ///
  /// In ja, this message translates to:
  /// **'ログインすると、利用規約とプライバシーポリシーに同意したものとみなされます。'**
  String get loginTerms;

  /// No description provided for @loginDemoNote.
  ///
  /// In ja, this message translates to:
  /// **'デモ版のため、実際のLINE認証は行われません'**
  String get loginDemoNote;

  /// No description provided for @greetingMorning.
  ///
  /// In ja, this message translates to:
  /// **'おはようございます'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In ja, this message translates to:
  /// **'こんにちは'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In ja, this message translates to:
  /// **'こんばんは'**
  String get greetingEvening;

  /// No description provided for @greetingName.
  ///
  /// In ja, this message translates to:
  /// **'{name} さん'**
  String greetingName(String name);

  /// No description provided for @pointsBalance.
  ///
  /// In ja, this message translates to:
  /// **'保有ポイント'**
  String get pointsBalance;

  /// No description provided for @showMemberCard.
  ///
  /// In ja, this message translates to:
  /// **'会員証'**
  String get showMemberCard;

  /// No description provided for @quickOrder.
  ///
  /// In ja, this message translates to:
  /// **'モバイルオーダー'**
  String get quickOrder;

  /// No description provided for @quickOrderSub.
  ///
  /// In ja, this message translates to:
  /// **'並ばず受け取り'**
  String get quickOrderSub;

  /// No description provided for @quickCoupons.
  ///
  /// In ja, this message translates to:
  /// **'クーポン'**
  String get quickCoupons;

  /// No description provided for @quickCouponsSub.
  ///
  /// In ja, this message translates to:
  /// **'{count}枚 使えます'**
  String quickCouponsSub(int count);

  /// No description provided for @quickStores.
  ///
  /// In ja, this message translates to:
  /// **'店舗を探す'**
  String get quickStores;

  /// No description provided for @quickStoresSub.
  ///
  /// In ja, this message translates to:
  /// **'混雑もチェック'**
  String get quickStoresSub;

  /// No description provided for @seasonalTitle.
  ///
  /// In ja, this message translates to:
  /// **'焼き芋ほうじ茶ラテ'**
  String get seasonalTitle;

  /// No description provided for @seasonalBody.
  ///
  /// In ja, this message translates to:
  /// **'香ばしいほうじ茶に、焼き芋のやさしい甘さを重ねて。11月だけの一杯です。'**
  String get seasonalBody;

  /// No description provided for @seasonalCta.
  ///
  /// In ja, this message translates to:
  /// **'注文する'**
  String get seasonalCta;

  /// No description provided for @homeNews.
  ///
  /// In ja, this message translates to:
  /// **'お知らせ'**
  String get homeNews;

  /// No description provided for @activeOrderTitle.
  ///
  /// In ja, this message translates to:
  /// **'ご注文の準備状況'**
  String get activeOrderTitle;

  /// No description provided for @cardTitle.
  ///
  /// In ja, this message translates to:
  /// **'会員証'**
  String get cardTitle;

  /// No description provided for @cardInstruction.
  ///
  /// In ja, this message translates to:
  /// **'お会計の際に、このコードをスタッフにご提示ください'**
  String get cardInstruction;

  /// No description provided for @cardRefreshIn.
  ///
  /// In ja, this message translates to:
  /// **'{seconds}秒後にコードが更新されます'**
  String cardRefreshIn(int seconds);

  /// No description provided for @memberNumber.
  ///
  /// In ja, this message translates to:
  /// **'会員番号'**
  String get memberNumber;

  /// No description provided for @nextRank.
  ///
  /// In ja, this message translates to:
  /// **'{rank} まであと {points} pt'**
  String nextRank(String rank, String points);

  /// No description provided for @topRank.
  ///
  /// In ja, this message translates to:
  /// **'最上位ランクです。いつもありがとうございます。'**
  String get topRank;

  /// No description provided for @lifetimePoints.
  ///
  /// In ja, this message translates to:
  /// **'累計 {points} pt'**
  String lifetimePoints(String points);

  /// No description provided for @pointsHistory.
  ///
  /// In ja, this message translates to:
  /// **'ポイント履歴'**
  String get pointsHistory;

  /// No description provided for @pointsHistoryEmpty.
  ///
  /// In ja, this message translates to:
  /// **'まだポイント履歴はありません'**
  String get pointsHistoryEmpty;

  /// No description provided for @pointReasonWelcome.
  ///
  /// In ja, this message translates to:
  /// **'新規登録ボーナス'**
  String get pointReasonWelcome;

  /// No description provided for @pointReasonOrderEarn.
  ///
  /// In ja, this message translates to:
  /// **'モバイルオーダー No.{number}'**
  String pointReasonOrderEarn(int number);

  /// No description provided for @pointReasonOrderSpend.
  ///
  /// In ja, this message translates to:
  /// **'ポイント利用 No.{number}'**
  String pointReasonOrderSpend(int number);

  /// No description provided for @couponsTitle.
  ///
  /// In ja, this message translates to:
  /// **'クーポン'**
  String get couponsTitle;

  /// No description provided for @couponsAvailable.
  ///
  /// In ja, this message translates to:
  /// **'使えるクーポン'**
  String get couponsAvailable;

  /// No description provided for @couponsHistory.
  ///
  /// In ja, this message translates to:
  /// **'使用済み・期限切れ'**
  String get couponsHistory;

  /// No description provided for @couponsEmptyAvailable.
  ///
  /// In ja, this message translates to:
  /// **'現在使えるクーポンはありません'**
  String get couponsEmptyAvailable;

  /// No description provided for @couponsEmptyHistory.
  ///
  /// In ja, this message translates to:
  /// **'使用済みのクーポンはありません'**
  String get couponsEmptyHistory;

  /// No description provided for @couponExpiresOn.
  ///
  /// In ja, this message translates to:
  /// **'{date}まで'**
  String couponExpiresOn(String date);

  /// No description provided for @couponDaysLeft.
  ///
  /// In ja, this message translates to:
  /// **'{days, plural, =0{本日まで} other{あと{days}日}}'**
  String couponDaysLeft(int days);

  /// No description provided for @couponUsed.
  ///
  /// In ja, this message translates to:
  /// **'使用済み'**
  String get couponUsed;

  /// No description provided for @couponExpired.
  ///
  /// In ja, this message translates to:
  /// **'期限切れ'**
  String get couponExpired;

  /// No description provided for @couponConditions.
  ///
  /// In ja, this message translates to:
  /// **'ご利用条件'**
  String get couponConditions;

  /// No description provided for @couponUse.
  ///
  /// In ja, this message translates to:
  /// **'このクーポンを使う'**
  String get couponUse;

  /// No description provided for @couponConfirmTitle.
  ///
  /// In ja, this message translates to:
  /// **'クーポンを使用しますか？'**
  String get couponConfirmTitle;

  /// No description provided for @couponConfirmBody.
  ///
  /// In ja, this message translates to:
  /// **'レジでスタッフにお声がけのうえ、「使用する」を押してください。使用後は取り消せません。'**
  String get couponConfirmBody;

  /// No description provided for @couponConfirmAction.
  ///
  /// In ja, this message translates to:
  /// **'使用する'**
  String get couponConfirmAction;

  /// No description provided for @couponRedeemedTitle.
  ///
  /// In ja, this message translates to:
  /// **'ご利用ありがとうございます'**
  String get couponRedeemedTitle;

  /// No description provided for @couponRedeemedBody.
  ///
  /// In ja, this message translates to:
  /// **'この画面をスタッフにご提示ください'**
  String get couponRedeemedBody;

  /// No description provided for @couponRedeemedAt.
  ///
  /// In ja, this message translates to:
  /// **'{time} に使用'**
  String couponRedeemedAt(String time);

  /// No description provided for @storesTitle.
  ///
  /// In ja, this message translates to:
  /// **'店舗'**
  String get storesTitle;

  /// No description provided for @storeOpenUntil.
  ///
  /// In ja, this message translates to:
  /// **'営業中 · {time}まで'**
  String storeOpenUntil(String time);

  /// No description provided for @storeClosedOpensAt.
  ///
  /// In ja, this message translates to:
  /// **'営業時間外 · {time}から'**
  String storeClosedOpensAt(String time);

  /// No description provided for @storeOpen24h.
  ///
  /// In ja, this message translates to:
  /// **'24時間営業'**
  String get storeOpen24h;

  /// No description provided for @congestionLow.
  ///
  /// In ja, this message translates to:
  /// **'空いています'**
  String get congestionLow;

  /// No description provided for @congestionModerate.
  ///
  /// In ja, this message translates to:
  /// **'やや混雑'**
  String get congestionModerate;

  /// No description provided for @congestionHigh.
  ///
  /// In ja, this message translates to:
  /// **'混雑'**
  String get congestionHigh;

  /// No description provided for @congestionClosed.
  ///
  /// In ja, this message translates to:
  /// **'営業時間外'**
  String get congestionClosed;

  /// No description provided for @congestionTitle.
  ///
  /// In ja, this message translates to:
  /// **'現在の混雑状況'**
  String get congestionTitle;

  /// No description provided for @storeHours.
  ///
  /// In ja, this message translates to:
  /// **'営業時間'**
  String get storeHours;

  /// No description provided for @weekdays.
  ///
  /// In ja, this message translates to:
  /// **'平日'**
  String get weekdays;

  /// No description provided for @weekends.
  ///
  /// In ja, this message translates to:
  /// **'土日祝'**
  String get weekends;

  /// No description provided for @storeAddress.
  ///
  /// In ja, this message translates to:
  /// **'住所'**
  String get storeAddress;

  /// No description provided for @storePhone.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get storePhone;

  /// No description provided for @storeFeatures.
  ///
  /// In ja, this message translates to:
  /// **'設備・サービス'**
  String get storeFeatures;

  /// No description provided for @featureWifi.
  ///
  /// In ja, this message translates to:
  /// **'Wi-Fi'**
  String get featureWifi;

  /// No description provided for @featurePower.
  ///
  /// In ja, this message translates to:
  /// **'電源'**
  String get featurePower;

  /// No description provided for @featureTerrace.
  ///
  /// In ja, this message translates to:
  /// **'テラス席'**
  String get featureTerrace;

  /// No description provided for @featureRoastery.
  ///
  /// In ja, this message translates to:
  /// **'焙煎所併設'**
  String get featureRoastery;

  /// No description provided for @featureMobileOrder.
  ///
  /// In ja, this message translates to:
  /// **'モバイルオーダー'**
  String get featureMobileOrder;

  /// No description provided for @storeOrderHere.
  ///
  /// In ja, this message translates to:
  /// **'この店舗でモバイルオーダー'**
  String get storeOrderHere;

  /// No description provided for @storeNoMobileOrder.
  ///
  /// In ja, this message translates to:
  /// **'この店舗はモバイルオーダーに対応していません'**
  String get storeNoMobileOrder;

  /// No description provided for @orderTitle.
  ///
  /// In ja, this message translates to:
  /// **'モバイルオーダー'**
  String get orderTitle;

  /// No description provided for @pickupStore.
  ///
  /// In ja, this message translates to:
  /// **'受け取り店舗'**
  String get pickupStore;

  /// No description provided for @selectStore.
  ///
  /// In ja, this message translates to:
  /// **'店舗を選択'**
  String get selectStore;

  /// No description provided for @selectStoreHint.
  ///
  /// In ja, this message translates to:
  /// **'タップして受け取り店舗を選んでください'**
  String get selectStoreHint;

  /// No description provided for @changeStore.
  ///
  /// In ja, this message translates to:
  /// **'変更'**
  String get changeStore;

  /// No description provided for @categoryAll.
  ///
  /// In ja, this message translates to:
  /// **'すべて'**
  String get categoryAll;

  /// No description provided for @categoryCoffee.
  ///
  /// In ja, this message translates to:
  /// **'コーヒー'**
  String get categoryCoffee;

  /// No description provided for @categoryTea.
  ///
  /// In ja, this message translates to:
  /// **'ティー'**
  String get categoryTea;

  /// No description provided for @categorySeasonal.
  ///
  /// In ja, this message translates to:
  /// **'季節限定'**
  String get categorySeasonal;

  /// No description provided for @categoryFood.
  ///
  /// In ja, this message translates to:
  /// **'フード'**
  String get categoryFood;

  /// No description provided for @soldOut.
  ///
  /// In ja, this message translates to:
  /// **'売り切れ'**
  String get soldOut;

  /// No description provided for @size.
  ///
  /// In ja, this message translates to:
  /// **'サイズ'**
  String get size;

  /// No description provided for @temperature.
  ///
  /// In ja, this message translates to:
  /// **'温度'**
  String get temperature;

  /// No description provided for @quantity.
  ///
  /// In ja, this message translates to:
  /// **'数量'**
  String get quantity;

  /// No description provided for @addToCart.
  ///
  /// In ja, this message translates to:
  /// **'カートに追加 · {price}'**
  String addToCart(String price);

  /// No description provided for @addedToCart.
  ///
  /// In ja, this message translates to:
  /// **'カートに追加しました'**
  String get addedToCart;

  /// No description provided for @viewCart.
  ///
  /// In ja, this message translates to:
  /// **'カートを見る'**
  String get viewCart;

  /// No description provided for @itemCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}点'**
  String itemCount(int count);

  /// No description provided for @cartTitle.
  ///
  /// In ja, this message translates to:
  /// **'カート'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In ja, this message translates to:
  /// **'カートは空です'**
  String get cartEmpty;

  /// No description provided for @browseMenu.
  ///
  /// In ja, this message translates to:
  /// **'メニューを見る'**
  String get browseMenu;

  /// No description provided for @pickupTime.
  ///
  /// In ja, this message translates to:
  /// **'受け取り時間'**
  String get pickupTime;

  /// No description provided for @pickupAsap.
  ///
  /// In ja, this message translates to:
  /// **'最短 約5分'**
  String get pickupAsap;

  /// No description provided for @pickupIn15.
  ///
  /// In ja, this message translates to:
  /// **'15分後'**
  String get pickupIn15;

  /// No description provided for @pickupIn30.
  ///
  /// In ja, this message translates to:
  /// **'30分後'**
  String get pickupIn30;

  /// No description provided for @usePoints.
  ///
  /// In ja, this message translates to:
  /// **'ポイントを使う'**
  String get usePoints;

  /// No description provided for @usePointsBalance.
  ///
  /// In ja, this message translates to:
  /// **'保有 {points} pt'**
  String usePointsBalance(String points);

  /// No description provided for @subtotal.
  ///
  /// In ja, this message translates to:
  /// **'小計'**
  String get subtotal;

  /// No description provided for @pointsDiscount.
  ///
  /// In ja, this message translates to:
  /// **'ポイント利用'**
  String get pointsDiscount;

  /// No description provided for @total.
  ///
  /// In ja, this message translates to:
  /// **'合計'**
  String get total;

  /// No description provided for @earnPreview.
  ///
  /// In ja, this message translates to:
  /// **'このご注文で {points} pt たまります'**
  String earnPreview(int points);

  /// No description provided for @placeOrder.
  ///
  /// In ja, this message translates to:
  /// **'注文を確定する · {price}'**
  String placeOrder(String price);

  /// No description provided for @payAtStore.
  ///
  /// In ja, this message translates to:
  /// **'お支払いは店頭で承ります（デモ版）'**
  String get payAtStore;

  /// No description provided for @checkoutFailed.
  ///
  /// In ja, this message translates to:
  /// **'注文を送信できませんでした'**
  String get checkoutFailed;

  /// No description provided for @checkoutRetryNote.
  ///
  /// In ja, this message translates to:
  /// **'もう一度お試しいただいても、注文が重複することはありません。'**
  String get checkoutRetryNote;

  /// No description provided for @orderThanks.
  ///
  /// In ja, this message translates to:
  /// **'ご注文ありがとうございます'**
  String get orderThanks;

  /// No description provided for @orderNumberLabel.
  ///
  /// In ja, this message translates to:
  /// **'注文番号'**
  String get orderNumberLabel;

  /// No description provided for @statusReceived.
  ///
  /// In ja, this message translates to:
  /// **'受付済み'**
  String get statusReceived;

  /// No description provided for @statusPreparing.
  ///
  /// In ja, this message translates to:
  /// **'準備中'**
  String get statusPreparing;

  /// No description provided for @statusReady.
  ///
  /// In ja, this message translates to:
  /// **'受け取り可能'**
  String get statusReady;

  /// No description provided for @readyMessage.
  ///
  /// In ja, this message translates to:
  /// **'カウンターでお受け取りください'**
  String get readyMessage;

  /// No description provided for @preparingMessage.
  ///
  /// In ja, this message translates to:
  /// **'{time} 頃のお渡し予定です'**
  String preparingMessage(String time);

  /// No description provided for @orderItems.
  ///
  /// In ja, this message translates to:
  /// **'ご注文内容'**
  String get orderItems;

  /// No description provided for @pointsEarned.
  ///
  /// In ja, this message translates to:
  /// **'獲得ポイント'**
  String get pointsEarned;

  /// No description provided for @backToHome.
  ///
  /// In ja, this message translates to:
  /// **'ホームに戻る'**
  String get backToHome;

  /// No description provided for @orderHistory.
  ///
  /// In ja, this message translates to:
  /// **'注文履歴'**
  String get orderHistory;

  /// No description provided for @orderHistoryEmpty.
  ///
  /// In ja, this message translates to:
  /// **'まだ注文はありません'**
  String get orderHistoryEmpty;

  /// No description provided for @newsTitle.
  ///
  /// In ja, this message translates to:
  /// **'お知らせ'**
  String get newsTitle;

  /// No description provided for @newsEmpty.
  ///
  /// In ja, this message translates to:
  /// **'お知らせはありません'**
  String get newsEmpty;

  /// No description provided for @newsCampaign.
  ///
  /// In ja, this message translates to:
  /// **'キャンペーン'**
  String get newsCampaign;

  /// No description provided for @newsNewProduct.
  ///
  /// In ja, this message translates to:
  /// **'新商品'**
  String get newsNewProduct;

  /// No description provided for @newsInfo.
  ///
  /// In ja, this message translates to:
  /// **'お知らせ'**
  String get newsInfo;

  /// No description provided for @markAllRead.
  ///
  /// In ja, this message translates to:
  /// **'すべて既読'**
  String get markAllRead;

  /// No description provided for @settingsTitle.
  ///
  /// In ja, this message translates to:
  /// **'設定'**
  String get settingsTitle;

  /// No description provided for @account.
  ///
  /// In ja, this message translates to:
  /// **'アカウント'**
  String get account;

  /// No description provided for @linkedWithLine.
  ///
  /// In ja, this message translates to:
  /// **'LINE連携済み'**
  String get linkedWithLine;

  /// No description provided for @general.
  ///
  /// In ja, this message translates to:
  /// **'一般'**
  String get general;

  /// No description provided for @language.
  ///
  /// In ja, this message translates to:
  /// **'言語'**
  String get language;

  /// No description provided for @pushNotifications.
  ///
  /// In ja, this message translates to:
  /// **'プッシュ通知'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsSub.
  ///
  /// In ja, this message translates to:
  /// **'クーポンやキャンペーンのお知らせ'**
  String get pushNotificationsSub;

  /// No description provided for @aboutApp.
  ///
  /// In ja, this message translates to:
  /// **'このアプリについて'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In ja, this message translates to:
  /// **'バージョン'**
  String get version;

  /// No description provided for @environment.
  ///
  /// In ja, this message translates to:
  /// **'環境'**
  String get environment;

  /// No description provided for @demoNotice.
  ///
  /// In ja, this message translates to:
  /// **'KOMOREBI COFFEE は架空のカフェチェーンです。このアプリはポートフォリオ用のデモです。'**
  String get demoNotice;

  /// No description provided for @devTools.
  ///
  /// In ja, this message translates to:
  /// **'開発者ツール'**
  String get devTools;

  /// No description provided for @devFailureRate.
  ///
  /// In ja, this message translates to:
  /// **'疑似エラーの発生率'**
  String get devFailureRate;

  /// No description provided for @devSimulateOffline.
  ///
  /// In ja, this message translates to:
  /// **'オフラインを再現'**
  String get devSimulateOffline;

  /// No description provided for @devSimulateOfflineSub.
  ///
  /// In ja, this message translates to:
  /// **'通信を遮断してキャッシュ表示を確認できます'**
  String get devSimulateOfflineSub;

  /// No description provided for @devResetData.
  ///
  /// In ja, this message translates to:
  /// **'ローカルデータを初期化'**
  String get devResetData;

  /// No description provided for @devResetConfirm.
  ///
  /// In ja, this message translates to:
  /// **'ポイント・注文・クーポンの利用履歴がすべて削除されます。'**
  String get devResetConfirm;

  /// No description provided for @logout.
  ///
  /// In ja, this message translates to:
  /// **'ログアウト'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In ja, this message translates to:
  /// **'ログアウトしますか？'**
  String get logoutConfirm;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
