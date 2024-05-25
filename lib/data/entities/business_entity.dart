import '../../domain/models/business/bank_manager.dart';
import '../../domain/models/business/contacts.dart';
import '../../domain/models/business/vehicle.dart';
import '../../domain/models/business/wallet.dart';

class BusinessEntity {
  Wallet? wallet = Wallet(entry: []);
  Contacts? contacts = Contacts(contacts: []);
  List<Vehicle> vehicles = [
    Vehicle(1, "🏍️", "motorcycle"),
    Vehicle(2, "🏎️", "car"),
    Vehicle(3, "🚚", "truck"),
    Vehicle(4, "🚌", "bus"),
    Vehicle(5, "🛸", "other"),
  ];
  //PayManager? payManager = PayManager(pays: []);
  BankManager? banks = BankManager(banks: []);

  saveModelFromApiData(Map<String, dynamic> responseData) {


  }

}
