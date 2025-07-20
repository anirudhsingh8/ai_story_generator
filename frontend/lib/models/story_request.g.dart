// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryRequest _$StoryRequestFromJson(Map<String, dynamic> json) => StoryRequest(
      genre: json['genre'] as String,
      numberOfCharacters: (json['numberOfCharacters'] as num?)?.toInt(),
      nameOfCharacters: (json['nameOfCharacters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      paragraphs: (json['paragraphs'] as num?)?.toInt() ?? 2,
      generateImages: json['generateImages'] as bool? ?? false,
    );

Map<String, dynamic> _$StoryRequestToJson(StoryRequest instance) =>
    <String, dynamic>{
      'genre': instance.genre,
      'numberOfCharacters': instance.numberOfCharacters,
      'nameOfCharacters': instance.nameOfCharacters,
      'paragraphs': instance.paragraphs,
      'generateImages': instance.generateImages,
    };
