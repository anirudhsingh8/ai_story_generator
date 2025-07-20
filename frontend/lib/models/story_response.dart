import 'package:json_annotation/json_annotation.dart';
import 'content_response.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse {
  final String summary;
  final List<Content> contents;

  StoryResponse({
    required this.summary,
    required this.contents,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);
}
