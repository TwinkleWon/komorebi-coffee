import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_transaction.freezed.dart';
part 'point_transaction.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum PointReason { welcome, orderEarn, orderSpend }

@freezed
class PointTransaction with _$PointTransaction {
  const factory PointTransaction({
    required String id,

    /// Positive when earned, negative when spent.
    required int amount,
    required PointReason reason,
    required DateTime createdAt,
    int? orderNumber,
  }) = _PointTransaction;

  factory PointTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionFromJson(json);
}

/// Membership tiers based on lifetime earned points.
enum MemberRank {
  bean('BEAN', 0),
  roast('ROAST', 500),
  reserve('RESERVE', 1500);

  const MemberRank(this.label, this.threshold);

  final String label;
  final int threshold;

  MemberRank? get next => switch (this) {
        bean => roast,
        roast => reserve,
        reserve => null,
      };

  static MemberRank fromLifetimePoints(int points) =>
      values.lastWhere((rank) => points >= rank.threshold);
}

@freezed
class PointSummary with _$PointSummary {
  const PointSummary._();

  const factory PointSummary({
    required int balance,
    required int lifetimeEarned,
    required List<PointTransaction> transactions,
  }) = _PointSummary;

  factory PointSummary.fromJson(Map<String, dynamic> json) =>
      _$PointSummaryFromJson(json);

  factory PointSummary.fromTransactions(List<PointTransaction> transactions) {
    final sorted = [...transactions]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return PointSummary(
      balance: transactions.fold(0, (sum, t) => sum + t.amount),
      lifetimeEarned: transactions
          .where((t) => t.amount > 0)
          .fold(0, (sum, t) => sum + t.amount),
      transactions: sorted,
    );
  }

  MemberRank get rank => MemberRank.fromLifetimePoints(lifetimeEarned);

  /// Points still needed to reach the next rank, or `null` at the top rank.
  int? get pointsToNextRank {
    final next = rank.next;
    return next == null ? null : next.threshold - lifetimeEarned;
  }

  /// 0.0 – 1.0 progress within the current rank.
  double get rankProgress {
    final next = rank.next;
    if (next == null) return 1;
    return (lifetimeEarned - rank.threshold) /
        (next.threshold - rank.threshold);
  }
}
