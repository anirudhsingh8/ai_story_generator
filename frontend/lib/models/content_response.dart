import 'package:json_annotation/json_annotation.dart';

part 'content_response.g.dart';

@JsonSerializable()
class Content {
  final String text;
  final String? imagePrompt;

  Content({
    required this.text,
    this.imagePrompt,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
