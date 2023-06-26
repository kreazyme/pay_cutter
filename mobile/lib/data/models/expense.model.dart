import 'package:json_annotation/json_annotation.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/data/models/location.model.dart';
import 'package:pay_cutter/data/models/user/user.model.dart';

part 'expense.model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int id;
  final String name;
  final String? description;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel createdBy;
  final List<UserModel> participants;
  final String? imageURL;
  final CategoryModel? category;
  final LocationModel? location;

  ExpenseModel({
    required this.id,
    required this.name,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.participants,
    this.imageURL,
    this.category,
    this.location,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
