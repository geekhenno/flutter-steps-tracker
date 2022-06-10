import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';

class RedeemingEntity {
  final String name;
  final String image;
  final List<RedeemingItemsModel> items;
  RedeemingEntity(
      {required this.name, required this.image, required this.items});
}
