import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required super.createdOn,
    required super.totalPoints,
    required super.totalSteps,
    required super.userId,
    super.id,
  });

  factory DashboardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DashboardModel(
      id: documentSnapshot.id,
      createdOn: documentSnapshot.get('created_on'),
      totalPoints: documentSnapshot.get('total_points'),
      totalSteps: documentSnapshot.get('total_steps'),
      userId: documentSnapshot.get('user_id'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "total_points": totalPoints,
      "created_on": createdOn,
      "total_steps": totalSteps,
      "user_id": userId
    };
  }

  DashboardModel copyWith({
    Timestamp? createdOn,
    String? id,
    String? userId,
    int? totalPoints,
    int? totalSteps,
  }) {
    return DashboardModel(
      createdOn: createdOn ?? this.createdOn,
      id: id ?? this.id,
      totalPoints: totalPoints ?? this.totalPoints,
      totalSteps: totalSteps ?? this.totalSteps,
      userId: userId ?? this.userId,
    );
  }
}
