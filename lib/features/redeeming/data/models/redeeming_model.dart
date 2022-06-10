import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';

class RedeemingModel extends RedeemingEntity {
  RedeemingModel(
      {required super.name, required super.image, required super.items});

  factory RedeemingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return RedeemingModel(
      name: documentSnapshot.get('name'),
      items: (documentSnapshot.get('items') as List)
          .map((data) => RedeemingItemsModel.fromJson(data))
          .toList(),
      image: documentSnapshot.get('image'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "items": items,
      "image": image,
    };
  }
}
