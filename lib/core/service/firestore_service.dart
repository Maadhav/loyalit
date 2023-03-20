import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loyalit/core/model/coupon.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Coupon> getCoupon(String email) async {
    var snapshot = await _firestore.collection('users').doc(email).get();

    final data = snapshot.data() as Map<String, dynamic>;
    return Coupon(
      name: "Wild Birds",
      description: "R.U.N.N.I.N.G",
      currentMilestone: data['milestone'],
      discount: data['milestone'] * 5,
      consecutiveDays: data['consecutiveDays'],
      daysUntilNextMilestone: data['daysUntilNextMilestone'],
      heightestMilestone: data['previousMilestone'],
      highestConsecutiveDays: data['highestConsecutiveDays'] ?? 0,
      image: "https://i.imgur.com/5cZyihP.png",
      nftId: data['nftid'],
      usesLeft: 1,
    );
  }
}
