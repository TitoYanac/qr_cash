import 'dart:convert';

class ContactEntity {
  String? name = '';
  String? office = '';
  String? mobile = '';
  String? email = '';
  String? languages = '';

  ContactEntity({
    this.name = '',
    this.office = '',
    this.mobile = '',
    this.email = '',
    this.languages = '',
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'office': office,
    'mobile': mobile,
    'email': email,
    'languages': languages,
  };

  String toJson() => jsonEncode(toMap());

  factory ContactEntity.fromJson(Map<String, dynamic>? json) {
    return json != null
        ? ContactEntity(
      name: json['name'],
      office: json['office'],
      mobile: json['mobile'],
      email: json['email'],
      languages: json['languages'],
    )
        : ContactEntity();
  }
}
