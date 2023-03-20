import 'dart:convert';

class Coupon {
  final String name;
  final String description;
  final String image;
  final int discount;
  final int currentMilestone;
  final int heightestMilestone;
  final int consecutiveDays;
  final int highestConsecutiveDays;
  final int daysUntilNextMilestone;
  final int usesLeft;
  final String nftId;
  Coupon({
    required this.name,
    required this.description,
    required this.image,
    required this.discount,
    required this.currentMilestone,
    required this.heightestMilestone,
    required this.consecutiveDays,
    required this.highestConsecutiveDays,
    required this.daysUntilNextMilestone,
    required this.usesLeft,
    required this.nftId,
  });

  Coupon copyWith({
    String? name,
    String? description,
    String? image,
    int? discount,
    int? currentMilestone,
    int? heightestMilestone,
    int? consecutiveDays,
    int? highestConsecutiveDays,
    int? daysUntilNextMilestone,
    int? usesLeft,
    String? nftId,
  }) {
    return Coupon(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      discount: discount ?? this.discount,
      currentMilestone: currentMilestone ?? this.currentMilestone,
      heightestMilestone: heightestMilestone ?? this.heightestMilestone,
      consecutiveDays: consecutiveDays ?? this.consecutiveDays,
      highestConsecutiveDays: highestConsecutiveDays ?? this.highestConsecutiveDays,
      daysUntilNextMilestone: daysUntilNextMilestone ?? this.daysUntilNextMilestone,
      usesLeft: usesLeft ?? this.usesLeft,
      nftId: nftId ?? this.nftId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'discount': discount,
      'currentMilestone': currentMilestone,
      'heightestMilestone': heightestMilestone,
      'consecutiveDays': consecutiveDays,
      'highestConsecutiveDays': highestConsecutiveDays,
      'daysUntilNextMilestone': daysUntilNextMilestone,
      'usesLeft': usesLeft,
      'nftId': nftId,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
      currentMilestone: map['currentMilestone']?.toInt() ?? 0,
      heightestMilestone: map['heightestMilestone']?.toInt() ?? 0,
      consecutiveDays: map['consecutiveDays']?.toInt() ?? 0,
      highestConsecutiveDays: map['highestConsecutiveDays']?.toInt() ?? 0,
      daysUntilNextMilestone: map['daysUntilNextMilestone']?.toInt() ?? 0,
      usesLeft: map['usesLeft']?.toInt() ?? 0,
      nftId: map['nftId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) => Coupon.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Coupon(name: $name, description: $description, image: $image, discount: $discount, currentMilestone: $currentMilestone, heightestMilestone: $heightestMilestone, consecutiveDays: $consecutiveDays, highestConsecutiveDays: $highestConsecutiveDays, daysUntilNextMilestone: $daysUntilNextMilestone, usesLeft: $usesLeft, nftId: $nftId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Coupon &&
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.discount == discount &&
      other.currentMilestone == currentMilestone &&
      other.heightestMilestone == heightestMilestone &&
      other.consecutiveDays == consecutiveDays &&
      other.highestConsecutiveDays == highestConsecutiveDays &&
      other.daysUntilNextMilestone == daysUntilNextMilestone &&
      other.usesLeft == usesLeft &&
      other.nftId == nftId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      discount.hashCode ^
      currentMilestone.hashCode ^
      heightestMilestone.hashCode ^
      consecutiveDays.hashCode ^
      highestConsecutiveDays.hashCode ^
      daysUntilNextMilestone.hashCode ^
      usesLeft.hashCode ^
      nftId.hashCode;
  }
}
