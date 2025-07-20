// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryRequest _$StoryRequestFromJson(Map<String, dynamic> json) => StoryRequest(
      genre: json['genre'] as String,
      numberOfCharacters: (json['number_of_characters'] as num?)?.toInt(),
      nameOfCharacters: (json['name_of_characters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      paragraphs: (json['paragraphs'] as num?)?.toInt() ?? 2,
      generateImages: json['generate_images'] as bool? ?? false,
    );

Map<String, dynamic> _$StoryRequestToJson(StoryRequest instance) =>
    <String, dynamic>{
      'genre': instance.genre,
      'number_of_characters': instance.numberOfCharacters,
      'name_of_characters': instance.nameOfCharacters,
      'paragraphs': instance.paragraphs,
      'generate_images': instance.generateImages,
    };
