import 'package:json_annotation/json_annotation.dart';

part 'information.g.dart';

@JsonSerializable()
class Information {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Information({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Information.fromJson(Map<String, dynamic> json) =>
      _$InformationFromJson(json);

  Map<String, dynamic> toJson() => _$InformationToJson(this);
}
