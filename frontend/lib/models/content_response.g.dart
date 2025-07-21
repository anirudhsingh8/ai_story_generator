// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      text: json['text'] as String,
      imagePrompt: json['image_prompt'] as String?,
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'text': instance.text,
      'image_prompt': instance.imagePrompt,
      'image_path': instance.imagePath,
    };
