import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelImagePicker {
  String nameImage;
  String base64;
  ModelImagePicker({
    required this.nameImage,
    required this.base64,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameImage': nameImage,
      'base64': base64,
    };
  }

  factory ModelImagePicker.fromMap(Map<String, dynamic> map) {
    return ModelImagePicker(
      nameImage: map['nameImage'] as String,
      base64: map['base64'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelImagePicker.fromJson(String source) =>
      ModelImagePicker.fromMap(json.decode(source) as Map<String, dynamic>);
}
