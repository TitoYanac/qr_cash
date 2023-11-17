class Vehicle{
  final int id;
  final String emoji;
  final String name;

  Vehicle(this.id, this.emoji, this.name);

  static List<Vehicle> VehicleList(context){
    return <Vehicle>[
      Vehicle(1, "🏍️", "motorcycle"),
      Vehicle(2, "🏎️", "car"),
      Vehicle(3, "🚚", "truck"),
      Vehicle(4, "🚌", "bus"),
      Vehicle(5, "🛺", "other"),
    ];
  }
}