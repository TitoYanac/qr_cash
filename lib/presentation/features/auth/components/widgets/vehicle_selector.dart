import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/person.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../domain/models/business/vehicle.dart';

class VehicleSelector extends StatefulWidget {
  const VehicleSelector({
    super.key,
    required this.person,
  });
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
      Vehicle.vehicleList(context).forEach((element) {
        String vehicle = User.getInstance().personData!.uVehicle;
        //print(vehicle);
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

    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 12),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedIcon.compareTo('') == 0
                      ? const Icon(Icons.directions_run)
                      : Container(
                          width: 20,
                          height: 20,
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            selectedIcon,
                            fit: BoxFit.contain,
                          ),
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
                height: 48.0,
                child: DropdownButton<Vehicle>(
                  //value: selectedVehicle, // Asigna el valor seleccionado al DropdownButton
                  iconSize: 30,
                  alignment: Alignment.centerRight,
                  //underline: const SizedBox(),
                  isDense: true,
                  hint: Text(_textHint),
                  onChanged: (Vehicle? vehicle) async {
                    if (vehicle != null) {
                      //print(vehicle.name);
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
                  items: Vehicle.vehicleList(context)
                      .map<DropdownMenuItem<Vehicle>>(
                        (entry) => DropdownMenuItem<Vehicle>(
                          value: entry, // Asigna el objeto Vehicle como valor

                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.transparent,
                                child: SvgPicture.asset(
                                  entry.emoji,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                entry.name == 'motorcycle'
                                    ? translation(context)!.motorcycle
                                    : entry.name == 'car'
                                        ? translation(context)!.car
                                        : entry.name == 'truck'
                                            ? translation(context)!.truck
                                            : entry.name == 'bus'
                                                ? translation(context)!.bus
                                                : translation(context)!.other,
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
      ),
    );
  }
}
