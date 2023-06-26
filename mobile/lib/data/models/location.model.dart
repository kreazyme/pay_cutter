import 'package:json_annotation/json_annotation.dart';

part 'location.model.g.dart';

@JsonSerializable()
class LocationModel {
  final double lat;
  final double lng;
  final String address;

  const LocationModel({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
