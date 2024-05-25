import 'package:flutter_bloc/flutter_bloc.dart';
class BlocQrScan extends Bloc<QrEvent, QrState>{

  BlocQrScan() : super(QrScanCameraOpened('')) {
    on<QrCameraOpened>((event, emit) => emit(QrScanCameraOpened(event.qrScanned)));
    on<QrCameraClosed>((event, emit) => emit(QrScanCameraClosed(event.qrScanned)));
  }

  void openCamera() => add(QrCameraOpened(''));

  void closeCamera(String qrScanned) => add(QrCameraClosed(qrScanned));

}

class QrEvent{
  String qrScanned;
  QrEvent(this.qrScanned);
}

class QrCameraOpened extends QrEvent{
  QrCameraOpened(super.qrScanned);
}

class QrCameraClosed extends QrEvent{
  QrCameraClosed(super.qrScanned);
}

class QrState{
  String qrScanned;
  QrState(this.qrScanned);
}

class QrScanCameraOpened extends QrState{
  QrScanCameraOpened(super.qrScanned);
}

class QrScanCameraClosed extends QrState{
  QrScanCameraClosed(super.qrScanned);
}








