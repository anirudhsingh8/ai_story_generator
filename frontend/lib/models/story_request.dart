import 'package:json_annotation/json_annotation.dart';

part 'story_request.g.dart';

@JsonSerializable()
class StoryRequest {
  final String genre;
  final int? numberOfCharacters;
  final List<String>? nameOfCharacters;
  final int paragraphs;
  final bool generateImages;

  StoryRequest({
    required this.genre,
    this.numberOfCharacters,
    this.nameOfCharacters,
    this.paragraphs = 2, // Default to 2 paragraphs as per requirements
    this.generateImages = false,
  });

  factory StoryRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StoryRequestToJson(this);
}
