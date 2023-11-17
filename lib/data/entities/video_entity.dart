import 'dart:convert';

class VideoEntity {
  String? Code='';
  String? Name='';
  String? Type='';
  String? Url='';

  VideoEntity({
    this.Code='',
     this.Name='',
     this.Type='',
     this.Url='',
  });

  Map<String, dynamic> toMap() => {
        'Code': Code,
        'Name': Name,
        'Type': Type,
        'Url': Url,
      };

  String toJson() => jsonEncode(toMap());

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      Code: "${json['Code']??''}",
      Name: "${json['Name']??''}",
      Type: "${json['Type']??''}",
      Url: "${json['Url']??''}",
    );
  }
}
