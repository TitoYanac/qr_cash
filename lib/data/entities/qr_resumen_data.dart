class QrResumenData {
  String? mobile='';
  String? qr='';
  String? date='';
  String? status='';
  String? monto='0';

  QrResumenData({
    this.mobile='',
    this.qr='',
    this.date='',
    this.status='',
    this.monto='0',
  });

  factory QrResumenData.fromJson(Map<String, dynamic>? json) {
    return json!=null?QrResumenData(
      mobile: "${json['Mobile']??''}",
      qr: "${json['QR']??''}",
      date: "${json['Date']??''}",
      status: "${json['Status']??''}",
      monto: "${json['Monto']??''}",
    ):QrResumenData();
  }

  Map<String, dynamic> toJson() {
    return {
      'Mobile': mobile,
      'QR': qr,
      'Date': date,
      'Status': status,
      'Monto': monto,
    };
  }
}