class ResponseUpdatePersonDataEntity {
  String? code='';
  String? status='';

  ResponseUpdatePersonDataEntity({
    this.code='',
    this.status='',
  });


  factory ResponseUpdatePersonDataEntity.fromJson(Map<String, dynamic>? json) {
    print(json);
    return json!=null?ResponseUpdatePersonDataEntity(
        code: json['code'],
        status: json['status']
    ):ResponseUpdatePersonDataEntity();
  }

/*
  ResponseUpdatePersonData toResponseUpdatePersonData() {
    return ResponseUpdatePersonData(
      data: data,
    );
  }*/
}

