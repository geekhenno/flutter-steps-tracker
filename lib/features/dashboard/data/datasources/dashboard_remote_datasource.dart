import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/features/dashboard/data/models/dashboard_model.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/usecases/update_steps_points_usecase.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';

abstract class IDashboardRemoteDataSource {
  Future<List<DashboardModel>> getUserDashboard();
  Future<bool> updateStepsPoint(UpdateStepsPointsParams params);
}

final dashboardRemoteDataSourceImplProvider =
    Provider<DashboardRemoteDataSource>(
        (ref) => DashboardRemoteDataSource(ref.watch(firebaseClientProvider)));

class DashboardRemoteDataSource implements IDashboardRemoteDataSource {
  final FirebaseClient _firebaseClient;
  DashboardRemoteDataSource(this._firebaseClient);

  @override
  Future<List<DashboardModel>> getUserDashboard() async {
    final dashboard = await _firebaseClient.firebaseFirestore
        .collection('steps')
        .where('user_id', isEqualTo: _firebaseClient.auth.currentUser?.uid)
        .get();
    return dashboard.docs
        .map((item) => DashboardModel.fromSnapshot(item))
        .toList();
  }

  @override
  Future<bool> updateStepsPoint(UpdateStepsPointsParams params) async {
    DateTime _now = DateTime.now();
    DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);

    final response = await _firebaseClient.firebaseFirestore
        .collection('steps')
        .where(
          'user_id',
          isEqualTo: _firebaseClient.auth.currentUser?.uid,
        )
        .where('created_on', isGreaterThanOrEqualTo: _start)
        .where('created_on', isLessThanOrEqualTo: _end)
        .get();

    final items =
        response.docs.map((item) => DashboardModel.fromSnapshot(item)).toList();
    if (items.isEmpty) {
      await _firebaseClient.firebaseFirestore
          .collection('steps')
          .add(DashboardModel(
            totalSteps: params.steps,
            totalPoints: params.points,
            createdOn: Timestamp.now(),
            userId: params.userId,
          ).toDocument()); // <-- Doc ID where data should be updated.

    } else {
      await _firebaseClient.firebaseFirestore
          .collection('steps')
          .doc(items.first.id) // <-- Doc ID where data should be updated.
          .update(items.first
              .copyWith(
                totalSteps: params.steps,
                totalPoints: params.points,
                createdOn: Timestamp.now(),
              )
              .toDocument());
    }

    return true;
  }
}
