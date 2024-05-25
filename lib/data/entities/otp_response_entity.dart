
class OtpResponseEntity {
  String status='';
  String message='';
  String otp='';
  String timeOTP='';
  String statusSMS='';

  OtpResponseEntity({
    this.status='',
    this.message='',
    this.otp='',
    this.timeOTP='',
    this.statusSMS='',
  });

  factory OtpResponseEntity.fromJson(Map<String, dynamic>? json) {
    return json!=null?OtpResponseEntity(
      status: "${json['Status']??''}",
      message: "${json['Message']??''}",
      otp: "${json['OTP']??''}",
      timeOTP: "${json['TimeOTP']??''}",
      statusSMS: "${json['StatusSMS']??''}",
    ):OtpResponseEntity();
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Message': message,
      'OTP': otp,
      'TimeOTP': timeOTP,
      'StatusSMS': statusSMS,
    };
  }

  @override
  String toString() {
    return 'OtpResponseEntity{status: $status, message: $message, otp: $otp, timeOTP: $timeOTP, statusSMS: $statusSMS}';
  }
}
