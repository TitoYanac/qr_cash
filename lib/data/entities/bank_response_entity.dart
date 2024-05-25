class BankResponseEntity {
  String code='';
  String name='';

  BankResponseEntity({
    this.code='',
    this.name='',
  });

  Map<String, dynamic> toJson() {
    return {'Code': code, 'Name': name};
  }
  factory BankResponseEntity.fromJson(Map<String, dynamic>? json) {
    return json!=null?BankResponseEntity(
      code: json['Code'],
      name: json['Name'],
    ):BankResponseEntity();
  }

  @override
  String toString() {
    return 'BankResponseEntity{code: $code, name: $name}';
  }
}
