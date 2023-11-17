import 'package:flutter/material.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/person.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../domain/models/business/vehicle.dart';

class VehicleSelector extends StatefulWidget {
  const VehicleSelector({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;
  @override
  State<VehicleSelector> createState() => _VehicleSelectorState();
}

class _VehicleSelectorState extends State<VehicleSelector> {
  String selectedVehicle = '';
  String selectedIcon = '';
  final String _textHint = '';
  @override
  void initState() {
    super.initState();

    if (User.getInstance().personData!.uVehicle != '') {
      Vehicle.VehicleList(context).forEach((element) {
        String vehicle = User.getInstance().personData!.uVehicle;
        print(vehicle);
        if (element.name == vehicle) {
          setState(() {
            selectedVehicle = element.name;
            selectedIcon = element.emoji;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                selectedIcon.compareTo('') == 0
                    ? const Icon(Icons.directions_run)
                    : Text(
                        selectedIcon,
                        style: const TextStyle(fontSize: 20, height: -0.4),
                      ),
                const SizedBox(
                  width: 8,
                ),
                Text((selectedVehicle == 'motorcycle')
                    ? translation(context)!.motorcycle
                    : (selectedVehicle == 'car')
                        ? translation(context)!.car
                        : (selectedVehicle == 'truck')
                            ? translation(context)!.truck
                            : (selectedVehicle == 'bus')
                                ? translation(context)!.bus
                                : translation(context)!.other),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<Vehicle>(
                //value: selectedVehicle, // Asigna el valor seleccionado al DropdownButton
                iconSize: 30,
                alignment: Alignment.centerRight,
                //underline: const SizedBox(),
                hint: Text(_textHint),
                onChanged: (Vehicle? vehicle) async {
                  if (vehicle != null) {
                    print(vehicle.name);
                    setState(() {
                      selectedVehicle = vehicle.name;
                      selectedIcon = vehicle.emoji;
                    });

                    widget.person.uVehicle = vehicle.name;
                  } else {
                    widget.person.uVehicle =
                        User.getInstance().personData!.uVehicle;
                  }
                },
                items: Vehicle.VehicleList(context)
                    .map<DropdownMenuItem<Vehicle>>(
                      (entry) => DropdownMenuItem<Vehicle>(
                        value: entry, // Asigna el objeto Vehicle como valor

                        child: Row(
                          children: [
                            Text(
                              entry.emoji,
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              entry.name=='motorcycle'?translation(context)!.motorcycle:entry.name=='car'?translation(context)!.car:entry.name=='truck'?translation(context)!.truck:entry.name=='bus'?translation(context)!.bus:translation(context)!.other,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
