import 'dart:convert';

class ContactEntity {
  String? Name='';
  String? Office='';
  String? Mobile='';
  String? Email='';
  String? Languages='';

  ContactEntity({
    this.Name='',
    this.Office='',
    this.Mobile='',
    this.Email='',
    this.Languages='',
  });

  Map<String, dynamic> toMap() => {
    'Name': Name,
    'Office': Office,
    'Mobile': Mobile,
    'Email': Email,
    'Languages': Languages,
  };

  String toJson() => jsonEncode(toMap());

  factory ContactEntity.fromJson(Map<String, dynamic>? json) {
    return json!=null?ContactEntity(
      Name: json['Name'],
      Office: json['Office'],
      Mobile: json['Mobile'],
      Email: json['Email'],
      Languages: json['Languages'],
    ):ContactEntity();
  }
}
