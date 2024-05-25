class Vehicle{
  final int id;
  final String emoji;
  final String name;

  Vehicle(this.id, this.emoji, this.name);

  static List<Vehicle> vehicleList(context){
    return <Vehicle>[
      Vehicle(1, "assets/icons/moto.svg", "motorcycle"),
      Vehicle(2, "assets/icons/auto.svg", "car"),
      Vehicle(3, "assets/icons/camion.svg", "truck"),
      Vehicle(4, "assets/icons/bus.svg", "bus"),
      Vehicle(5, "assets/icons/mototaxi.svg", "other"),
    ];
  }
}