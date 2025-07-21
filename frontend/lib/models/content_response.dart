import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content_response.g.dart';

@JsonSerializable()
class Content {
  final String text;
  @JsonKey(name: 'image_prompt')
  final String? imagePrompt;
  @JsonKey(name: 'image_path')
  final String? imagePath;

  Content({
    required this.text,
    this.imagePrompt,
    this.imagePath,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  String get imageUrl => '${dotenv.env['API_BASE_URL']}/static/$imagePath';

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
