import 'package:cloud_firestore/cloud_firestore.dart';

class RedeemingItemsModel {
  final int id;
  final String itemImage;
  final String name;
  final int points;
  final Timestamp? createdOn;
  final String? userId;

  const RedeemingItemsModel({
    required this.id,
    required this.itemImage,
    required this.name,
    required this.points,
    this.createdOn,
    this.userId,
  });

  factory RedeemingItemsModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return RedeemingItemsModel(
      id: documentSnapshot.get('id'),
      name: documentSnapshot.get('name'),
      itemImage: documentSnapshot.get('item_image'),
      points: documentSnapshot.get('points'),
      createdOn: documentSnapshot.get('created_on'),
      userId: documentSnapshot.get('user_id'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "name": name,
      "item_image": itemImage,
      "points": points,
      "created_on": createdOn,
      "user_id": userId
    };
  }

  RedeemingItemsModel copyWith({
    int? id,
    String? itemImage,
    String? name,
    int? points,
    Timestamp? createdOn,
    String? userId,
  }) {
    return RedeemingItemsModel(
      id: id ?? this.id,
      itemImage: itemImage ?? this.itemImage,
      name: name ?? this.name,
      points: points ?? this.points,
      createdOn: createdOn ?? this.createdOn,
      userId: userId ?? this.userId,
    );
  }

  factory RedeemingItemsModel.fromJson(Map<String, dynamic> map) {
    return RedeemingItemsModel(
      id: map['id'] as int,
      itemImage: map['item_image'] as String,
      name: map['name'] as String,
      points: map['points'] as int,
    );
  }

//</editor-fold>
}
