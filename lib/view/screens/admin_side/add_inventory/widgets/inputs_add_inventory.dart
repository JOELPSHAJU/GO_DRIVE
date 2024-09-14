import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/textformfields.dart';
import 'package:godrive/view/screens/universal_widgets/heading.dart';

class InputsAddInventory extends StatelessWidget {
  const InputsAddInventory({
    super.key,
    required this.modelnamecontroller,
    required this.enginedisplacementcontroller,
    required this.maxpowercontroller,
    required this.maxtorquecontroller,
    required this.zerotohndrdcontroller,
    required this.seatingcapacitycontroller,
    required this.numberplatecontroller,
    required this.fueltankcapacitycontroller,
    required this.gearboxcontroller,
    required this.priceperdaycontroller,
    required this.groundclearencecontroller,
    required this.overviewcontroller,
  });

  final TextEditingController modelnamecontroller;
  final TextEditingController enginedisplacementcontroller;
  final TextEditingController maxpowercontroller;
  final TextEditingController maxtorquecontroller;
  final TextEditingController zerotohndrdcontroller;
  final TextEditingController seatingcapacitycontroller;
  final TextEditingController numberplatecontroller;
  final TextEditingController fueltankcapacitycontroller;
  final TextEditingController gearboxcontroller;
  final TextEditingController priceperdaycontroller;
  final TextEditingController groundclearencecontroller;
  final TextEditingController overviewcontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.name,
            hint: 'Model Name',
            modelnamecontroller: modelnamecontroller),
        h10,
        const Heading(heading: 'Engine Displacement'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: ' eg : 1500 cc',
            modelnamecontroller: enginedisplacementcontroller),
        h10,
        const Heading(heading: 'Maximum Power'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg: 960 hp',
            modelnamecontroller: maxpowercontroller),
        h10,
        const Heading(heading: 'Maximum Torque'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg : 480 nm',
            modelnamecontroller: maxtorquecontroller),
        h10,
        const Heading(heading: '0-100 in seconds'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg : 3.2 seconds',
            modelnamecontroller: zerotohndrdcontroller),
        h10,
        const Heading(heading: 'Seating Capacity'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: ' eg: 2 person',
            modelnamecontroller: seatingcapacitycontroller),
        h10,
        const Heading(heading: 'Registration Plate'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.text,
            hint: ' eg: KL 07 AC 0000',
            modelnamecontroller: numberplatecontroller),
        h10,
        const Heading(heading: 'Fuel Tank Capacity'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg: 100 ltrs',
            modelnamecontroller: fueltankcapacitycontroller),
        h10,
        const Heading(heading: 'Gearbox'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg: 7 speed',
            modelnamecontroller: gearboxcontroller),
        h10,
        const Heading(heading: 'Price/day'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg: 4500/-',
            modelnamecontroller: priceperdaycontroller),
        h10,
        const Heading(heading: 'Ground Clearence'),
        h10,
        InputfieldsAddInventory(
            inputType: TextInputType.number,
            hint: 'eg : 128 mm',
            modelnamecontroller: groundclearencecontroller),
        h10,
        const Heading(heading: 'Overview'),
        h10,
        InputfieldsMinLine2(
            hint: 'write a description...',
            modelnamecontroller: overviewcontroller),
      ],
    );
  }
}
