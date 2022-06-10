import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardEntity {
  final Timestamp createdOn;
  final int totalPoints;
  final int totalSteps;
  final String userId;
  final String? id;

  DashboardEntity({
    required this.createdOn,
    required this.totalPoints,
    required this.totalSteps,
    required this.userId,
    this.id,
  });
}
