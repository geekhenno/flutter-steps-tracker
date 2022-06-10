import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_model.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';

abstract class IRedeemingRemoteDataSource {
  Future<List<RedeemingModel>> getAllRedeemingPartners();
  Future<List<RedeemingItemsModel>> getHistoryRedeem(String userId);
  Future<bool> redeem(RedeemingItemsModel item);
}

final redeemingRemoteDataSourceImplProvider =
    Provider<RedeemingRemoteDataSource>(
        (ref) => RedeemingRemoteDataSource(ref.watch(firebaseClientProvider)));

class RedeemingRemoteDataSource implements IRedeemingRemoteDataSource {
  final FirebaseClient _firebaseClient;
  RedeemingRemoteDataSource(this._firebaseClient);

  @override
  Future<List<RedeemingModel>> getAllRedeemingPartners() async {
    final partnersRef =
        await _firebaseClient.firebaseFirestore.collection('partners').get();
    return partnersRef.docs
        .map((partner) => RedeemingModel.fromSnapshot(partner))
        .toList();
  }

  @override
  Future<bool> redeem(RedeemingItemsModel item) async {
    await _firebaseClient.firebaseFirestore
        .collection('redeeming')
        .add(item.toDocument());

    return true;
  }

  @override
  Future<List<RedeemingItemsModel>> getHistoryRedeem(String userId) async {
    final ref = await _firebaseClient.firebaseFirestore
        .collection('redeeming')
        .where('user_id', isEqualTo: userId)
        .get();
    return ref.docs
        .map((item) => RedeemingItemsModel.fromSnapshot(item))
        .toList();
  }
}
