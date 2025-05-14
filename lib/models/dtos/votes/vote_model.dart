class DetailReview {
  final int roomId;
  final int userId;
  final int star;
  final String commemt;
  final DateTime create;

  DetailReview({
    required this.roomId,
    required this.userId,
    required this.star,
    required this.commemt,
    required this.create,
  });

  factory DetailReview.fromJson(Map<String, dynamic> json) {
    return DetailReview(
      roomId: json['roomId'],
      userId: json['userId'],
      star: json['star'],
      commemt: json['commemt'],
      create: DateTime.parse(json['create']),
    );
  }
}

class VoteData {
  final int roomId;
  final int total;
  final double value;
  final List<DetailReview> detailReviews;

  VoteData({
    required this.roomId,
    required this.total,
    required this.value,
    required this.detailReviews,
  });

  factory VoteData.fromJson(Map<String, dynamic> json) {
    return VoteData(
      roomId: json['roomId'],
      total: json['total'],
      value: json['value'].toDouble(),
      detailReviews: (json['detailReviews'] as List)
          .map((e) => DetailReview.fromJson(e))
          .toList(),
    );
  }
}
