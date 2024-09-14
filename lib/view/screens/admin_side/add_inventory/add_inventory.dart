import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/model/car_model.dart';
import 'package:godrive/view/bloc/add_inventory/add_inventory_bloc.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_category.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_company.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_fueltype.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_transmission.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/inputs_add_inventory.dart';
import 'package:godrive/view/screens/universal_widgets/heading.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';

import 'package:image_picker/image_picker.dart';

final ValueNotifier<String?> selectedCompany = ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedfueltype = ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedtransmissiontype =
    ValueNotifier<String?>(null);

// ignore: must_be_immutable
class AddInventory extends StatelessWidget {
  AddInventory({super.key});

  final ValueNotifier<String> pickImage = ValueNotifier('');
  final ValueNotifier<List<String>> pickImages = ValueNotifier([]);
  late XFile? file;
  late List<XFile> imgfiles = [];
  TextEditingController modelnamecontroller = TextEditingController();
  TextEditingController enginedisplacementcontroller = TextEditingController();
  TextEditingController maxpowercontroller = TextEditingController();
  TextEditingController maxtorquecontroller = TextEditingController();
  TextEditingController zerotohndrdcontroller = TextEditingController();
  TextEditingController seatingcapacitycontroller = TextEditingController();
  TextEditingController numberplatecontroller = TextEditingController();
  TextEditingController fueltankcapacitycontroller = TextEditingController();
  TextEditingController groundclearencecontroller = TextEditingController();
  TextEditingController gearboxcontroller = TextEditingController();
  TextEditingController overviewcontroller = TextEditingController();
  TextEditingController priceperdaycontroller = TextEditingController();
  final formKeyaddinventory = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        backgroundColor: black,
        surfaceTintColor: black,
        centerTitle: true,
        title: const Text(
          'ADD NEW INVENTORY',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: white),
        ),
      ),
      body: BlocProvider(
        create: (context) => AddInventoryBloc(),
        child: BlocListener<AddInventoryBloc, AddInventoryState>(
          listener: (context, state) {
            if (state is AddInventoryLoading) {
            } else if (state is AddInventorySucessState) {
              modelnamecontroller.clear();
              pickImage.value = '';
              pickImages.value = [];
              selectedfueltype.value = null;
              selectedtransmissiontype.value = null;
              selectedCompany.value = null;
              selectedCategory.value = null;
              enginedisplacementcontroller.clear();
              maxpowercontroller.clear();
              maxtorquecontroller.clear();
              zerotohndrdcontroller.clear();
              seatingcapacitycontroller.clear();
              numberplatecontroller.clear();
              fueltankcapacitycontroller.clear();
              groundclearencecontroller.clear();
              gearboxcontroller.clear();
              overviewcontroller.clear();
              priceperdaycontroller.clear();
              imgfiles.clear();
              file = null;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: green50,
                  content: Text('Upload Successful!'),
                ),
              );
            } else if (state is AddInventoryErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: red, content: Text('Upload Failed!')),
              );
            }
          },
          child: BlocBuilder<AddInventoryBloc, AddInventoryState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Inventory Main Image',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<String>(
                        valueListenable: pickImage,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                file = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (file != null) {
                                  pickImage.value = file!.path;
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Error picking image: $e');
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: Offset(0, 2))
                                    ],
                                    color: white,
                                  ),
                                  child: pickImage.value.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.photo,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? lightgrey
                                                  : darkgrey,
                                              size: 30,
                                            ),
                                          ],
                                        )
                                      : Image.file(
                                          File(pickImage.value),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                if (pickImage.value.isNotEmpty)
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          pickImage.value = '';
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: red,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Inventory Additional Images',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<List<String>>(
                        valueListenable: pickImages,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                imgfiles = await ImagePicker().pickMultiImage();
                                if (imgfiles.isNotEmpty) {
                                  pickImages.value = imgfiles
                                      .map((file) => file.path)
                                      .toList();
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Error picking images: $e');
                                }
                              }
                            },
                            child: Wrap(
                              spacing: 10,
                              children: pickImages.value.isEmpty
                                  ? [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 228, 228, 228),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 2))
                                          ],
                                          color: white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.photo,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? lightgrey
                                                  : darkgrey,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                  : pickImages.value.map((imagePath) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 228, 228, 228),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 2))
                                                ],
                                                color: white,
                                              ),
                                              child: Image.file(
                                                File(imagePath),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  pickImages.value = pickImages
                                                      .value
                                                      .where((path) =>
                                                          path != imagePath)
                                                      .toList();
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: red,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                            ),
                          );
                        },
                      ),
                      h20,
                      const Heading(heading: 'Company Name'),
                      h10,
                      DropdownCompany(
                          selectedCompany: selectedCompany, size: size),
                      h20,
                      const Heading(heading: 'Category'),
                      h10,
                      DropdownCategory(
                          selectedCategory: selectedCategory, size: size),
                      h20,
                      const Heading(heading: 'Fuel Type'),
                      h10,
                      DropdownFuelType(
                          selectedfueltype: selectedfueltype, size: size),
                      h20,
                      const Heading(heading: 'Transmission Type'),
                      h10,
                      DropdownTransmission(
                          selectedtransmission: selectedtransmissiontype,
                          size: size),
                      h20,
                      const Heading(heading: 'Model Name'),
                      Form(
                        key: formKeyaddinventory,
                        child: InputsAddInventory(
                            modelnamecontroller: modelnamecontroller,
                            enginedisplacementcontroller:
                                enginedisplacementcontroller,
                            maxpowercontroller: maxpowercontroller,
                            maxtorquecontroller: maxtorquecontroller,
                            zerotohndrdcontroller: zerotohndrdcontroller,
                            seatingcapacitycontroller:
                                seatingcapacitycontroller,
                            numberplatecontroller: numberplatecontroller,
                            fueltankcapacitycontroller:
                                fueltankcapacitycontroller,
                            gearboxcontroller: gearboxcontroller,
                            priceperdaycontroller: priceperdaycontroller,
                            groundclearencecontroller:
                                groundclearencecontroller,
                            overviewcontroller: overviewcontroller),
                      ),
                      h20,
                      BlocBuilder<AddInventoryBloc, AddInventoryState>(
                        builder: (context, state) {
                          if (state is AddInventoryLoading) {
                            return loadingButton(
                                media: size, onPressed: () {}, color: black);
                          }
                          return MaterialButton(
                            color: black,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              if (formKeyaddinventory.currentState!
                                  .validate()) {
                                CarModel carModel = CarModel(
                                  modelName: modelnamecontroller.text,
                                  engineDisplacement:
                                      enginedisplacementcontroller.text,
                                  maxPower: maxpowercontroller.text,
                                  maxTorque: maxtorquecontroller.text,
                                  zeroToHundred: zerotohndrdcontroller.text,
                                  seatingCapacity:
                                      seatingcapacitycontroller.text,
                                  numberPlate: numberplatecontroller.text,
                                  fuelTankCapacity:
                                      fueltankcapacitycontroller.text,
                                  groundClearance:
                                      groundclearencecontroller.text,
                                  gearbox: gearboxcontroller.text,
                                  overview: overviewcontroller.text,
                                  pricePerDay: priceperdaycontroller.text,
                                  mainImage: pickImage.value,
                                  additionalImages: pickImages.value,
                                  companyName: selectedCompany.value.toString(),
                                  category: selectedCategory.value.toString(),
                                  fuelType: selectedfueltype.value.toString(),
                                  transmissionType:
                                      selectedtransmissiontype.value.toString(),
                                );

                                context.read<AddInventoryBloc>().add(
                                      AddInventoryButtonClickEvent(
                                          cardetails: carModel),
                                    );
                              } else {
                                warningSnakbar(context, 'Fill All Fields', red);
                              }
                            },
                            child: const Text('Add Inventory',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 17)),
                          );
                        },
                      ),
                      h40,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
