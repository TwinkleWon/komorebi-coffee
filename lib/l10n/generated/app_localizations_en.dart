import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'KOMOREBI COFFEE';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get seeAll => 'See all';

  @override
  String staleData(String time) {
    return 'Showing saved data from $time';
  }

  @override
  String get offlineBanner => 'You\'re offline · showing saved data';

  @override
  String get backOnline => 'Back online';

  @override
  String get errorNetworkTitle => 'You\'re offline';

  @override
  String get errorNetworkMessage => 'Check your internet connection and try again.';

  @override
  String get errorTimeoutTitle => 'No response';

  @override
  String get errorTimeoutMessage => 'The request timed out. Please try again somewhere with a better signal.';

  @override
  String get errorServerTitle => 'We\'re a little busy';

  @override
  String errorServerMessage(int code) {
    return 'Something went wrong on our side ($code). Please try again shortly.';
  }

  @override
  String get errorGenericTitle => 'Please check';

  @override
  String get errorUnknownMessage => 'An unexpected error occurred.';

  @override
  String get errorCouponAlreadyUsed => 'This coupon has already been used.';

  @override
  String get errorCouponExpired => 'This coupon has expired.';

  @override
  String get errorStoreClosed => 'The store is closed at your pickup time or doesn\'t support mobile ordering.';

  @override
  String get errorInsufficientPoints => 'You don\'t have enough points.';

  @override
  String get errorNotFound => 'We couldn\'t find what you were looking for.';

  @override
  String get navHome => 'Home';

  @override
  String get navOrder => 'Order';

  @override
  String get navCard => 'Card';

  @override
  String get navCoupons => 'Coupons';

  @override
  String get navStores => 'Stores';

  @override
  String get loginTagline => 'A pause, like sunlight through the leaves.';

  @override
  String get loginWithLine => 'Log in with LINE';

  @override
  String get loginTerms => 'By logging in, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get loginDemoNote => 'Demo build: no real LINE authentication is performed';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String greetingName(String name) {
    return '$name';
  }

  @override
  String get pointsBalance => 'Points';

  @override
  String get showMemberCard => 'Card';

  @override
  String get quickOrder => 'Mobile order';

  @override
  String get quickOrderSub => 'Skip the line';

  @override
  String get quickCoupons => 'Coupons';

  @override
  String quickCouponsSub(int count) {
    return '$count available';
  }

  @override
  String get quickStores => 'Stores';

  @override
  String get quickStoresSub => 'See how busy';

  @override
  String get seasonalTitle => 'Sweet Potato Hojicha Latte';

  @override
  String get seasonalBody => 'Toasty hojicha layered with the gentle sweetness of roasted sweet potato. November only.';

  @override
  String get seasonalCta => 'Order now';

  @override
  String get homeNews => 'News';

  @override
  String get activeOrderTitle => 'Your order';

  @override
  String get cardTitle => 'Member card';

  @override
  String get cardInstruction => 'Show this code to our staff when you pay';

  @override
  String cardRefreshIn(int seconds) {
    return 'Code refreshes in ${seconds}s';
  }

  @override
  String get memberNumber => 'Member No.';

  @override
  String nextRank(String rank, String points) {
    return '$points pt to $rank';
  }

  @override
  String get topRank => 'You\'ve reached the top rank. Thank you!';

  @override
  String lifetimePoints(String points) {
    return 'Lifetime $points pt';
  }

  @override
  String get pointsHistory => 'Point history';

  @override
  String get pointsHistoryEmpty => 'No point history yet';

  @override
  String get pointReasonWelcome => 'Welcome bonus';

  @override
  String pointReasonOrderEarn(int number) {
    return 'Mobile order No.$number';
  }

  @override
  String pointReasonOrderSpend(int number) {
    return 'Points used No.$number';
  }

  @override
  String get couponsTitle => 'Coupons';

  @override
  String get couponsAvailable => 'Available';

  @override
  String get couponsHistory => 'Used & expired';

  @override
  String get couponsEmptyAvailable => 'No coupons available right now';

  @override
  String get couponsEmptyHistory => 'No used coupons yet';

  @override
  String couponExpiresOn(String date) {
    return 'Until $date';
  }

  @override
  String couponDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '1 day left',
      zero: 'Ends today',
    );
    return '$_temp0';
  }

  @override
  String get couponUsed => 'Used';

  @override
  String get couponExpired => 'Expired';

  @override
  String get couponConditions => 'Terms';

  @override
  String get couponUse => 'Use this coupon';

  @override
  String get couponConfirmTitle => 'Use this coupon?';

  @override
  String get couponConfirmBody => 'Let our staff know at the register, then tap \"Use\". This can\'t be undone.';

  @override
  String get couponConfirmAction => 'Use';

  @override
  String get couponRedeemedTitle => 'Thank you!';

  @override
  String get couponRedeemedBody => 'Please show this screen to our staff';

  @override
  String couponRedeemedAt(String time) {
    return 'Used at $time';
  }

  @override
  String get storesTitle => 'Stores';

  @override
  String storeOpenUntil(String time) {
    return 'Open · until $time';
  }

  @override
  String storeClosedOpensAt(String time) {
    return 'Closed · opens $time';
  }

  @override
  String get storeOpen24h => 'Open 24 hours';

  @override
  String get congestionLow => 'Quiet';

  @override
  String get congestionModerate => 'Busy';

  @override
  String get congestionHigh => 'Very busy';

  @override
  String get congestionClosed => 'Closed';

  @override
  String get congestionTitle => 'How busy it is now';

  @override
  String get storeHours => 'Hours';

  @override
  String get weekdays => 'Weekdays';

  @override
  String get weekends => 'Weekends & holidays';

  @override
  String get storeAddress => 'Address';

  @override
  String get storePhone => 'Phone';

  @override
  String get storeFeatures => 'Amenities';

  @override
  String get featureWifi => 'Wi-Fi';

  @override
  String get featurePower => 'Power outlets';

  @override
  String get featureTerrace => 'Terrace';

  @override
  String get featureRoastery => 'Roastery';

  @override
  String get featureMobileOrder => 'Mobile order';

  @override
  String get storeOrderHere => 'Order ahead at this store';

  @override
  String get storeNoMobileOrder => 'This store doesn\'t support mobile ordering';

  @override
  String get orderTitle => 'Mobile order';

  @override
  String get pickupStore => 'Pickup store';

  @override
  String get selectStore => 'Choose a store';

  @override
  String get selectStoreHint => 'Tap to choose where to pick up';

  @override
  String get changeStore => 'Change';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryCoffee => 'Coffee';

  @override
  String get categoryTea => 'Tea';

  @override
  String get categorySeasonal => 'Seasonal';

  @override
  String get categoryFood => 'Food';

  @override
  String get soldOut => 'Sold out';

  @override
  String get size => 'Size';

  @override
  String get temperature => 'Temperature';

  @override
  String get quantity => 'Quantity';

  @override
  String addToCart(String price) {
    return 'Add to cart · $price';
  }

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get viewCart => 'View cart';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get cartTitle => 'Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get browseMenu => 'Browse the menu';

  @override
  String get pickupTime => 'Pickup time';

  @override
  String get pickupAsap => 'ASAP (~5 min)';

  @override
  String get pickupIn15 => 'In 15 min';

  @override
  String get pickupIn30 => 'In 30 min';

  @override
  String get usePoints => 'Use points';

  @override
  String usePointsBalance(String points) {
    return 'Balance $points pt';
  }

  @override
  String get subtotal => 'Subtotal';

  @override
  String get pointsDiscount => 'Points';

  @override
  String get total => 'Total';

  @override
  String earnPreview(int points) {
    return 'You\'ll earn $points pt with this order';
  }

  @override
  String placeOrder(String price) {
    return 'Place order · $price';
  }

  @override
  String get payAtStore => 'Pay at the store (demo)';

  @override
  String get checkoutFailed => 'Couldn\'t send your order';

  @override
  String get checkoutRetryNote => 'Retrying is safe. Your order will not be duplicated.';

  @override
  String get orderThanks => 'Thank you for your order';

  @override
  String get orderNumberLabel => 'Order No.';

  @override
  String get statusReceived => 'Received';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusReady => 'Ready';

  @override
  String get readyMessage => 'Please pick up at the counter';

  @override
  String preparingMessage(String time) {
    return 'Ready around $time';
  }

  @override
  String get orderItems => 'Items';

  @override
  String get pointsEarned => 'Points earned';

  @override
  String get backToHome => 'Back to home';

  @override
  String get orderHistory => 'Order history';

  @override
  String get orderHistoryEmpty => 'No orders yet';

  @override
  String get newsTitle => 'News';

  @override
  String get newsEmpty => 'No news';

  @override
  String get newsCampaign => 'Campaign';

  @override
  String get newsNewProduct => 'New';

  @override
  String get newsInfo => 'Info';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get linkedWithLine => 'Linked with LINE';

  @override
  String get general => 'General';

  @override
  String get language => 'Language';

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get pushNotificationsSub => 'Coupons and campaigns';

  @override
  String get aboutApp => 'About';

  @override
  String get version => 'Version';

  @override
  String get environment => 'Environment';

  @override
  String get demoNotice => 'KOMOREBI COFFEE is a fictional café chain. This app is a portfolio demo.';

  @override
  String get devTools => 'Developer tools';

  @override
  String get devFailureRate => 'Simulated failure rate';

  @override
  String get devSimulateOffline => 'Simulate offline';

  @override
  String get devSimulateOfflineSub => 'Cut the network to check cached data';

  @override
  String get devResetData => 'Reset local data';

  @override
  String get devResetConfirm => 'All points, orders and coupon history will be deleted.';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Log out?';
}
