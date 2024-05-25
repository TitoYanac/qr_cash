import 'dart:convert';

class VideoEntity {
  String? code = '';
  String? name = '';
  String? type = '';
  String? url = '';
  String? description = '';

  VideoEntity({
    this.code = '',
    this.name = '',
    this.type = '',
    this.url = '',
    this.description = '',
  });

  Map<String, dynamic> toMap() => {
    'Code': code,
    'Name': name,
    'Type': type,
    'Url': url,
    'Description': description,
  };

  String toJson() => jsonEncode(toMap());

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      code: "${json['Code']??''}",
      name: "${json['Name']??''}",
      type: "${json['Type']??''}",
      url: "${json['Url']??''}",
      description: "${json['Description']??'-'}",
    );
  }
}
