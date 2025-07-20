import 'package:json_annotation/json_annotation.dart';

part 'story_request.g.dart';

@JsonSerializable()
class StoryRequest {
  final String genre;
  @JsonKey(name: 'number_of_characters')
  final int? numberOfCharacters;
  @JsonKey(name: 'name_of_characters')
  final List<String>? nameOfCharacters;
  final int paragraphs;
  @JsonKey(name: 'generate_images')
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
